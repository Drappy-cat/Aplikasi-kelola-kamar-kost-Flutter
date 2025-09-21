// ===== 6. ENCAPSULATION (ENKAPSULASI) & 9. KONSEP OOP =====
// Encapsulation berarti membungkus data (properti) dan metode (fungsi) yang beroperasi
// pada data tersebut ke dalam satu unit tunggal yang disebut "Kelas" (Class).
// Kelas `Room` ini adalah contoh sempurna dari enkapsulasi.

// 1. DATA DIBUNGKUS: Semua data yang terkait dengan sebuah kamar, seperti `code`,
//    `status`, `baseRent`, dll., dibungkus di dalam kelas `Room` ini.
// 2. KONTROL AKSES: Dengan menggunakan `final`, kita mencegah beberapa properti
//    (seperti `code`) diubah setelah objek dibuat. Ini adalah bentuk kontrol akses
//    sederhana untuk memastikan integritas data.

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

  // Constructor (Metode untuk membuat objek)
  // Ini adalah "pintu masuk" untuk membuat instance dari kelas Room.
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
