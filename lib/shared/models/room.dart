import 'package:freezed_annotation/freezed_annotation.dart';

part 'room.freezed.dart';
part 'room.g.dart';

/// Model data untuk merepresentasikan satu unit kamar kost.
/// Menggunakan Freezed untuk pembuatan kode boilerplate secara otomatis.
@freezed
class Room with _$Room {
  // Constructor privat diperlukan oleh Freezed untuk menambahkan metode kustom seperti getter.
  const Room._();

  const factory Room({
    // --- Detail Utama Kamar ---
    required String code, // Kode unik kamar, misal: A-101
    required String status, // Status ketersediaan: "Kosong", "Dihuni", "Booked", "Maintenance"
    @Default('N/A') String dimensions, // Ukuran kamar, misal: "3x4 m"
    @Default([]) List<String> imageUrls, // Daftar path atau URL gambar kamar

    // --- Detail Biaya Sewa (per bulan) ---
    required int baseRent, // Harga sewa dasar
    required int wifi, // Biaya Wi-Fi
    required int water, // Biaya Air
    required int electricity, // Biaya Listrik
    @Default(0) int acCost, // Biaya tambahan jika menggunakan AC
    @Default(false) bool packageFull, // Menandakan apakah harga sewa sudah termasuk semua utilitas

    // --- Detail Fasilitas ---
    @Default(false) bool isFurnished, // Apakah kamar dilengkapi furnitur
    @Default(1) int jumlahKasur, // Jumlah kasur yang tersedia
    String? fasilitasTambahan, // Fasilitas lain, misal: "Meja, Lemari"

    // --- Detail Penghuni (jika ada) ---
    String? tenantName,
    String? tenantAddress,
    String? tenantPhone,
    String? rentStartDate,
  }) = _Room;

  /// Factory constructor untuk membuat instance Room dari JSON.
  factory Room.fromJson(Map<String, dynamic> json) => _$RoomFromJson(json);

  /// Getter kustom untuk menghitung total harga sewa bulanan.
  int get totalPrice {
    // Jika paket sudah "full", maka total harga adalah harga dasar saja.
    if (packageFull) return baseRent;
    // Jika tidak, total harga adalah jumlah dari semua biaya.
    return baseRent + wifi + water + electricity + acCost;
  }
}
