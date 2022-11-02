import 'package:flutter/material.dart';
import 'package:flutter_rent_car/pages/payment_screen.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(),
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
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const PaymentScreen()));
                      },
                      child: const Text("ÖDe"))
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
