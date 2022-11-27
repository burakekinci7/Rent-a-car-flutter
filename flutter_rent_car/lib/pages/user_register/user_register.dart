import 'package:flutter/material.dart';
import 'package:flutter_rent_car/utils/user_database.dart';

import '../../models/user.dart';

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
  final userdbHelper = UserdataBase.instanceUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Kullanıcı Kayıt Ekranı")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: TextField(
                controller: nameController,
                maxLength: 15,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Adınızı Giriniz",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: TextField(
                controller: surNameController,
                maxLength: 15,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Soyadınızı Giriniz",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: TextField(
                controller: phoneNumberController,
                keyboardType: TextInputType.phone,
                maxLength: 11,
                decoration: const InputDecoration(
                  hintText: "05551234567",
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
            ElevatedButton(
                onPressed: () {
                  if (nameController.text.isNotEmpty &&
                      surNameController.text.isNotEmpty &&
                      phoneNumberController.text.isNotEmpty) {
                    //user save - insert
                    _insertUser(nameController, surNameController,
                        phoneNumberController);
                  }
                },
                child: const Text("Kaydol")),
          ],
        ),
      ),
    );
  }

  void _insertUser(
      TextEditingController nameController,
      TextEditingController surNameController,
      TextEditingController phoneNumberController) async {
    Map<String, dynamic> userRow = {
      UserdataBase.nameColumn: nameController.text,
      UserdataBase.surNameColumn: surNameController.text,
      UserdataBase.phoneNumberColumn: int.parse(phoneNumberController.text),
    };

    User user = User.fromMap(userRow);

    final id = await userdbHelper.insterUser(user);
    snackBarUse("Kaydedildi id:" +
        id.toString() +
        user.name.toString() +
        user.phoneNumber.toString());
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
