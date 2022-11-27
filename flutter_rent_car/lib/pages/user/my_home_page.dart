import 'dart:io';

import 'package:flutter/material.dart';

import '../../models/cars.dart';
import '../../utils/database_helper.dart';
import 'date_brunch_pick.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final dbHelpera = DataBaseHelper.instance;
  List<Cars> carsAll = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Arabalar Listesi"),
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
          return carsAll[index].status == 1
              ? Card(
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 210,
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
                              Text(
                                "plakası: " + carsAll[index].licence.toString(),
                                style: const TextStyle(
                                    fontSize: 20, color: Colors.black),
                              ),
                              Text(
                                "Modeli: " + carsAll[index].model.toString(),
                                style: const TextStyle(
                                    fontSize: 20, color: Colors.pink),
                              ),
                              carsAll[index].gear == 0
                                  ? const Text(
                                      "vitesi: Otomatik",
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white),
                                    )
                                  : const Text(
                                      "vitesi: Manuel",
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white),
                                    ),
                              Text(
                                "Fiyatı: " + carsAll[index].pricing.toString(),
                                style: const TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                              Text(
                                "Kaç Kişilik: " +
                                    carsAll[index].peopleNum.toString(),
                                style: const TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                              Text(
                                "Beygiri: " + carsAll[index].hp.toString(),
                                style: const TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const DatePicScreen(),
                                        ));
                                  },
                                  child: const Text("Tarihi Seçiniz"))
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                )
              : Container();
        },
        itemCount: carsAll.length + 1,
      ),
    );
  }

  void _queryAll() async {
    final allRows = await dbHelpera.queryAllRows();
    carsAll.clear();
    allRows.forEach(
      (element) {
        carsAll.add(Cars.fromMap(element));
      },
    );
    setState(() {});
  }
}
