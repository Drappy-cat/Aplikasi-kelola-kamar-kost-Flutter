/// Kelas ini berisi semua konstanta untuk nama rute yang digunakan di aplikasi.
/// Penggunaan kelas ini bertujuan untuk menghindari kesalahan ketik (typo)
/// dan memusatkan semua definisi rute di satu tempat.
class AppRoutes {
  // Private constructor untuk mencegah instance dari kelas ini dibuat.
  AppRoutes._();

  static const String splash = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
  static const String profile = '/profile';
  static const String settings = '/settings';
  static const String terms = '/terms';
  static const String help = '/help';
  static const String notification = '/notification';
  static const String adminComplaints = '/admin_complaints';
  static const String announcements = '/announcements';
  static const String userBills = '/user_bills';
  static const String paymentHistory = '/payment_history';
  static const String reportIssue = '/report_issue';
  static const String roomDetail = '/room_detail';
  static const String scanActivity = '/scan_activity';
  static const String chat = '/chat';
  static const String aboutApp = '/about_app'; // <-- RUTE BARU
}
