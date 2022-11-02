import 'package:flutter/material.dart';
import 'package:flutter_rent_car/pages/add_car.dart';

class CarsList extends StatefulWidget {
  const CarsList({Key? key}) : super(key: key);

  @override
  State<CarsList> createState() => _CarsListState();
}

int listLength = 10;
bool isCheckedCarStatus = false;

class _CarsListState extends State<CarsList> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

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
      ),
      body: SizedBox(
        height: screenHeight * 10,
        child: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return Card(
              child: Column(
                children: [
                  const FlutterLogo(),
                  const Text(
                      "Model:Ferrari 458 İtalia\nPlaka: 34 BRK 15\nAraç Sağlığı: iyi/kötü"),
                  Checkbox(
                      value: isCheckedCarStatus,
                      onChanged: (bool? value) {
                        setState(() {
                          isCheckedCarStatus = !isCheckedCarStatus;
                        });
                      }),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
