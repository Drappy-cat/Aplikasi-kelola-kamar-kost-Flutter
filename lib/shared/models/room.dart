class Room {
  final String code;
  String status;
  final int baseRent;
  final int wifi;
  final int water;
  final int electricity;
  final int acCost;
  bool packageFull;
  final String dimensions; // Dimensi kamar, cth: '3x4 m'
  final List<String> imageUrls; // Daftar URL gambar

  String? tenantName;
  String? tenantAddress;
  String? tenantPhone;
  String? rentStartDate;

  Room({
    required this.code,
    required this.status,
    required this.baseRent,
    required this.wifi,
    required this.water,
    required this.electricity,
    this.acCost = 0,
    this.packageFull = false,
    this.dimensions = 'N/A',
    this.imageUrls = const [],
    this.tenantName,
    this.tenantAddress,
    this.tenantPhone,
    this.rentStartDate,
  });
}
