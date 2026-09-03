import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import '../models/pontos_coleta.dart';

/// Resultado do carregamento de localização
class LocationResult {
  final LatLng? userLocation;
  final List<PointWithDistance> sortedPoints;
  final String? errorMessage;

  const LocationResult({
    required this.userLocation,
    required this.sortedPoints,
    this.errorMessage,
  });
}

/// Junta cada ponto fixo com a distância real calculada a partir da localização do usuário ou null caso a localização não esteja disponível.
class PointWithDistance {
  final PontosColeta point;
  final double? distanceKm;
  const PointWithDistance(this.point, this.distanceKm);
}

/// Serviço responsável por pedir a localização do usuário e calcular a distância até cada ponto de coleta.
class LocationService {
  final _distanceCalculator = const Distance();

  Future<LocationResult> loadUserLocationAndSortPoints(List<PontosColeta> points) async {
    try {
      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        return LocationResult(
          userLocation: null,
          sortedPoints: points.map((p) => PointWithDistance(p, null)).toList(),
          errorMessage: 'Permissão de localização negada. Mostrando distâncias aproximadas.',
        );
      }

      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return LocationResult(
          userLocation: null,
          sortedPoints: points.map((p) => PointWithDistance(p, null)).toList(),
          errorMessage: 'Ative a localização do dispositivo para ver distâncias reais.',
        );
      }

      final position = await Geolocator.getCurrentPosition();
      final userLatLng = LatLng(position.latitude, position.longitude);

      final withDistances = points.map((p) {
        final km = _distanceCalculator.as(
          LengthUnit.Kilometer,
          userLatLng,
          LatLng(p.latitude, p.longitude),
        );
        return PointWithDistance(p, km);
      }).toList()
        ..sort((a, b) => a.distanceKm!.compareTo(b.distanceKm!));

      return LocationResult(
        userLocation: userLatLng,
        sortedPoints: withDistances,
      );
    } catch (e) {
      return LocationResult(
        userLocation: null,
        sortedPoints: points.map((p) => PointWithDistance(p, null)).toList(),
        errorMessage: 'Não foi possível obter sua localização. Mostrando distâncias aproximadas.',
      );
    }
  }
}