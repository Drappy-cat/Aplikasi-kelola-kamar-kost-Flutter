class AppUser {
  String username;
  String password;
  final String role;
  String? fullName;
  String? profileImageUrl;

  AppUser({
    required this.username,
    required this.password,
    required this.role,
    this.fullName,
    this.profileImageUrl,
  });

  Map<String, dynamic> toJson() => {
    'username': username,
    'password': password,
    'role': role,
    'fullName': fullName,
    'profileImageUrl': profileImageUrl,
  };

  factory AppUser.fromJson(Map<String, dynamic> j) => AppUser(
    username: j['username'],
    password: j['password'],
    role: j['role'],
    fullName: j['fullName'],
    profileImageUrl: j['profileImageUrl'],
  );
}
