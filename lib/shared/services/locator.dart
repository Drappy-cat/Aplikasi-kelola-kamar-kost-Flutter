import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tes/shared/services/auth_service.dart';
import 'package:tes/shared/services/dummy_service.dart';
import 'package:tes/shared/services/theme_service.dart';

// Membuat instance global dari GetIt
final getIt = GetIt.instance;

Future<void> setupLocator() async {
  // Daftarkan SharedPreferences sebagai singleton karena akan digunakan oleh service lain
  final prefs = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(prefs);

  // Mendaftarkan service sebagai "Lazy Singleton".
  // Artinya, service hanya akan dibuat sekali, yaitu saat pertama kali diminta.
  getIt.registerLazySingleton(() => AuthService());
  getIt.registerLazySingleton(() => DummyService());

  // Daftarkan ThemeService yang baru
  getIt.registerLazySingleton(() => ThemeService(getIt<SharedPreferences>()));
}
