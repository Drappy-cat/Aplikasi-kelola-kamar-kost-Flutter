abstract class Person {
  final String id;
  final String nama;
  final String email;

  Person({required this.id, required this.nama, required this.email});

  String getGelar();
}
