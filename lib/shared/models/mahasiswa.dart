import './person.dart';

class Mahasiswa extends Person {
  final String nim;

  Mahasiswa({
    required super.id,
    required super.nama,
    required super.email,
    required this.nim,
  });

  @override
  String getGelar() {
    return "Mahasiswa";
  }
}
