// ===== 6. ENCAPSULATION (ENKAPSULASI) & 9. KONSEP OOP =====
// Sama seperti kelas `Room`, kelas `Bill` ini juga merupakan contoh
// dari konsep enkapsulasi dalam OOP.

// 1. DATA DIBUNGKUS: Semua data yang terkait dengan sebuah tagihan (bill),
//    seperti `id`, `roomCode`, `month`, `total`, dll., dibungkus menjadi
//    satu kesatuan di dalam kelas `Bill`.
// 2. KESATUAN: Dengan membungkusnya, kita tahu bahwa semua properti ini
//    milik satu entitas tunggal, yaitu "Tagihan". Ini membuat kode lebih
//    terstruktur dan mudah dikelola.

class Bill {
  // Properti (Data)
  final String id;
  final String roomCode;
  final String month;
  final String dueDate;
  final int total;
  String status;
  String? method;
  String? channel;

  // Constructor (Metode untuk membuat objek)
  Bill({
    required this.id,
    required this.roomCode,
    required this.month,
    required this.dueDate,
    required this.total,
    required this.status,
    this.method,
    this.channel,
  });
}
