class AppUser {
  String username;
  String password;
  final String role;
  String? fullName;
  String? profileImageUrl; // <-- FIELD BARU UNTUK FOTO PROFIL

  AppUser({
    required this.username,
    required this.password,
    required this.role,
    this.fullName,
    this.profileImageUrl, // <-- DITAMBAHKAN DI CONSTRUCTOR
  });

  // Fungsi untuk mengubah objek menjadi format JSON (untuk disimpan)
  Map<String, dynamic> toJson() => {
    'username': username,
    'password': password,
    'role': role,
    'fullName': fullName,
    'profileImageUrl': profileImageUrl, // <-- DITAMBAHKAN UNTUK PENYIMPANAN
  };

  // Fungsi untuk membuat objek dari format JSON (untuk dibaca)
  factory AppUser.fromJson(Map<String, dynamic> j) => AppUser(
    username: j['username'],
    password: j['password'],
    role: j['role'],
    fullName: j['fullName'],
    profileImageUrl: j['profileImageUrl'], // <-- DITAMBAHKAN UNTUK MEMBACA
  );
}
