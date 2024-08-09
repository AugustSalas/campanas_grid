import 'package:campanas_grid/style_labels/style_labels.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class CustomDropdown extends StatelessWidget {
  final List<String>? data;
  final String hintDrop;
  final String? selectedValue;
  final ValueChanged onChanged;
  final double? width;
  final double? height;
  const CustomDropdown({
    super.key,
    this.data,
    required this.hintDrop,
    this.selectedValue,
    required this.onChanged,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        // iconStyleData: const IconStyleData(
        //     iconEnabledColor: Color.fromARGB(255, 68, 68, 68),),
        isExpanded: true,
        buttonStyleData: ButtonStyleData(
            height: height, width: width, decoration: buildBoxDecoration()),
        //menuItemStyleData: const MenuItemStyleData(height: 50),
        hint: Row(
          children: [
            const SizedBox(width: 10),
            Text(
              hintDrop,
              style: StyleLabels.textoDrop2,
            ),
          ],
        ),
        items: data!
            .map(
              (item) => DropdownMenuItem<String>(
                value: item,
                child: Row(
                  children: [
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        item,
                        style: StyleLabels.itemDrop,
                      ),
                    ),
                  ],
                ),
              ),
            )
            .toList(),
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
