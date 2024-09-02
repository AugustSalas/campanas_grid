import 'package:campanas_grid/style_labels/style_labels.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class CustomDropdownDouble extends StatelessWidget {
  final List<String>? data;
  final List<String>? data2;
  final String hintDrop;
  final String? selectedValue;
  final ValueChanged onChanged;
  final double? width;
  final double? height;
  final int length;
  const CustomDropdownDouble({
    super.key,
    this.data,
    required this.hintDrop,
    this.selectedValue,
    required this.onChanged,
    this.width,
    this.height,
    required this.length,
    this.data2,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        // iconStyleData: const IconStyleData(
        //     iconEnabledColor: Color.fromARGB(255, 73, 127, 169)),
        buttonStyleData: ButtonStyleData(
            height: height, width: width, decoration: buildBoxDecoration()),
        menuItemStyleData: const MenuItemStyleData(height: 50),
        hint: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(hintDrop, style: StyleLabels.textoDrop2),
        ),
        items: List.generate(length, (index) {
          return DropdownMenuItem<String>(
            value: data![index],
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                data2![index],
                style: StyleLabels.itemDrop,
              ),
            ),
          );
        }),
        value: selectedValue,
        onChanged: (value) {
          onChanged(value);
        },
      ),
    );
  }

  BoxDecoration buildBoxDecoration() => BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color.fromARGB(255, 68, 68, 68),
        ),
        color: Colors.white,
      );
}
