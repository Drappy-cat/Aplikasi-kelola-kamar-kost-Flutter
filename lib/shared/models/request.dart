// ===== 6. ENCAPSULATION (ENKAPSULASI) & 9. KONSEP OOP =====
// Kelas `Request` ini juga merupakan contoh yang jelas dari enkapsulasi.

// 1. DATA DIBUNGKUS: Semua data yang relevan untuk sebuah "pengajuan" dari pengguna,
//    seperti `type` (jenis pengajuan), `date`, `note`, dan `status`, dibungkus
//    dalam satu kelas ini.
// 2. OBJEK YANG JELAS: Ketika kita membuat objek dari kelas `Request`, kita menciptakan
//    representasi konkret dari sebuah pengajuan. Ini membuat pengiriman data antar
//    bagian aplikasi (misalnya, dari `UserHomePage` ke `DummyService`) menjadi
//    jauh lebih rapi dan tidak rentan error, karena semua data yang dibutuhkan
//    sudah ada di dalam satu objek.

class Request {
  // Properti (Data)
  final String type;
  final String date;
  final String note;
  String status;
  final String? roomCode;
  final String? userName;

  // Constructor (Metode untuk membuat objek)
  Request({
    required this.type,
    required this.date,
    required this.note,
    required this.status,
    this.roomCode,
    this.userName,
  });
}
