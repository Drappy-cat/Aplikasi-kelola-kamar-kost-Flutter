import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tes/features/home/bloc/admin_panel_bloc.dart';
import 'package:tes/features/home/bloc/user_home_bloc.dart';
import 'package:tes/shared/services/auth_service.dart';
import 'package:tes/shared/services/dummy_service.dart';
import 'package:tes/shared/services/language_service.dart';
import 'package:tes/shared/services/notification_service.dart';
import 'package:tes/shared/services/theme_service.dart';

// Instance global dari GetIt untuk service locator.
final getIt = GetIt.instance;

/// Fungsi ini mendaftarkan semua service dan BLoC yang dibutuhkan oleh aplikasi.
/// Ini adalah pusat dari Dependency Injection, yang dipanggil sekali saat aplikasi dimulai.
Future<void> setupLocator() async {
  // 1. Daftarkan SharedPreferences sebagai Singleton.
  //    Instance ini akan dibuat sekali dan digunakan di seluruh aplikasi.
  final prefs = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(prefs);

  // 2. Daftarkan service yang perlu inisialisasi data saat startup sebagai Singleton.
  final dummyService = DummyService(prefs);
  await dummyService.init();
  getIt.registerSingleton<DummyService>(dummyService);

  final authService = AuthService();
  await authService.init();
  getIt.registerSingleton<AuthService>(authService);

  final notificationService = NotificationService();
  await notificationService.init();
  getIt.registerSingleton<NotificationService>(notificationService);

  // 3. Daftarkan service lain sebagai LazySingleton.
  //    Instance baru hanya akan dibuat saat service tersebut pertama kali diakses.
  getIt.registerLazySingleton(() => ThemeService(prefs));
  getIt.registerLazySingleton(() => LanguageService(prefs));

  // 4. Daftarkan BLoC sebagai Factory.
  //    Instance BLoC yang baru akan dibuat setiap kali di-request.
  getIt.registerFactory(() => UserHomeBloc());
  getIt.registerFactory(() => AdminPanelBloc());
}
