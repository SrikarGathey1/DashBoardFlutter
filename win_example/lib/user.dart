import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 1)
class User extends HiveObject {
  User({required this.email, required this.password});
  @HiveField(0)
  late String email;

  @HiveField(1)
  late String password;
}

@HiveType(typeId: 45)
class Patient extends HiveObject {
  Patient(
      {required this.first,
      required this.middle,
      required this.last,
      required this.dob,
      required this.gender,
      required this.phone,
      required this.uidai,
      required this.height,
      required this.weight,
      required this.email});

  @HiveField(9)
  late String first;

  @HiveField(10)
  late String middle;

  @HiveField(11)
  late String last;

  @HiveField(12)
  late String dob;

  @HiveField(13)
  late String gender;

  @HiveField(14)
  late int phone;

  @HiveField(15)
  late int uidai;

  @HiveField(16)
  late int height;

  @HiveField(17)
  late int weight;

  @HiveField(18)
  late String email;
}

@HiveType(typeId: 20)
class Record extends HiveObject {
  @HiveField(20)
  late int patientNumbers = 0;

  @HiveField(21)
  late int userNumbers = 0;

  Record({required this.patientNumbers, required this.userNumbers});
}
