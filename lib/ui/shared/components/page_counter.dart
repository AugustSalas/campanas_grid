import 'package:campanas_grid/providers/prospectos_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PageCounter extends StatefulWidget {
  final Function add;
   final Function remove;
   
  const PageCounter({super.key, required this.remove, required this.add});

  @override
  State<PageCounter> createState() => _PageCounterState();
}

class _PageCounterState extends State<PageCounter> {
  @override
  Widget build(BuildContext context) {
    final prospectosProvider = Provider.of<ProspectosProvider>(context);
    return Row(
      children: [
        IconButton(
           color: Colors.black,
          splashRadius: 15,
          icon: const Icon(Icons.remove),
          onPressed: prospectosProvider.counter >= 1 ? ()  => {widget.remove()} : null,
       ),
          Text(
             'Página ${prospectosProvider.counter}',
              style: GoogleFonts.roboto(
                fontWeight: FontWeight.w600,
                color: const Color.fromARGB(255, 68, 68, 68),
                fontSize: 18,
              ),
            ),

            IconButton(
          color: Colors.black,
          splashRadius: 15,
          icon: const Icon(Icons.add),
           onPressed:  ()  => {widget.add()},
       ),
      ],
    );
  }
}