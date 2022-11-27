import 'package:flutter/material.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  bool isChacked = false;
  TextEditingController cardNumController = TextEditingController();
  TextEditingController cardDateMoonController = TextEditingController();
  TextEditingController cardYearController = TextEditingController();
  TextEditingController cardCcvController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Ödeme Ekranı"),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(top: 20, left: 8, right: 8, bottom: 10),
              child: TextField(
                controller: cardNumController,
                maxLength: 16,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Lütfen kart numaranızı giriniz",
                ),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 50,
                    child: TextField(
                      controller: cardDateMoonController,
                      maxLength: 2,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Ay",
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 100,
                    child: TextField(
                      controller: cardYearController,
                      maxLength: 4,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Yıl",
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 100,
                    child: TextField(
                      controller: cardCcvController,
                      maxLength: 3,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "CCV",
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Checkbox(
                  value: isChacked,
                  onChanged: (bool? value) {
                    setState(() {
                      isChacked = value!;
                    });
                  },
                ),
                const Text("Ön Koşulları Kabul Ediyorum"),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: ElevatedButton(
                  onPressed: () {
                    if (cardCcvController.text.isNotEmpty &&
                        cardDateMoonController.text.isNotEmpty &&
                        cardNumController.text.isNotEmpty &&
                        cardYearController.text.isNotEmpty) {
                      if (isChacked == false) {
                        snackBarUse("Lütfen Koşulları kabul ediniz");
                      } else {
                        if (cardCcvController.text.length != 3) {
                          snackBarUse("CCV 3 Karakterli olmalıdır");
                        } else {
                          snackBarUse("işlmem TAMAM");
                        }
                      }
                    } else {
                      snackBarUse("Hiçbir alan boş bırakılmamalıdır");
                    }
                  },
                  child: const Text("Öde ve Bitir")),
            ),
          ],
        ),
      ),
    );
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
