import 'package:flutter_rent_car/utils/user_database.dart';

class User {
  String? name;
  String? surName;
  int? phoneNumber;

  User({
    required this.name,
    required this.surName,
    required this.phoneNumber,
  });

  User.fromMap(Map<dynamic, dynamic> json) {
    name = json["name"];
    surName = json["surname"];
    phoneNumber = json["phoneNumber"];
  }

  Map<dynamic, dynamic> toUserMap() {
    return {
      UserdataBase.nameColumn: name,
      UserdataBase.surNameColumn: surName,
      UserdataBase.phoneNumberColumn: phoneNumber
    };
  }
}
