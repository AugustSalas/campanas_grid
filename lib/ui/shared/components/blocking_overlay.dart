import 'package:flutter/material.dart';

class BlockingOverlay extends StatelessWidget {
  final Widget child;

  const BlockingOverlay({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            color: Colors.black.withOpacity(0.5),
            child: GestureDetector(
              onTap: () {
                // Aquí puedes manejar el evento de clic, si lo deseas.
              },
            ),
          ),
        ),
        Positioned.fill(
          child: child,
        ),
      ],
    );
  }
}
