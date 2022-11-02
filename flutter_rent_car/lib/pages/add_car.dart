import 'package:flutter/material.dart';

class CarAdd extends StatefulWidget {
  const CarAdd({Key? key}) : super(key: key);

  @override
  State<CarAdd> createState() => _CarAddState();
}

class _CarAddState extends State<CarAdd> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();

  TextEditingController carModelController = TextEditingController();
  TextEditingController licanceController = TextEditingController();
  TextEditingController carHelatyontroller = TextEditingController();
  TextEditingController hpController = TextEditingController();
  TextEditingController gearController = TextEditingController();
  TextEditingController peopleController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
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
        body: TabBarView(children: [
          SizedBox(
            height: screenHeight * 10,
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return Card(
                  child: Column(
                    children: const [
                      FlutterLogo(),
                      Text(
                          "Model:Ferrari 458 İtalia\nPlaka: 34 BRK 15\nAraç Sağlığı: iyi/kötü"),
                    ],
                  ),
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
                      controller: carModelController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Arabanın Modelini Giriniz",
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: licanceController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Plaka Bilgisini Giriniz",
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: carHelatyontroller,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Araç Saglığını Giriniz",
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: hpController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Beygirinin Giriniz",
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: gearController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Vites Tipini Giriniz",
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: peopleController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Kaç Kişilik olduğunu Girinz",
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: priceController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Günlük Ücretini Giriniz",
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text("Arabanın Resmini Yükleyiniz"),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text("Bilgileri kaydet ve arabayı ekle"),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
