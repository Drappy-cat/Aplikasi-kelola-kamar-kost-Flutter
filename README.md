# Ri-Kost - Aplikasi Manajemen Kost Berbasis Flutter

Aplikasi manajemen kost (boarding house) modern yang dibangun menggunakan Flutter. Ri-Kost dirancang untuk menjembatani komunikasi dan transaksi antara pemilik kost (Admin) dan penyewa (User) dalam satu platform yang terintegrasi dan mudah digunakan.

> **Catatan:** Ganti link di atas dengan screenshot atau GIF demo aplikasi Anda agar lebih menarik.

---

## 🌟 Tentang Proyek

Proyek ini bertujuan untuk mendigitalisasi proses manajemen kost yang seringkali masih manual. Dengan Ri-Kost, pemilik kost dapat dengan mudah mengelola data kamar, memproses pengajuan sewa, dan melihat status penghuni. Di sisi lain, calon penyewa dapat dengan mudah menjelajahi kamar yang tersedia, mengajukan sewa, dan mengelola profil mereka dalam satu aplikasi yang intuitif.

Aplikasi ini dibangun dengan fokus pada **pemisahan peran (role-based access)**, **pengalaman pengguna (UX)** yang bersih, dan **integrasi data** yang mulus antara panel admin dan pengguna.

---

## ✨ Fitur Utama

### 👨‍💼 Untuk Pengguna (Penyewa)
- **Autentikasi Pengguna:** Sistem registrasi dan login yang aman.
- **Jelajah Kamar:** Melihat semua daftar kamar dengan tampilan kartu yang informatif.
- **Filter Kamar:** Memfilter kamar berdasarkan status ("Semua", "Kosong", "Booked", "Dihuni") untuk pencarian yang lebih cepat.
- **Detail Kamar:** Melihat halaman detail untuk setiap kamar, lengkap dengan:
  - **Galeri Gambar:** *Image carousel* yang bisa digeser untuk melihat foto-foto kamar.
  - Informasi lengkap mengenai dimensi, fasilitas, dan harga.
- **Pengajuan Sewa:** Mengajukan sewa melalui dialog interaktif yang berisi:
  - Formulir data diri (Nama, Alamat, No. Telepon).
  - Pilihan paket sewa (Lengkap / Mandiri).
  - Opsi penambahan fasilitas (AC).
  - Rincian biaya yang transparan dan ter-update secara dinamis.
- **Manajemen Profil:**
  - **Ubah Foto Profil:** Memilih avatar dari beberapa opsi default.
  - **Edit Nama Lengkap:** Memperbarui nama yang ditampilkan di aplikasi.
  - **Ubah Password:** Mengganti password akun dengan aman.
- **Sistem Notifikasi:** Menerima notifikasi untuk setiap status pengajuan (diajukan, disetujui, ditolak).

### 👑 Untuk Admin (Pemilik Kost)
- **Dasbor Admin:** Panel khusus dengan 3 tab utama: Kamar, Tagihan, dan Pengajuan.
- **Manajemen Kamar:** Melihat daftar semua kamar beserta statusnya ("Kosong", "Booked", "Dihuni").
- **Manajemen Pengajuan:**
  - Melihat semua pengajuan sewa yang masuk dari pengguna.
  - **Menyetujui** atau **Menolak** pengajuan.
  - Saat pengajuan disetujui, status kamar otomatis berubah dari "Booked" menjadi "Dihuni".
- **Akses Profil & Notifikasi:** Admin juga memiliki halaman profil dan notifikasi sendiri.

### ⚙️ Fitur Umum
- **UI Modern:** Menggunakan font **Poppins** untuk tampilan yang bersih dan modern.
- **Tema Ganda:** Opsi untuk beralih antara **Mode Terang (Light Mode)** dan **Mode Gelap (Dark Mode)**.
- **Splash Screen Animasi:** Tampilan pembuka aplikasi dengan logo dan nama "Ri-Kost" yang dianimasikan.
- **Struktur Kode Bersih:** Mengikuti prinsip-prinsip desain perangkat lunak yang baik, termasuk pemisahan fitur dan layanan.

---

## 🛠️ Dibangun Dengan

- **Framework:** Flutter
- **Bahasa:** Dart
- **Manajemen State:** `StatefulWidget` & `setState`
- **Paket Utama:**
  - `google_fonts`: Untuk implementasi font kustom (Poppins).
  - `shared_preferences`: Untuk menyimpan data sesi login secara lokal.
  - `intl`: Untuk memformat angka menjadi format mata uang Rupiah.

---

## 🚀 Memulai Proyek

Untuk menjalankan proyek ini secara lokal, ikuti langkah-langkah berikut:

### Prasyarat
Pastikan Anda sudah menginstal Flutter SDK di komputer Anda. Untuk panduan instalasi, silakan kunjungi [dokumentasi resmi Flutter](https://flutter.dev/docs/get-started/install).

### Instalasi
1. **Clone repositori ini:**
   ```sh
   git clone https://github.com/your-username/your-repo.git
   ```

2. **Masuk ke direktori proyek:**
   ```sh
   cd ri-kost
   ```

3. **Instal semua dependensi:**
   ```sh
   flutter pub get
   ```

4. **Jalankan aplikasi:**
   ```sh
   flutter run
   ```

### Akun Default
Aplikasi ini memiliki satu akun admin default untuk keperluan demonstrasi:
- **Username:** `admin`
- **Password:** `admin123`

---

## 🎓 Konsep OOP yang Diterapkan

Proyek ini menerapkan beberapa pilar utama dari Pemrograman Berorientasi Objek (OOP):

1.  **Encapsulation (Enkapsulasi):**
    - **Contoh:** Kelas-kelas model seperti `Room`, `AppUser`, dan `AppNotification` membungkus semua data (properti) dan perilaku (metode/konstruktor) yang relevan ke dalam satu unit tunggal. Ini membuat data lebih terstruktur dan mudah dikelola.

2.  **Inheritance (Pewarisan):**
    - **Contoh:** Semua kelas halaman (seperti `LoginScreen`, `AdminPanel`, `ProfileScreen`) adalah turunan (`extends`) dari kelas dasar Flutter, yaitu `StatefulWidget` atau `StatelessWidget`. Mereka mewarisi semua fungsionalitas inti dari widget Flutter.

3.  **Polymorphism (Polimorfisme):**
    - **Contoh:** Penggunaan anotasi `@override` pada metode `build(BuildContext context)` di setiap kelas widget. Setiap kelas menyediakan implementasi `build`-nya sendiri untuk merender UI yang unik, meskipun semuanya berbagi "kontrak" yang sama dari kelas induknya.

4.  **Abstraction (Abstraksi):**
    - **Contoh:** Kelas `AuthService` dan `DummyService`. Kode di UI (misalnya, `LoginScreen`) hanya perlu memanggil `AuthService.signIn()`, tanpa perlu tahu *bagaimana* proses verifikasi dan penyimpanan data dilakukan di dalamnya. Detail implementasi yang kompleks disembunyikan.

---

## 👤 Kredit

Aplikasi ini dibuat dengan ❤️ oleh:

**Rizma Indra**

© 2025
