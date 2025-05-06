import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
part 'user.g.dart';

@HiveType(typeId: 0)
class AppUser {
  AppUser(
      {required this.id,
      required this.name,
      required this.phone,
      this.token,
      this.fcmToken});

  @HiveField(0)
  int id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String phone;

  @HiveField(3)
  String? email;

  @HiveField(4)
  String? token;

  @HiveField(5)
  String? fcmToken;

  @override
  String toString() {
    return "{id: $id, name: $name, phone: $phone, email: $email, token: $token, fcmToken: $fcmToken}";
  }
}
