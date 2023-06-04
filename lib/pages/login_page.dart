import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_kr/contollers/person_controller.dart';
import 'package:flutter_application_kr/pages/main_page.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  final PersonController personController = Get.put(PersonController());
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  LoginPage({super.key});
  void correctLog() {
    if (email.text == personController.email.value &&
        password.text == personController.password.value) {
      Get.off(MainPage());
      email.clear();
      password.clear();
      return;
    }
    email.clear();
    password.clear();
    personController.isCorrectAuth.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Авторизация'),
      ),
      body: SingleChildScrollView(
        child: Center(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
                width: 300,
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.only(
                  top: Get.height / 2,
                ),
                decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(20)),
                child: Obx(
                  () => Column(
                    children: [
                      const Text('Авторизация'),
                      TextField(
                        controller: email,
                        decoration: const InputDecoration(hintText: 'email'),
                      ),
                      TextField(
                        controller: password,
                        decoration: InputDecoration(
                            hintText: 'пароль',
                            errorText: personController.isCorrectAuth.value
                                ? null
                                : 'неправильный логин или пароль'),
                      )
                    ],
                  ),
                )),
            GestureDetector(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(15)),
                margin: const EdgeInsets.only(top: 10),
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                child: const Text(
                  'Вход',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              onTap: () => correctLog(),
            )
          ],
        )),
      ),
    );
  }
}
