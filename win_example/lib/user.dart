import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'user.g.dart';

@HiveType(typeId: 1)
class User extends HiveObject {
  User({required this.email, required this.password});
  @HiveField(0)
  late String email;

  @HiveField(1)
  late String password;
}
