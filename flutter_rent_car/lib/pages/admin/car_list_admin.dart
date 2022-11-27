import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_rent_car/pages/admin/add_car.dart';

import '../../models/cars.dart';
import '../../utils/database_helper.dart';

class CarsList extends StatefulWidget {
  const CarsList({Key? key}) : super(key: key);

  @override
  State<CarsList> createState() => _CarsListState();
}

//status control
bool isCheckedCarStatus = false;

//ressresh for list
List<Cars> carsAll = [];

//data base yardımcı elemanlari
final _dbHelper = DataBaseHelper.instance;

//checkedBox
bool isChacked = false;

class _CarsListState extends State<CarsList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const CarAdd()));
              },
              icon: const Icon(Icons.add)),
        ],
        title: const Text("Arabalarımız"),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(10),
        itemBuilder: (context, index) {
          if (index == carsAll.length) {
            return ElevatedButton(
                onPressed: () {
                  setState(() {
                    _queryAll();
                  });
                },
                child: const Text("Yenile"));
          }
          return Card(
            child: Row(
              children: [
                Expanded(
                  flex: 45,
                  child: Container(
                    height: 170,
                    color: Colors.black,
                    child: Image.file(
                      File(carsAll[index].path!),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Colors.blueGrey,
                    child: Column(
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 6, left: 8, right: 8),
                          child: Text(
                            "Plakası: " + carsAll[index].licence.toString(),
                            style: const TextStyle(
                                fontSize: 20, color: Colors.black),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 8, right: 8, bottom: 2),
                          child: Text(
                            "Modeli: " + carsAll[index].model.toString(),
                            style: const TextStyle(
                                fontSize: 20, color: Colors.orange),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 8, right: 8, bottom: 2),
                          child: carsAll[index].status == 0
                              ? const Text(
                                  "Durmu: Kötü",
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                )
                              : const Text(
                                  "Durmu: İyi",
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 8, right: 8, bottom: 2),
                          child: Text(
                            "Fiyatı: " + carsAll[index].pricing.toString(),
                            style: const TextStyle(
                                fontSize: 20, color: Colors.white),
                          ),
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8, right: 8),
                              child: ElevatedButton(
                                  onPressed: () {
                                    if (carsAll[index].licence!.isNotEmpty &&
                                        carsAll[index].status != null) {}
                                    _update(
                                        carsAll[index].licence!,
                                        carsAll[index].model!,
                                        carsAll[index].status == 0 ? 1 : 0,
                                        carsAll[index].hp!,
                                        carsAll[index].gear!,
                                        carsAll[index].peopleNum!,
                                        carsAll[index].pricing!,
                                        carsAll[index].path!);
                                    snackBarUse(
                                        "Değişikliği görmek için lütfen sayfayı yenileyiniz");
                                  },
                                  child: const Text("Kirala")),
                            ),
                            carsAll[index].status == 0
                                ? const Text(
                                    "Kiralanmamış",
                                    style: TextStyle(
                                        color: Colors.red, fontSize: 18),
                                  )
                                : const Text("Kiralanmış",
                                    style: TextStyle(
                                        color: Colors.green, fontSize: 20)),
                          ],
                        )
                      ],
                    ),
                  ),
                  flex: 55,
                )
              ],
            ),
          );
        },
        itemCount: carsAll.length + 1,
      ),
    );
  }

  void _queryAll() async {
    final allRows = await _dbHelper.queryAllRows();
    carsAll.clear();
    allRows.forEach(
      (element) {
        carsAll.add(Cars.fromMap(element));
      },
    );
    setState(() {});
  }

  void _update(
    String licence,
    String model,
    int statsu,
    int hp,
    int gear,
    int peopleNum,
    int pricing,
    String path,
  ) async {
    Cars cars = Cars(
        licence: licence,
        model: model,
        status: statsu,
        hp: hp,
        gear: gear,
        peopleNum: peopleNum,
        pricing: pricing,
        path: path);
    final rowUpdate = await _dbHelper.update(cars);
    debugPrint(rowUpdate.toString());
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
}
