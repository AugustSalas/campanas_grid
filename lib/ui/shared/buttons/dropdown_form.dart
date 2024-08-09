import 'package:campanas_grid/style_labels/style_labels.dart';
import 'package:campanas_grid/ui/shared/components/custom_inputs.dart';
import 'package:flutter/material.dart';

class DropdownForm extends StatelessWidget {
  final List<String>? data;
  final String? hintDrop;
  final String? selectedValue;
  final ValueChanged onChanged;
  final String? hintLabel;
  final IconData? iconDrop;
  final String? Function(String?)? validator;
  

  const DropdownForm({
    super.key,
    this.data,
    required this.hintDrop,
    this.selectedValue,
    required this.onChanged,
    this.hintLabel,
    this.iconDrop,
    this.validator, 
  
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      
      focusColor: Colors.white,
      decoration: CustomInputs.customInputDecoration(
        hint: hintDrop!,
        icon: iconDrop!,
        label: hintLabel!,
      ),
      value: selectedValue,
      items: data!
          .map(
            (String item) => DropdownMenuItem<String>(
              value: item,
              child: Text(item, style: StyleLabels.itemDrop),
            ),
          )
          .toList(),
      onChanged: (value) {
        onChanged(value);
      },
      validator: validator,
    );
  }
}
