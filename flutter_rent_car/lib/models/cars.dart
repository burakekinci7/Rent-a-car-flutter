import 'package:flutter_rent_car/utils/database_helper.dart';

class Cars {
  String? licence;
  String? model;
  int? status; //sql vari tabanı boolean değerli true false diye kaydediyor
  int? hp;
  int? gear; //
  int? peopleNum;
  int? pricing;
  String? path; //image path

  Cars({
    this.licence,
    this.model,
    this.status,
    this.hp,
    this.gear,
    this.peopleNum,
    this.pricing,
    this.path,
  });

  Cars.fromMap(Map<dynamic, dynamic> json) {
    licence = json["licence"];
    model = json["model"];
    status = json["status"];
    hp = json["hp"];
    gear = json["gear"];
    peopleNum = json["peopleNum"];
    pricing = json["pricing"];
    path = json["path"];
  }
  //to map hapısı kullanılacak

  Map<String, dynamic> toJMap() {
    return {
      DataBaseHelper.columnlisance: licence,
      DataBaseHelper.columnModel: model,
      DataBaseHelper.columnstatus: status,
      DataBaseHelper.columnhp: hp,
      DataBaseHelper.columngear: gear,
      DataBaseHelper.columnpeopleNum: peopleNum,
      DataBaseHelper.columnpricing: pricing,
      DataBaseHelper.columnPath: path,
    };
  }
}
