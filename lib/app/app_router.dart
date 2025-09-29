import 'package:go_router/go_router.dart';
import 'package:tes/features/auth/login_screen.dart';
import 'package:tes/features/auth/register_screen.dart';
import 'package:tes/features/auth/splash_screen.dart';
import 'package:tes/features/home/home_screen.dart';
import 'package:tes/features/notification/notification_screen.dart';
import 'package:tes/features/profile/profile_screen.dart';
import 'package:tes/features/settings/settings_screen.dart';
import 'package:tes/features/complaints/admin_complaint_screen.dart';
import 'package:tes/features/announcements/announcement_screen.dart';
import 'package:tes/features/billing/user_bill_screen.dart';
import 'package:tes/features/billing/payment_history_screen.dart';

// Konfigurasi GoRouter
final appRouter = GoRouter(
  initialLocation: '/', // Rute awal aplikasi
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) => const ProfileScreen(),
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsScreen(),
    ),
    GoRoute(
      path: '/notification',
      builder: (context, state) => const NotificationScreen(),
    ),
    GoRoute(
      path: '/admin_complaints',
      builder: (context, state) => const AdminComplaintScreen(),
    ),
    GoRoute(
      path: '/announcements',
      builder: (context, state) => const AnnouncementScreen(),
    ),
    GoRoute(
      path: '/user_bills',
      builder: (context, state) => const UserBillScreen(),
    ),
    GoRoute(
      path: '/payment_history',
      builder: (context, state) => const PaymentHistoryScreen(),
    ),
  ],
);
