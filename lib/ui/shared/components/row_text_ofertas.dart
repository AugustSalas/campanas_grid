import 'package:flutter/material.dart';

class RowTextOfertas extends StatelessWidget {
  
  final String title;
  final String data;
  final double width;
  final TextStyle style;

  const RowTextOfertas({
    super.key,
    required this.title,
    required this.data,
    required this.width,
    required this.style,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: width,
          child: Text(
            title,
            style: style,
            textAlign: TextAlign.start,
          ),
        ),
        SizedBox(
          width: width,
          child: Text(
            data,
            style: style,
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }
}
