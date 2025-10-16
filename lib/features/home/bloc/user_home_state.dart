part of 'user_home_bloc.dart';

@freezed
abstract class UserHomeState with _$UserHomeState {
  // State awal sebelum data mulai dimuat.
  const factory UserHomeState.initial() = _Initial;
  // State saat data sedang dalam proses pemuatan (untuk menampilkan loading indicator).
  const factory UserHomeState.loading() = _Loading;
  // State saat data berhasil dimuat dan siap ditampilkan di UI.
  const factory UserHomeState.loaded({
    // Menandakan apakah pengguna saat ini adalah penghuni atau tamu.
    required bool isTenant,
    // Pengumuman terbaru untuk ditampilkan di bagian atas.
    Announcement? latestAnnouncement,
    // Data kamar spesifik jika pengguna adalah penghuni.
    Room? userRoom,
    // Data tagihan terakhir jika pengguna adalah penghuni.
    Bill? latestBill,
    // Daftar semua kamar jika pengguna adalah tamu.
    required List<Room> allRooms,
  }) = _Loaded;
  // State jika terjadi kesalahan saat memuat data.
  const factory UserHomeState.error(String message) = _Error;
}
