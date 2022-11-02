class Cars {
  String? licence;
  String? model;
  bool? status;
  int? hp;
  bool? gear;
  int? peopleNum;
  int? pricing;
  //image yapılacak

  Cars({
    this.licence,
    this.model,
    this.status,
    this.hp,
    this.gear,
    this.peopleNum,
    this.pricing,
  });

  Cars.fromMap(Map<String, dynamic> json) {
    licence = json["licence"];
    model = json["model"];
    status = json["status"];
    hp = json["hp"];
    gear = json["gear"];
    peopleNum = json["peopleNum"];
    pricing = json["pricing"];
  }
  //to map hapısı kullanılacak
}
