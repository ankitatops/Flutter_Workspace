class Student {
  final String name;
  final String email;
  final String password;

  Student({required this.name, required this.email, required this.password});

  static List<Student> registeredStudents = [];
}
