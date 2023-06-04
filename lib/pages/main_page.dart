import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_kr/components/my_dropdown_menu.dart';
import 'package:flutter_application_kr/contollers/results_controller.dart';
import 'package:flutter_application_kr/contollers/value_controller.dart';
import 'package:flutter_application_kr/models/all_models.dart';
import 'package:flutter_application_kr/models/guns_models.dart';
import 'package:flutter_application_kr/models/technique_model.dart';
import 'package:flutter_application_kr/pages/login_page.dart';
import 'package:get/get.dart';
import 'package:excel/excel.dart' hide Border;
import 'package:path/path.dart' as path;
import 'dart:io' as io;

class MainPage extends StatefulWidget {
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final valueController = Get.put(ValueController());
  final TextEditingController possibleLosingController =
      TextEditingController();
  final excel = Excel.createExcel();
  // final transportNeed = 0.obs;
  ResultsController resultsController = Get.put(ResultsController());

  late AllModels allModels;
  AllGuns allGuns = AllGuns();
  RxString needingsForTransport = ''.obs;
  List<String> header = ['Вид техники', 'БП', 'КР', 'СР', 'ТР'];
  List<List<String>> data = [
    ['', '', '', '', ''],
    ['', '', '', '', ''],
    ['', '', '', '', ''],
    ['', '', '', '', ''],
    ['', '', '', '', '']
  ];
  List<String> getAllConPartsNames(List<ConParts> conPartsList) {
    List<String> names = [];
    //double result = 0;

    for (ConParts conParts in conPartsList) {
      names.add(conParts.name);
    }

    return names;
  }

  List<String> getAllGunsNames(List<ConParts> conPartsList) {
    List<String> names = [];

    for (ConParts conParts in conPartsList) {
      names.add(conParts.guns.name);
    }

    return names;
  }

  late List<String> gunsName;
  late List<String> conPartsName;
  final listVTI = {
    'АРТИ': [6, 12],
    'БТИ': [30],
    'АИ': [15, 20]
  };

  //TextEditingController tankNumber = TextEditingController();
  final List<TextEditingController> amoung_power =
      List.generate(4, (index) => TextEditingController());
  final TextEditingController rasEditingController = TextEditingController();
  final List<String> hintTexts = [
    'Количество Танк',
    'Количество БМП',
    'Количество САУ',
    'Количество БТР'
  ];

  var items1 = <String>[
    'Вид операции',
    'Наступательная операция',
    'Оборонительная операция'
  ];

  var items2 = <String>[
    'Место действия соединения',
    'На главном направлении',
    'На других направлениях',
    'Во втором эшелоне фронта',
    'В резерве'
  ];
  var items3 = <String>['В бригаде', 'В частях'];
  final List<String> items4 = [
    'Военно-техническое имущество',
    'АРТИ',
    'БТИ',
    'АИ'
  ];
  final List<String> items5 = ['Номер комплекта', '№1', '№2'];
  final List<int> forecast_losts = List.generate(4, (index) => 2);

  double count(
      {required double src,
      required double kt,
      required double msbr,
      required double rb,
      required bool isBBT,
      required double number}) {
    double add_num = isBBT ? 1.2 : 1.15;
    print(src);
    print(kt);
    print(msbr);
    print(rb);
    print(isBBT);
    print(number);
    print('***********************');
    double result = src * kt * msbr * rb * add_num * number / 100;
    return formatedNum(result);
  }

  double formatedNum(double value) {
    String formattedValue = value.toStringAsFixed(2);
    return double.parse(formattedValue);
  }

  late List<TechniqueModel> models;
  @override
  void initState() {
    allModels = AllModels(
        isAtack:
            valueController.dropOperation.value == 'Наступательная операция');
    models = [
      allModels.srcTank,
      allModels.srcBMP,
      allModels.srcSAU,
      allModels.srcBTR
    ];

    gunsName = getAllGunsNames(allGuns.allConParts);
    conPartsName = getAllConPartsNames(allGuns.allConParts);
    conPartsName.insert(0, 'Наименование боеприпасов');
    gunsName.insert(0, 'Наименование соединений и частей');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Национальный университет обороны'),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [leftSide(), rightSide()],
      ),
    );
  }

  double whatis() {
    if (valueController.dropWay.value == items2[1]) {
      return valueController.dropOperation.value == items1[1] ? 1.45 : 1.35;
    }
    if (valueController.dropWay.value == items2[2]) {
      return valueController.dropOperation.value == items1[1] ? 0.95 : 0.9;
    }
    if (valueController.dropWay.value == items2[3]) {
      return 1;
    }
    // if (valueController.dropWay.value == items2[4]) {
    //   return valueController.dropOperation.value == items2[1] ? 0.45 : 0.4;
    // }
    return valueController.dropOperation.value == items1[1] ? 0.45 : 0.4;
  }

  Widget _power_counter(TextEditingController controller, String hintText) {
    return Container(
      width: 200,
      child: TextField(
          controller: controller,
          decoration: InputDecoration(hintText: hintText)),
    );
  }

  double isBTB(bool isBBT) {
    if (isBBT &&
        valueController.dropOperation.value == 'Наступательная операция') {
      return 2.1;
    }
    return 1.1;
  }

  Widget rightSide() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [buttons(), namingGuns(), possibleLosing()],
    );
  }

  Widget possibleLosing() {
    return Container(
      margin: const EdgeInsets.only(right: 20, top: 10),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(width: 1),
          color: Colors.white),
      width: 400,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Возможные потери ВТИ',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          TextField(
            controller: possibleLosingController,
            decoration: const InputDecoration(
                hintText: 'планируемый период боевых действий (сут)'),
          ),
          MyDropdownMenu(
              items: items4, dropdownValue: valueController.complect),
          Obx(() => MyDropdownMenu(
              items: valueController.complect.value != 'БТИ'
                  ? items5
                  : items5.getRange(0, 2).toList(),
              dropdownValue: valueController.number_complect)),
          Row(
            children: [
              Expanded(child: Container()),
              GestureDetector(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10)),
                    child: const Text(
                      'Рассчитать',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  onTap: () => {
                        resultsController.resultVTI.value = (50 *
                                double.parse(possibleLosingController.text) /
                                listVTI[valueController.complect.value]![
                                    valueController.number_complect.value ==
                                            items5[1]
                                        ? 0
                                        : 1])
                            .toString(),
                        print(resultsController.resultVTI.value),
                      }),
            ],
          ),
          Obx(
            () => resultsController.resultVTI.value != ''
                ? Container(
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(15)),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 15),
                    margin: EdgeInsets.only(top: 10),
                    child: Text(
                      'Возможные потери ВТИ: ${resultsController.resultVTI.value}',
                      style: const TextStyle(color: Colors.white),
                    ),
                  )
                : Container(),
          )
        ],
      ),
    );
  }

  List<double>? result_p() {
    print('called');
    String gunName = valueController.dropGunsName.value;
    String conPartName = valueController.dropConPartsName.value;
    List<double>? result = [1, 2, 3];
    for (var i in allGuns.allConParts) {
      //print(gunName);
      if (i.guns.name == gunName && i.name == conPartName) {
        //print(i.guns.name);
        if (valueController.isBrigade == 'В бригаде') {
          //print(valueController.isBrigade);
          if (i.guns.inBrigade != null) {
            result[0] = i.guns.inBrigade! +
                double.parse(rasEditingController.text) * 0.2 +
                double.parse(rasEditingController.text);
            result[1] = i.guns.inBrigade! +
                double.parse(rasEditingController.text) * 0.15 +
                double.parse(rasEditingController.text);
            result[2] = i.guns.inBrigade!;
            return result;
          } else {
            return null;
          }
        } else {
          if (i.guns.inParts != null) {
            result[0] = i.guns.inParts! +
                i.guns.inParts! * 0.2 +
                double.parse(rasEditingController.text);
            result[1] = i.guns.inParts! +
                i.guns.inParts! * 0.15 +
                double.parse(rasEditingController.text);
            result[2] = i.guns.inParts!;
            return result;
          } else {
            print('pooor');
            return null;
          }
        }
      }
    }
    return null;
  }

  Widget buttons() {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          margin: EdgeInsets.only(top: 10),
          decoration: BoxDecoration(
              color: Colors.blue, borderRadius: BorderRadius.circular(15)),
          child: const Icon(
            Icons.calculate_rounded,
            color: Colors.white,
            size: 40,
          ),
        ),
        GestureDetector(
          child: Container(
            margin: const EdgeInsets.only(right: 20, left: 20, top: 10),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            decoration: BoxDecoration(
                color: Colors.blue, borderRadius: BorderRadius.circular(15)),
            child: const Text(
              'Выход',
              style: TextStyle(color: Colors.white, fontSize: 17),
            ),
          ),
          onTap: () => Get.off(() => LoginPage()),
        )
      ],
    );
  }

  Widget leftSide() {
    return Container(
        margin: const EdgeInsets.only(left: 15, top: 10),
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            MyDropdownMenu(
              items: items1,
              dropdownValue: valueController.dropOperation,
            ),
            MyDropdownMenu(
                items: items2, dropdownValue: valueController.dropWay),
            Column(
              children: List.generate(
                  hintTexts.length,
                  (index) =>
                      _power_counter(amoung_power[index], hintTexts[index])),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10)),
                child: const Text(
                  'Рассчитать',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              onTap: () => setState(() {
                allModels = AllModels(
                    isAtack: valueController.dropOperation.value ==
                        'Наступательная операция');
                models = [
                  allModels.srcTank,
                  allModels.srcBMP,
                  allModels.srcSAU,
                  allModels.srcBTR
                ];
              }),
            ),
            DataTable(
                columns: [
                  DataColumn(
                    label: Text(header[0]),
                  ),
                  DataColumn(
                    label: Text(header[1]),
                  ),
                  DataColumn(
                    label: Text(header[2]),
                  ),
                  DataColumn(
                    label: Text(header[3]),
                  ),
                  DataColumn(
                    label: Text(header[4]),
                  ),
                ],
                rows: List.generate(models.length, (index) {
                  data[index][0] = hintTexts[index].split(' ')[1];
                  data[index][1] = count(
                          src: models[index].src4,
                          kt: valueController.dropOperation.value ==
                                  'Наступательная операция'
                              ? 1.9
                              : 1.85,
                          msbr: whatis(),
                          rb: isBTB(true),
                          isBBT: models[index].isBBT,
                          number: amoung_power[index].text != ''
                              ? double.parse(amoung_power[index].text)
                              : 0)
                      .toString();
                  data[index][2] = count(
                          src: models[index].src3,
                          kt: valueController.dropOperation.value ==
                                  'Наступательная операция'
                              ? 1.9
                              : 1.85,
                          msbr: whatis(),
                          rb: isBTB(true),
                          isBBT: models[index].isBBT,
                          number: amoung_power[index].text != ''
                              ? double.parse(amoung_power[index].text)
                              : 0)
                      .toString();
                  data[index][3] = count(
                          src: models[index].src2,
                          kt: valueController.dropOperation.value ==
                                  'Наступательная операция'
                              ? 1.9
                              : 1.85,
                          msbr: whatis(),
                          rb: isBTB(true),
                          isBBT: models[index].isBBT,
                          number: amoung_power[index].text != ''
                              ? double.parse(amoung_power[index].text)
                              : 0)
                      .toString();
                  data[index][4] = count(
                          src: models[index].src1,
                          kt: valueController.dropOperation.value ==
                                  'Наступательная операция'
                              ? 1.9
                              : 1.85,
                          msbr: whatis(),
                          rb: isBTB(true),
                          isBBT: models[index].isBBT,
                          number: amoung_power[index].text != ''
                              ? double.parse(amoung_power[index].text)
                              : 0)
                      .toString();
                  return DataRow(cells: [
                    DataCell(Text(data[index][0])),
                    DataCell(Text(data[index][1])),
                    DataCell(Text(data[index][2])),
                    DataCell(Text(data[index][3])),
                    DataCell(Text(data[index][4])),
                  ]);
                })),
            GestureDetector(
              child: Container(
                margin: EdgeInsets.only(top: 10),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.blue),
                child: const Text(
                  'Загрузить',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              onTap: () async {
                for (int i = 0; i < 5; i++) {
                  excel.updateCell(
                      'Sheet1',
                      CellIndex.indexByColumnRow(columnIndex: i, rowIndex: 0),
                      header[i]);
                }
                for (int i = 0; i < data.length; i++) {
                  excel.updateCell(
                      'Sheet1',
                      CellIndex.indexByColumnRow(
                          columnIndex: 0, rowIndex: i + 1),
                      data[i][0]);
                }
                for (int i = 0; i < data.length; i++) {
                  for (int j = 1; j < data[i].length; j++) {
                    excel.updateCell(
                        'Sheet1',
                        CellIndex.indexByColumnRow(
                            columnIndex: i + 1, rowIndex: j),
                        data[i][j],
                        cellStyle:
                            CellStyle(horizontalAlign: HorizontalAlign.Right));
                    //l++;
                  }
                  //f++;
                }
                var fileBytes =
                    excel.save(fileName: 'My_Excel_File_Name2.xlsx');
                await downloadFile(bytes: fileBytes!, fileName: 'SUI');
              },
            )
          ]),
        ));
  }

  namingGuns() {
    return Container(
      margin: const EdgeInsets.only(right: 20, top: 10),
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(width: 1),
          color: Colors.white),
      width: 400,
      height: 420,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyDropdownMenu2(
            items: gunsName.toSet().toList(),
            dropdownValue: valueController.dropGunsName,
          ),
          MyDropdownMenu2(
            items: conPartsName.toSet().toList(),
            dropdownValue: valueController.dropConPartsName,
          ),
          MyDropdownMenu(
            items: items3,
            dropdownValue: valueController.isBrigade,
          ),
          TextField(
            controller: rasEditingController,
            decoration: InputDecoration(hintText: 'планируемый расход РиБП'),
          ),
          Row(
            //mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(child: SizedBox()),
              GestureDetector(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(15)),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  margin: EdgeInsets.only(top: 10),
                  child: const Text(
                    'Рассчитать',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                onTap: () {
                  print(valueController.dropConPartsName.value);
                  print(valueController.dropGunsName.value);
                  if (result_p() != null) {
                    String first = result_p() == null
                        ? 'error'
                        : result_p()![0].toString();
                    String second = result_p() == null
                        ? 'error'
                        : result_p()![1].toString();
                    valueController.error.value = '$first - $second';
                    String res = countTransNeed(
                        ripVal1: double.parse(first),
                        ripVal2: double.parse(second));
                    needingsForTransport.value = res;
                    print("RESULT: $res");
                  } else {
                    valueController.error.value =
                        'Ошибка(Запас РиБП не установлено)';
                  }
                },
              )
            ],
          ),
          const Text(
            'Результат:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Obx(
            () => valueController.error.value != ''
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ShowResult(
                          'Потребность в РиПБ: ${valueController.error.value}'),
                      ShowResult(
                          'Потребность в транспорте: ${needingsForTransport.value}')
                    ],
                  )
                : Container(),
          )
        ],
      ),
    );
  }

  Future<void> downloadFile(
      {required List<int> bytes, required String fileName}) async {
    String extension = path.extension(fileName);
    if (extension.isEmpty) {
      extension = '.xlsx'; // default extension for Excel files
    }

    String suggestedFileName =
        '${path.basenameWithoutExtension(fileName)}$extension';
    String? outputFile = await FilePicker.platform.saveFile(
        dialogTitle: 'Save Your File to desired location',
        fileName: suggestedFileName);

    try {
      io.File returnedFile = io.File('$outputFile');
      await returnedFile.writeAsBytes(bytes);
    } catch (e) {}
  }

  double transportNeed({required double ripVal, required double kig}) {
    return ripVal * 80 * 70 / 2 / 1000 / kig / 8;
  }

  String countTransNeed({required double ripVal1, required double ripVal2}) {
    Iterable<ConParts> guns = allGuns.allConParts.where(
        (element) => element.guns.name == valueController.dropGunsName.value);
    double kig = guns.toList()[0].guns.kig!;
    return transportNeed(ripVal: ripVal1, kig: kig).toStringAsFixed(2) +
        "-" +
        transportNeed(ripVal: ripVal2, kig: kig).toStringAsFixed(2);
  }

  Widget ShowResult(text) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.blue, borderRadius: BorderRadius.circular(15)),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      margin: EdgeInsets.only(top: 10),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
