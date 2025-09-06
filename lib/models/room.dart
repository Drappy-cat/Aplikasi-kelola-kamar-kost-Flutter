class Room {
  final String code;
  String status; // Dihuni / Kosong / Booked / Maintenance
  final int baseRent;
  final int wifi;
  final int water;
  final int electricity;
  final bool packageFull; // true = utilitas termasuk

  // <-- BUKAN final lagi supaya bisa diubah saat “Kosongkan Hunian”
  String? tenantName;
  String? tenantAddress;
  String? tenantPhone;

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
  });
}
