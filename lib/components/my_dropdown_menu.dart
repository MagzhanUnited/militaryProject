import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class MyDropdownMenu extends StatelessWidget {
  final RxString dropdownValue;
  const MyDropdownMenu({required this.items, required this.dropdownValue});
  final List<String> items;

  @override
  Widget build(BuildContext context) {
    return Obx(() => DropdownButton<String>(
          value: dropdownValue.value,
          onChanged: (String? newValue) {
            dropdownValue.value = newValue!;
          },
          items: items.map<DropdownMenuItem<String>>((String value) {
            overflow:
            TextOverflow.ellipsis;
            return DropdownMenuItem<String>(
              value: value,
              child: Container(
                child: Text(value),
              ),
            );
          }).toList(),
        ));
  }
}

class MyDropdownMenu2 extends StatelessWidget {
  final RxString dropdownValue;
  const MyDropdownMenu2({required this.items, required this.dropdownValue});
  final List<String> items;

  @override
  Widget build(BuildContext context) {
    return Obx(() => DropdownButton<String>(
          isExpanded: true,
          itemHeight: null,
          value: dropdownValue.value,
          onChanged: (String? newValue) {
            dropdownValue.value = newValue!;
          },
          items: items.map<DropdownMenuItem<String>>((String value) {
            overflow:
            TextOverflow.ellipsis;
            return DropdownMenuItem<String>(
              value: value,
              child: Container(
                child: Text(value),
              ),
            );
          }).toList(),
        ));
  }
}
