import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 1)
class User {
  @HiveField(0)
  String name;
  @HiveField(1)
  String message;
  @HiveField(2)
  int code;
  @HiveField(3)
  String userId;
  @HiveField(4)
  String userName;
  @HiveField(5)
  String userPhone;

  User.fromJson(Map<String, dynamic> map)
      : name = map["name"],
        message = map["message"],
        code = map["code"],
        userId = map["user_id"],
        userName = map["username"],
        userPhone = map["user_phone"];

  User({
    this.name,
    this.message,
    this.code,
    this.userId,
    this.userName,
    this.userPhone,
  });

  @override
  String toString() =>
      'User{userId: $userId, userName: $userName, userPhone: $userPhone}';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          message == other.message &&
          code == other.code &&
          userId == other.userId &&
          userName == other.userName &&
          userPhone == other.userPhone;

  @override
  int get hashCode =>
      name.hashCode ^
      message.hashCode ^
      code.hashCode ^
      userId.hashCode ^
      userName.hashCode ^
      userPhone.hashCode;
}
