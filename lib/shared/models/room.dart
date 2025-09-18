class Room {
  final String code;
  // DIUBAH: Properti status dibuat privat
  String _status;

  final int baseRent;
  final int wifi;
  final int water;
  final int electricity;
  final bool packageFull;

  String? tenantName;
  String? tenantAddress;
  String? tenantPhone;
  String? rentStartDate;

  // DIUBAH: Getter publik untuk mengakses _status
  String get status => _status;

  // DIUBAH: Setter publik untuk mengubah _status
  set status(String newStatus) {
    // Di sini kita bisa menambahkan logika, validasi, atau logging di masa depan
    // Contoh: print('Status kamar $code diubah menjadi $newStatus');
    _status = newStatus;
  }

  Room({
    required this.code,
    required String status, // Terima status sebagai parameter biasa
    required this.baseRent,
    required this.wifi,
    required this.water,
    required this.electricity,
    this.packageFull = false,
    this.tenantName,
    this.tenantAddress,
    this.tenantPhone,
    this.rentStartDate,
  }) : _status = status; // Gunakan initializer list untuk mengisi _status
}
