class User {
  final String id;
  final String name;
  final String email;
  final String role; // 'student', 'admin', 'operator'

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
  });
}

class Admin extends User {
  final String department;
  final List<String> permissions;

  Admin({
    required super.id,
    required super.name,
    required super.email,
    required this.department,
    required this.permissions,
  }) : super(role: 'admin');
}

class Student extends User {
  final String studentId;
  final String course;

  Student({
    required super.id,
    required super.name,
    required super.email,
    required this.studentId,
    required this.course,
  }) : super(role: 'student');
}

class Operator extends User {
  final String canteenId;
  final String shift;

  Operator({
    required super.id,
    required super.name,
    required super.email,
    required this.canteenId,
    required this.shift,
  }) : super(role: 'operator');
}
