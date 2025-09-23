class AppUser {
  final String id; // <-- DITAMBAHKAN
  String username;
  String password;
  final String role;
  String? fullName;
  String? profileImageUrl;
  String? roomId;

  AppUser({
    required this.id, // <-- DITAMBAHKAN
    required this.username,
    required this.password,
    required this.role,
    this.fullName,
    this.profileImageUrl,
    this.roomId,
  });

  Map<String, dynamic> toJson() => {
    'id': id, // <-- DITAMBAHKAN
    'username': username,
    'password': password,
    'role': role,
    'fullName': fullName,
    'profileImageUrl': profileImageUrl,
    'roomId': roomId,
  };

  factory AppUser.fromJson(Map<String, dynamic> j) => AppUser(
    id: j['id'], // <-- DITAMBAHKAN
    username: j['username'],
    password: j['password'],
    role: j['role'],
    fullName: j['fullName'],
    profileImageUrl: j['profileImageUrl'],
    roomId: j['roomId'],
  );
}
