import 'package:get/state_manager.dart';

class ValueController extends GetxController {
  RxString dropOperation = 'Вид операции'.obs;
  RxString dropWay = 'Место действия соединения'.obs;
  RxString dropGunsName = 'Наименование соединений и частей'.obs;
  RxString dropConPartsName = 'Наименование боеприпасов'.obs;
  RxString isBrigade = 'В бригаде'.obs;
  RxString error = ''.obs;
  RxBool isVisible = false.obs;
  RxString complect = 'Военно-техническое имущество'.obs;
  RxString number_complect = 'Номер комплекта'.obs;
}
