import 'package:flutter/material.dart';
import 'package:flutter_rent_car/pages/user/my_home_page.dart';
import 'package:flutter_rent_car/pages/user_register/user_register.dart';
import 'package:flutter_rent_car/pages/admin/car_list_admin.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lütfen Size Uygun Olanı Seçiniz"),
        actions: const [Icon(Icons.flash_on)],
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MyHomePage()));
                },
                child: const Text("Müşteri Girişi")),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const UserRegisterScreen()));
                },
                child: const Text("Müşteri kayıt")),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CarsList()));
                },
                child: const Text("Admin Girişi")),
          ],
        ),
      ),
    );
  }
}
