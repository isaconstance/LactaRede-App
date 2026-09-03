class PontosColeta {
  final String name;
  final String address;
  final double distanciaKm; // valor fixo, usado só como fallback quando a localização real não está disponível
  final double latitude;
  final double longitude;

  const PontosColeta({
    required this.name,
    required this.address,
    required this.distanciaKm,
    required this.latitude,
    required this.longitude,
  });
}