import 'package:flutter/material.dart';


class CustomInputs {

    static InputDecoration searchInputDecoration({

    required String hint,
    required IconData icon,
  }){

    return InputDecoration(
      border: InputBorder.none,
      enabledBorder: InputBorder.none,
      hintText: hint,
      prefixIcon: Icon(icon,color: Colors.grey),
      labelStyle: const TextStyle(color: Colors.grey),
      hintStyle: const TextStyle(color: Colors.grey),


    );

  }

  static InputDecoration customInputDecoration({
    required String hint,
    required String label,
    required IconData icon,
    
  }) {
    return InputDecoration(
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        borderSide: BorderSide(
          width: 2,
          color: Color.fromARGB(255, 217, 217, 217),
        ),
      ),
      enabledBorder: const OutlineInputBorder(
         borderRadius: BorderRadius.all(Radius.circular(12)),
        borderSide: BorderSide(
           width: 2,
          color: Color.fromARGB(255, 217, 217, 217),
        ),
      ),
      hintText: hint,
      labelText: label,
      prefixIcon: Icon(
        icon,
        color:  const Color.fromARGB(255, 0, 117, 213),
        size: 30,
      ),
      hintStyle: const TextStyle(
        color:  Color.fromARGB(255, 108, 108, 108),
        fontWeight: FontWeight.bold,
        fontSize: 18
      ),
      labelStyle: const TextStyle(
        color:  Color.fromARGB(255, 108, 108, 108),
        fontWeight: FontWeight.bold,
        fontSize: 18
      ),
    );
  }
}