import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rent_car/pages/user/payment_screen.dart';

class DatePicScreen extends StatefulWidget {
  const DatePicScreen({Key? key}) : super(key: key);

  @override
  State<DatePicScreen> createState() => _DatePicScreenState();
}

class _DatePicScreenState extends State<DatePicScreen> {
  //brunch picker
  final _branchList = ["Kadıköy", "Üsküdar", "Ataşehir", "Beşiktaş", "Taksim"];
  String selectedBrunch = "Kadıköy";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tarih ve Şubeler"),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DateTimePicker(
                icon: const Icon(Icons.date_range),
                calendarTitle: "Bir Aralık Seçiniz",
                cancelText: "Çıkış",
                confirmText: "Kaydet",
                cursorRadius: const Radius.circular(20),
                lastDate: DateTime(2024),
                firstDate: DateTime.now(),
                dateLabelText: "Tarih Seçiniz",
                type: DateTimePickerType.date,
              ),
            ),
            DropdownButton(
              value: selectedBrunch,
              items: _branchList
                  .map((e) => DropdownMenuItem(
                        child: Text(e),
                        value: e,
                      ))
                  .toList(),
              onChanged: (changed) {
                setState(() {
                  selectedBrunch = changed as String;
                });
              },
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PaymentScreen(),
                      ));
                },
                child: const Text("Kaydet ve Ödemeye Geç"))
          ],
        ),
      ),
    );
  }
}
