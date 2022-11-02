import 'package:flutter/material.dart';

class UserRegisterScreen extends StatefulWidget {
  const UserRegisterScreen({Key? key}) : super(key: key);

  @override
  State<UserRegisterScreen> createState() => _UserRegisterScreenState();
}

class _UserRegisterScreenState extends State<UserRegisterScreen> {
  //textFieldler üzerinde girilen inputları almak için kullanacağız
  TextEditingController nameController = TextEditingController();
  TextEditingController surNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Kullanıcı Kayıt Ekranı")),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Adınızı Giriniz",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: surNameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Soyadınızı Giriniz",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: phoneNumberController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Telefon numaranızı Giriniz",
                  prefixIcon: Icon(Icons.phone),
                ),
              ),
            ),
            ElevatedButton(
                onPressed: () {}, child: const Text("Tc Kimlik Fotoğrafı")),
            ElevatedButton(
                onPressed: () {}, child: const Text("Ehliyet Fotoğrafı")),
            ElevatedButton(onPressed: () {}, child: const Text("Kaydol")),
          ],
        ),
      ),
    );
  }
}
