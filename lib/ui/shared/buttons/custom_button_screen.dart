import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class CustomButtonScreen extends StatelessWidget {
  final String text;
  final Function camFunc;
  final double tamBtnW;
  bool? changeColor;
  final IconData icon;

  CustomButtonScreen({
    super.key,
    required this.text,
    required this.camFunc,
    required this.tamBtnW,
    this.changeColor = false, 
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: tamBtnW,
      height: 40,
      child: TextButton.icon(
        onPressed: ()  => {camFunc()},
        icon:  Icon(
        icon ,
        color: changeColor != false ? const Color.fromARGB(255, 63, 140, 255) : const Color.fromARGB(255, 68, 68, 68),
        size: 24.0,
      ),
        label: Text(
          text,
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: changeColor != false ? const Color.fromARGB(255, 63, 140, 255) : const Color.fromARGB(255, 68, 68, 68),
          ),
        ),
      ),
    );
  }
}
