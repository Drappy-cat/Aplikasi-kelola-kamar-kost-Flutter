class Room {
  // Properti (Data)
  final String code;
  String status;
  final int baseRent;
  final int wifi;
  final int water;
  final int electricity;
  final int acCost;
  bool packageFull;
  final String dimensions;
  final List<String> imageUrls;

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
