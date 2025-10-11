import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tes/features/home/bloc/admin_panel_bloc.dart';
import 'package:tes/features/home/bloc/user_home_bloc.dart';
import 'package:tes/shared/services/auth_service.dart';
import 'package:tes/shared/services/dummy_service.dart';
import 'package:tes/shared/services/language_service.dart'; // <-- IMPORT BARU
import 'package:tes/shared/services/theme_service.dart';

final getIt = GetIt.instance;

Future<void> setupLocator() async {
  // 1. Daftarkan SharedPreferences
  final prefs = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(prefs);

  // 2. Inisialisasi dan daftarkan DummyService
  final dummyService = DummyService(prefs);
  await dummyService.init();
  getIt.registerSingleton<DummyService>(dummyService);

  // 3. Inisialisasi dan daftarkan AuthService
  final authService = AuthService();
  await authService.init();
  getIt.registerSingleton<AuthService>(authService);

  // 4. Daftarkan service lainnya
  getIt.registerLazySingleton(() => ThemeService(prefs));
  getIt.registerLazySingleton(() => LanguageService(prefs)); // <-- DAFTARKAN SERVICE BARU

  // 5. Daftarkan BLoC sebagai Factory
  getIt.registerFactory(() => UserHomeBloc());
  getIt.registerFactory(() => AdminPanelBloc());
}
