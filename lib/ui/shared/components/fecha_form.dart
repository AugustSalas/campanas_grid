import 'package:campanas_grid/providers/form_cita_provider.dart';
import 'package:campanas_grid/ui/shared/components/custom_inputs.dart';
import 'package:datetime_picker_formfield_new/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class FechaForm extends StatefulWidget {
  final String? hintDrop;
  final String? hintLabel;
  final IconData? iconDrop;
  final String? Function(DateTime?)? validator;
  late final TextEditingController? dateInput;
    // ignore: prefer_const_constructors_in_immutables
    FechaForm({
    super.key,
    this.hintDrop,
    this.hintLabel,
    this.iconDrop,
    this.validator, 
    this.dateInput,
  });

  @override
  State<FechaForm> createState() => _FechaFormState();
}

class _FechaFormState extends State<FechaForm> {
  TextEditingController dateinput = TextEditingController();

  Future<DateTime?> dateFunction(context, currentValue) async {
    final citaProvider =
            Provider.of<FormCitaProvider>(context, listen: false);
    final date = await showDatePicker(
        context: context,
        firstDate: DateTime(1900),
        initialDate: currentValue ?? DateTime.now(),
        lastDate: DateTime(2100));
    if (date != null) {
      final time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
      );
       String formattedDate = DateFormat("yyyy-MM-dd HH:mm")
          .format(DateTimeField.combine(date, time));
      setState(() {
       dateinput.text =formattedDate;
       citaProvider.fechaHora = formattedDate;
      });
      return DateTimeField.combine(date, time);
    } else {
      return currentValue;
    }
  }

  @override
  Widget build(BuildContext context) {
    final format = DateFormat("yyyy-MM-dd HH:mm");
    return DateTimeField(
      controller: dateinput,
      validator: widget.validator!,
      format: format,
      decoration: CustomInputs.customInputDecoration(
        hint: widget.hintDrop!,
        icon: widget.iconDrop!,
        label: widget.hintLabel!,
      ),
      onShowPicker: dateFunction,
    );
  }
}
