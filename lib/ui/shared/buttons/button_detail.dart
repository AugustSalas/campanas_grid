import 'package:campanas_grid/style_labels/style_labels.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ButtonDetail extends StatelessWidget {
  final VoidCallback onPressed;
  final String textButton;
  final double? width;
  final double? height;
  
   ButtonDetail({super.key, required this.onPressed, required this.textButton, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: styleButton,
        child: Text(textButton,style: StyleLabels.textoBoton,),
      ),
    );
  }

  ButtonStyle styleButton = ElevatedButton.styleFrom(
    shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    backgroundColor: const Color.fromARGB(255, 0, 117, 213),
  );
}
