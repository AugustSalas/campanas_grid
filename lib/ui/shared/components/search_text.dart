import 'package:flutter/material.dart';
import 'package:campanas_grid/ui/shared/components/custom_inputs.dart';

class SearchText extends StatelessWidget {

  final ValueChanged onChanged;
  final String hint;

  const SearchText({super.key, required this.onChanged, required this.hint,});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      //width: double.infinity,
      decoration: buildBoxDecoration(),
      child: TextField(
        decoration: CustomInputs.searchInputDecoration(hint: hint, icon: Icons.search_outlined),
        onChanged: (value) {
          onChanged(value);
        },
      ),
    );
  }

  BoxDecoration buildBoxDecoration() => BoxDecoration(
    
    border: Border.all(
      color: const Color.fromARGB(255, 189, 186, 186),
      width: 2
    ),
     borderRadius: const BorderRadius.all(Radius.circular(12)),
    color: Colors.white.withOpacity(0.2)
  );
}