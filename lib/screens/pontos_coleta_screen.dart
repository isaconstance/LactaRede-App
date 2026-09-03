import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import '../theme/app_theme.dart';
import '../data/pontos_coleta_data.dart';
import '../models/pontos_coleta.dart';

const _stadiaApiKey = '62d3332e-b75b-46b2-819f-039d5ebc9ae0';

// junta cada ponto fixo com a distância real calculada a partir da
// localização do usuário (ou null, enquanto ainda não temos a localização).
class _PointWithDistance {
  final PontosColeta point;
  final double? distanceKm;
  const _PointWithDistance(this.point, this.distanceKm);
}

class PontosColetaScreen extends StatefulWidget {
  const PontosColetaScreen({super.key});

  @override
  State<PontosColetaScreen> createState() => _CollectionPointsScreenState();
}

class _CollectionPointsScreenState extends State<PontosColetaScreen> {
  final _mapController = MapController();
  final _distanceCalculator = const Distance();

  PontosColeta _selectedPoint = pontosColeta[0];
  List<_PointWithDistance> _sortedPoints = pontosColeta.map((p) => _PointWithDistance(p, null)).toList(); 
  bool _loadingLocation = true; 
  String? _locationError; 
  LatLng? _userLocation;

  static final _center = LatLng(
    pontosColeta[0].latitude,
    pontosColeta[0].longitude,
  );

  @override
  void initState() {
    super.initState();
    _loadUserLocation(); 
  }

  // pede a localização do usuário e recalcula as distâncias reais.
  Future<void> _loadUserLocation() async {
    try {
      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        setState(() {
          _loadingLocation = false;
          _locationError = 'Permissão de localização negada. Mostrando distâncias aproximadas.';
        });
        return;
      }

      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        setState(() {
          _loadingLocation = false;
          _locationError = 'Ative a localização do dispositivo para ver distâncias reais.';
        });
        return;
      }

      final position = await Geolocator.getCurrentPosition();
      final userLatLng = LatLng(position.latitude, position.longitude);

      final withDistances = pontosColeta.map((p) {
        final km = _distanceCalculator.as(
          LengthUnit.Kilometer,
          userLatLng,
          LatLng(p.latitude, p.longitude),
        );
        return _PointWithDistance(p, km);
      }).toList()
        ..sort((a, b) => a.distanceKm!.compareTo(b.distanceKm!));

      setState(() {
        _sortedPoints = withDistances;
        _selectedPoint = withDistances.first.point;
        _userLocation = userLatLng;
        _loadingLocation = false;
      });

      WidgetsBinding.instance.addPostFrameCallback((_) => _fitMapToShowEverything());
    } catch (e) {
      setState(() {
        _loadingLocation = false;
        _locationError = 'Não foi possível obter sua localização. Mostrando distâncias aproximadas.';
      });
    }
  }

  void _selectPoint(PontosColeta point) {
    setState(() => _selectedPoint = point);
    _mapController.move(LatLng(point.latitude, point.longitude), 14);
  }

  void _fitMapToShowEverything() {
    final allPoints = [
      if (_userLocation != null) _userLocation!,
      for (final item in _sortedPoints) LatLng(item.point.latitude, item.point.longitude),
    ];
    if (allPoints.isEmpty) return;

    final bounds = LatLngBounds.fromPoints(allPoints);
    _mapController.fitCamera(
      CameraFit.bounds(bounds: bounds, padding: const EdgeInsets.all(40)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
        title: Text('Pontos de coleta', style: Theme.of(context).textTheme.titleLarge),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 240,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
              child: Stack(
                children: [
                  FlutterMap(
                    mapController: _mapController,
                    options: MapOptions(
                      initialCenter: _center,
                      initialZoom: 12,
                    ),
                    children: [
                      TileLayer(
                        urlTemplate:
                            'https://tiles.stadiamaps.com/tiles/alidade_smooth/{z}/{x}/{y}{r}.png?api_key=$_stadiaApiKey',
                        userAgentPackageName: 'com.lactarede.app',
                      ),
                      MarkerLayer(
                        markers: [
                          for (final item in _sortedPoints)
                            Marker(
                              point: LatLng(item.point.latitude, item.point.longitude),
                              width: 40,
                              height: 40,
                              child: GestureDetector(
                                onTap: () => _selectPoint(item.point),
                                child: Icon(
                                  Icons.location_on,
                                  color: item.point == _selectedPoint
                                      ? AppColors.danger
                                      : AppColors.primary,
                                  size: 36,
                                ),
                              ),
                            ),
                        ],
                      ),
                      // marcador da loc do usuario
                      if (_userLocation != null)
                      MarkerLayer(
                        markers: [
                          Marker(
                          point: _userLocation!,
                          width: 26,
                          height: 26,
                          child: const _UserLocationDot(),
                          ),
                        ],
                      ),
                    ],
                  ),
                  // botões de zoom +/- 
                  Positioned(
                    right: 12,
                    bottom: 12,
                    child: Column(
                      children: [
                        _ZoomButton(
                          icon: Icons.add,
                          onTap: () {
                            final zoom = _mapController.camera.zoom;
                            _mapController.move(_mapController.camera.center, zoom + 1);
                          },
                        ),
                        const SizedBox(height: 8),
                        _ZoomButton(
                          icon: Icons.remove,
                          onTap: () {
                            final zoom = _mapController.camera.zoom;
                            _mapController.move(_mapController.camera.center, zoom - 1);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // 
          if (_loadingLocation)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: SizedBox(
                height: 16,
                width: 16,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            )
          else if (_locationError != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                _locationError!,
                style: Theme.of(context).textTheme.labelSmall,
                textAlign: TextAlign.center,
              ),
            ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
              itemCount: _sortedPoints.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, i) {
                final item = _sortedPoints[i];
                return _PointCard(
                  point: item.point,
                  //usa a distância real quando disponível, senão cai no valor fixo do arquivo de dados.
                  distanceKm: item.distanceKm ?? item.point.distanciaKm,
                  isReal: item.distanceKm != null, // NOVO
                  selected: item.point == _selectedPoint,
                  onTap: () => _selectPoint(item.point),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _PointCard extends StatelessWidget {
  final PontosColeta point;
  final double distanceKm;
  final bool isReal; 
  final bool selected;
  final VoidCallback onTap;

  const _PointCard({
    required this.point,
    required this.distanceKm,
    required this.isReal,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(AppRadius.card),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadius.card),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadius.card),
            border: Border.all(
              color: selected ? AppColors.primary : Colors.transparent,
              width: 1.5,
            ),
            boxShadow: AppShadows.card,
          ),
          child: Row(
            children: [
              Icon(Icons.location_on, color: AppColors.primary, size: 22),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(point.name, style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 3),
                    Text(point.address, style: Theme.of(context).textTheme.bodyMedium),
                    const SizedBox(height: 4),
                    Text(
                      // "~" antes do km quando a distância é só aproximada.
                      '${isReal ? '' : '~'}${distanceKm.toStringAsFixed(1)} km',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: AppColors.textMuted),
            ],
          ),
        ),
      ),
    );
  }
}

// widget reutilizável do botãozinho circular de zoom (+/-).
class _ZoomButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _ZoomButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      shape: const CircleBorder(),
      elevation: 3,
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Icon(icon, size: 20, color: AppColors.primaryDark),
        ),
      ),
    );
  }
}

class _UserLocationDot extends StatelessWidget{
  const _UserLocationDot();

  @override
  Widget build(BuildContext context){
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 26,
          height: 26,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.primary.withValues(alpha: 0.2),
          ),
        ),
        Container(
          width: 14,
          height: 14,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.primary,
            border: Border.all(color: Colors.white, width: 2.5),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.25),
                blurRadius: 4,
                offset: Offset(0, 1),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
