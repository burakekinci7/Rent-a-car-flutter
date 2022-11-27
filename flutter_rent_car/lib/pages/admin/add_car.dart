import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_rent_car/models/cars.dart';
import 'package:flutter_rent_car/utils/database_helper.dart';
import 'package:image_picker/image_picker.dart';

class CarAdd extends StatefulWidget {
  const CarAdd({Key? key}) : super(key: key);

  @override
  State<CarAdd> createState() => _CarAddState();
}

class _CarAddState extends State<CarAdd> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  final dbHelper = DataBaseHelper.instance;
  List<Cars> carsAll = []; //all cars list

  TextEditingController licanceController = TextEditingController();
  TextEditingController carModelController = TextEditingController();
  TextEditingController hpController = TextEditingController();
  TextEditingController peopleController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  //gear - vites list
  final List<String> _gearContrl = ["Otomatik vites", "Manuel vites"];
  String selectedValu = "Otomatik vites";

  //stastus - durum
  final List<String> _statusControl = ["iyi", "kötü"];
  String selectedStatus = "iyi";

  //image
  File? image;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenwidth = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        key: _scaffoldkey,
        appBar: AppBar(
          title: const Text("Araba Ekleyiniz"),
          centerTitle: true,
          bottom: const TabBar(tabs: [
            Tab(
              text: "Araba Sil",
            ),
            Tab(
              text: "Araba Ekle",
            ),
          ]),
        ),
        body: TabBarView(
          children: [
            SizedBox(
              child: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: carsAll.length + 1,
                itemBuilder: (context, index) {
                  if (index == carsAll.length) {
                    return ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _queryAll();
                        });
                      },
                      child: const Text("Yenile"),
                    );
                  }
                  return Card(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                              height: 200,
                              color: Colors.grey,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.file(File(carsAll[index].path!)),
                              )),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            height: 200,
                            color: Colors.grey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                    "Aracın Plakası:\n" +
                                        carsAll[index].licence.toString(),
                                    style: const TextStyle(
                                        fontSize: 20, color: Colors.pink)),
                                Text(
                                  "Aracın Modeli:\n" +
                                      carsAll[index].model.toString(),
                                  style: const TextStyle(fontSize: 18),
                                ),
                                Text(
                                  "Araç Ücreti:\n" +
                                      carsAll[index].pricing.toString(),
                                  style: const TextStyle(
                                      fontSize: 16, color: Colors.white),
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                      _delete(
                                          carsAll[index].licence.toString());
                                      setState(() {
                                        _queryAll();
                                      });
                                    },
                                    child: const Text("Aracı Sil"))
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    shadowColor: Colors.pink,
                  );
                },
              ),
            ),
            Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    //TextField
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: licanceController,
                        maxLength: 11,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Plaka Bilgisini Giriniz",
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: carModelController,
                        maxLength: 30,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Arabanın Modelini Giriniz",
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: hpController,
                        maxLength: 4,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Beygirinin Giriniz",
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: peopleController,
                        maxLength: 2,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Kaç Kişilik Olduğunu Giriniz",
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: priceController,
                        maxLength: 8,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Günlük Ücretini Giriniz",
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text("Vites Türünü Seçiniz "),
                        DropdownButton(
                          value: selectedValu,
                          items: _gearContrl
                              .map((e) => DropdownMenuItem(
                                    child: Text(e),
                                    value: e,
                                  ))
                              .toList(),
                          onChanged: (change) {
                            setState(() {
                              selectedValu = change as String;
                            });
                          },
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text("Aracın Durumunu Belirtiniz"),
                        DropdownButton(
                          value: selectedStatus,
                          items: _statusControl
                              .map((e) => DropdownMenuItem(
                                    child: Text(e),
                                    value: e,
                                  ))
                              .toList(),
                          onChanged: (statusNew) {
                            setState(() {
                              selectedStatus = statusNew as String;
                            });
                          },
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {
                        imagePickerGallery();
                      },
                      child: const Text("Arabanın Resmini Yükleyiniz Galeri"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        imagePickerCamera();
                      },
                      child: const Text("Arabanın Resmini Yükleyiniz Kamera"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (licanceController.text.isNotEmpty &&
                            carModelController.text.isNotEmpty &&
                            hpController.text.isNotEmpty &&
                            peopleController.text.isNotEmpty &&
                            priceController.text.isNotEmpty) {
                          if (image?.path != null) {
                            _insertCar(
                              licanceController,
                              carModelController,
                              hpController,
                              peopleController,
                              priceController,
                            );
                          } else {
                            snackBarUse("LÜtfen Rsim Ekleyiniz");
                          }
                        } else {
                          snackBarUse("Alanların Hiçbiri Boş Bırakılamaz");
                        }

                        //snack bar yapılabilir
                      },
                      child: const Text("Bilgileri Kaydet ve Arabayı Ekle"),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //database e kayıt etmek için insert methodunu kullandık
  void _insertCar(
    TextEditingController licanceController,
    TextEditingController carModelController,
    TextEditingController hpController,
    TextEditingController peopleController,
    TextEditingController priceController,
  ) async {
    //integer deger girilmis mi diye kontrol etmek için
    var hp = int.tryParse(hpController.text);
    if (hp == null) {
      snackBarUse("Lütfen beygirin bir sayı olarak girin");
    }
    var peoplenum = int.tryParse(peopleController.text);
    if (peoplenum == null) {
      snackBarUse("Lütfen insn sayısının bir sayı olarak girin");
    }
    var pricing = int.tryParse(priceController.text);
    if (pricing == null) {
      snackBarUse("Lütfen fiyatını bir sayı olarak girin");
    }

    //database boolean değer kaydebilmek için yaptık
    int returnGear;
    if (selectedValu == "Otomatik vites") {
      returnGear = 0;
    } else {
      returnGear = 1;
    }
    int returnStatus;
    if (selectedStatus == "iyi") {
      returnStatus = 1;
    } else {
      returnStatus = 0;
    }

    if (hp != null &&
        peoplenum != null &&
        pricing != null &&
        image!.path.isNotEmpty) {
      Map<String, dynamic> row = {
        DataBaseHelper.columnlisance: licanceController.text,
        DataBaseHelper.columnModel: carModelController.text,
        DataBaseHelper.columnstatus: returnStatus,
        DataBaseHelper.columnhp: hp,
        DataBaseHelper.columngear: returnGear,
        DataBaseHelper.columnpeopleNum: peoplenum,
        DataBaseHelper.columnpricing: pricing,
        DataBaseHelper.columnPath: image!.path,
      };
      Cars cars = Cars.fromMap(row);
      final id = await dbHelper.insert(cars);
      snackBarUse(
          "Aracı plaka:" + licanceController.text.toString() + "Aracın id:$id");
      //id ile snackbar kullanımı
    }
  }

  //String ifadeleri bool değere çevirmeye yarar
  bool boolToString(TextEditingController textEditingController) {
    if (textEditingController.text.toLowerCase() == "false") {
      return false;
    } else {
      return true;
    }
  }

  //tüm tabloyu sıralamak icin kullanilir
  void _queryAll() async {
    final allRows = await dbHelper.queryAllRows();
    carsAll.clear();
    allRows.forEach(
      (element) {
        carsAll.add(Cars.fromMap(element));
      },
    );
    setState(() {});
  }

  snackBarUse(String message) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: (Colors.black12),
      action: SnackBarAction(
        label: 'Tamam',
        onPressed: () {},
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> _showDialogDeleteCar() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Bu Arabayı Silmek İstediğinze emin Misniz?'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Eğer arabayı silerseniz uygulamada olmayacktır'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('İptal'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Sil'),
              onPressed: () {
                //araba delete işlemi
              },
            ),
          ],
        );
      },
    );
  }

  intControl(TextEditingController textEditingController, String message) {
    var status = int.tryParse(textEditingController.text);
    if (status == null) {
      snackBarUse(message);
    }
  }

  void _delete(String deleteLicance) async {
    final delete = await dbHelper.delete(deleteLicance);
    snackBarUse("Silindi: $delete plakası: $deleteLicance");
  }

  void imagePickerGallery() async {
    try {
      final images = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (images == null) return;

      final imageTemp = File(images.path); //dart.io unutma
      setState(() {
        image = imageTemp;
      });
      debugPrint("iamge path gallery:" + image!.path.toString());
    } catch (e) {
      debugPrint("Sistemdi Hatanın adı bu: $e !!");
    }
  }

  void imagePickerCamera() async {
    try {
      final images = await ImagePicker().pickImage(source: ImageSource.camera);
      if (images == null) return;

      final imageTemp = File(images.path); //dart.io unutma
      setState(() {
        image = imageTemp;
      });
      debugPrint("iamge path camera:" + image!.path.toString());
    } catch (e) {
      debugPrint("Sistemdi Hatanın adı bu: $e !!");
    }
  }
}
