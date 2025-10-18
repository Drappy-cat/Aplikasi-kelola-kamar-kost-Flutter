import 'package:go_router/go_router.dart';
import 'package:tes/app/app_routes.dart';
import 'package:tes/features/about/about_app_page.dart';
import 'package:tes/features/activity_log/scan_screen.dart';
import 'package:tes/features/auth/login_screen.dart';
import 'package:tes/features/auth/register_screen.dart';
import 'package:tes/features/auth/splash_screen.dart';
import 'package:tes/features/chat/chat_screen.dart';
import 'package:tes/features/device_info/device_info_page.dart';
import 'package:tes/features/home/home_screen.dart';
import 'package:tes/features/home/room_detail_screen.dart';
import 'package:tes/features/notification/notification_screen.dart';
import 'package:tes/features/profile/profile_screen.dart';
import 'package:tes/features/settings/settings_screen.dart';
import 'package:tes/features/settings/terms_screen.dart';
import 'package:tes/features/settings/help_screen.dart';
import 'package:tes/features/complaints/admin_complaint_screen.dart';
import 'package:tes/features/complaints/report_issue_screen.dart';
import 'package:tes/features/announcements/announcement_screen.dart';
import 'package:tes/features/billing/user_bill_screen.dart';
import 'package:tes/features/billing/payment_history_screen.dart';
import 'package:tes/shared/models/room.dart';

final appRouter = GoRouter(
  initialLocation: AppRoutes.splash,
  routes: [
    GoRoute(
      path: AppRoutes.splash,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: AppRoutes.login,
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>?;
        final isRegistered = extra?['registered'] as bool? ?? false;
        return LoginScreen(isRegistered: isRegistered);
      },
    ),
    GoRoute(
      path: AppRoutes.register,
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: AppRoutes.home,
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: AppRoutes.profile,
      builder: (context, state) => const ProfileScreen(),
    ),
    GoRoute(
      path: AppRoutes.aboutApp,
      name: AppRoutes.aboutApp, // PERBAIKAN: Menambahkan nama
      builder: (context, state) => const AboutAppPage(),
    ),
    GoRoute(
      path: AppRoutes.deviceInfo,
      name: AppRoutes.deviceInfo, // PERBAIKAN: Menambahkan nama
      builder: (context, state) => const DeviceInfoPage(),
    ),
    GoRoute(
      path: AppRoutes.settings,
      builder: (context, state) => const SettingsScreen(),
    ),
    GoRoute(
      path: AppRoutes.terms,
      builder: (context, state) => const TermsScreen(),
    ),
    GoRoute(
      path: AppRoutes.help,
      builder: (context, state) => const HelpScreen(),
    ),
    GoRoute(
      path: AppRoutes.notification,
      builder: (context, state) => const NotificationScreen(),
    ),
    GoRoute(
      path: AppRoutes.adminComplaints,
      builder: (context, state) => const AdminComplaintScreen(),
    ),
    GoRoute(
      path: AppRoutes.announcements,
      builder: (context, state) => const AnnouncementScreen(),
    ),
    GoRoute(
      path: AppRoutes.userBills,
      builder: (context, state) => const UserBillScreen(),
    ),
    GoRoute(
      path: AppRoutes.paymentHistory,
      builder: (context, state) => const PaymentHistoryScreen(),
    ),
    GoRoute(
      path: AppRoutes.reportIssue,
      builder: (context, state) => const ReportIssueScreen(),
    ),
    GoRoute(
      path: AppRoutes.roomDetail,
      builder: (context, state) {
        final room = state.extra as Room?;
        if (room != null) {
          return RoomDetailScreen(room: room);
        } else {
          return const HomeScreen();
        }
      },
    ),
    GoRoute(
      path: AppRoutes.scanActivity,
      builder: (context, state) => const ScanScreen(),
    ),
    GoRoute(
      path: '${AppRoutes.chat}/:userId',
      name: AppRoutes.chat,
      builder: (context, state) {
        final userId = state.pathParameters['userId']!;
        final username = (state.extra as Map<String, dynamic>?)?['username'] as String? ?? 'Chat';
        return ChatScreen(
          recipientUserId: userId,
          recipientUsername: username,
        );
      },
    ),
  ],
);
