import 'package:get_it/get_it.dart';
import 'package:tes/shared/services/auth_service.dart';
import 'package:tes/shared/services/dummy_service.dart';

// Membuat instance global dari GetIt
final getIt = GetIt.instance;

void setupLocator() {
  // Mendaftarkan service sebagai "Lazy Singleton".
  // Artinya, service hanya akan dibuat sekali, yaitu saat pertama kali diminta.
  getIt.registerLazySingleton(() => AuthService());
  getIt.registerLazySingleton(() => DummyService());

  // Jika nanti Anda punya service lain, daftarkan di sini.
  // Contoh: getIt.registerLazySingleton(() => ApiService());
}
