import 'package:get/get.dart';

class PersonController extends GetxController {
  RxString email = 'test@gmail.com'.obs;
  RxString password = '12345678'.obs;
  RxBool isCorrectAuth = true.obs;
}
