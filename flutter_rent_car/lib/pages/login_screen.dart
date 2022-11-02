import 'package:flutter/material.dart';
import 'package:flutter_rent_car/pages/my_home_page.dart';
import 'package:flutter_rent_car/pages/user_register.dart';
import 'package:flutter_rent_car/pages/car_list_admin.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Litfen Size Uygun olanı seçiniz")),
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
                child: const Text("Müşteri Giriş")),
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
                child: const Text("Admin Girişii")),
          ],
        ),
      ),
    );
  }
}
