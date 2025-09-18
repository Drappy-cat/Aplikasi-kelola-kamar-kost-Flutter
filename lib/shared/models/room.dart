class Room {
  final String code;
  String status;
  final int baseRent;
  final int wifi;
  final int water;
  final int electricity;
  final bool packageFull;

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
    this.packageFull = false,
    this.tenantName,
    this.tenantAddress,
    this.tenantPhone,
    this.rentStartDate,
  });
}
