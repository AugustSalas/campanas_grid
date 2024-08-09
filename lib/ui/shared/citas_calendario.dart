import 'package:campanas_grid/models/model_cliente_citas.dart';
import 'package:campanas_grid/providers/citas_provider.dart';
import 'package:campanas_grid/ui/shared/components/selects_emp_suc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CitasCalendario extends StatefulWidget {
  const CitasCalendario({super.key});

  @override
  _CitasCalendarioState createState() => _CitasCalendarioState();
}

class _CitasCalendarioState extends State<CitasCalendario> {
  CalendarController? calendarController;
  late CitasProvider citasProvider;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final citasProvider = Provider.of<CitasProvider>(context, listen: false);
      citasProvider.getCitas();
    });
  }

   @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    citasProvider =
        Provider.of<CitasProvider>(context, listen: false);
  }

  @override
  void dispose() {
    citasProvider.prospectosProvider.resetValues();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final citasProvider = Provider.of<CitasProvider>(context);

    final size = MediaQuery.of(context).size;

    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children: [
            citasProvider.prospectosProvider.rolePerfil == 'ZONAL' ||
                    citasProvider.prospectosProvider.rolePerfil == 'MAESTRO'
                ? Padding(
                    padding:
                        EdgeInsets.only(left: constraints.maxWidth * 0.035),
                    child: SelectsEmpSuc(
                      width: size.width > 770
                          ? constraints.maxWidth * 0.20
                          : constraints.maxWidth * 0.45,
                      onChanged: (value) {
                        setState(() {
                          citasProvider.prospectosProvider.empresa =
                              value as String?;
                          if (citasProvider.prospectosProvider.empresa !=
                              null) {
                            citasProvider.prospectosProvider.nomEmpresa =
                                citasProvider.prospectosProvider.empresa!;
                            citasProvider.prospectosProvider.getSucursal();
                          }
                        });
                      },
                      onChanged2: (value) {
                        setState(() {
                          citasProvider.prospectosProvider.selectedSucursal =
                              value.toString();
                          if (citasProvider
                                  .prospectosProvider.selectedSucursal !=
                              null) {
                            RegExp regExp = RegExp(r'\d+$');
                            String? match = regExp.stringMatch(citasProvider
                                .prospectosProvider.selectedSucursal!);
                            if (match != null) {
                              citasProvider.prospectosProvider.numeroSucursal =
                                  match;
                              citasProvider.getCitas();
                            }
                          }
                        });
                      },
                    ),
                  )
                : const SizedBox.shrink(),
            const SizedBox(height: 10),
            SizedBox(
              width: constraints.maxWidth * 0.95,
              height: size.height * 0.75,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: SfCalendar(
                  controller: calendarController,
                  headerHeight: 50,
                  headerStyle: const CalendarHeaderStyle(
                    textAlign: TextAlign.center,
                    backgroundColor: Colors.blue,
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  viewHeaderStyle: ViewHeaderStyle(
                    backgroundColor: Colors.grey.withOpacity(0.2),
                  ),
                  showDatePickerButton: true,
                  backgroundColor: Colors.white,
                  view: CalendarView.month,
                  dataSource: CitasDataSource(citasProvider.citas),
                  appointmentTimeTextFormat: 'HH:mm',
                  monthViewSettings: const MonthViewSettings(
                    showAgenda: true,
                    appointmentDisplayMode:
                        MonthAppointmentDisplayMode.indicator,
                  ),
                  appointmentTextStyle: const TextStyle(color: Colors.white),
                  todayHighlightColor: Colors.blue,
                  selectionDecoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(color: Colors.blue, width: 2),
                    borderRadius: const BorderRadius.all(Radius.circular(4)),
                    shape: BoxShape.rectangle,
                  ),
                  // onTap: (CalendarTapDetails details) {
                  //   if (details.targetElement == CalendarElement.appointment) {
                  //     final Appointment meeting = details.appointments![0];
                  //     showDialog(
                  //       context: context,
                  //       builder: (context) => AlertDialog(
                  //         title: Text(meeting.subject),
                  //         content: Text('From ${meeting.startTime} to ${meeting.startTime}'),
                  //         actions: [
                  //           TextButton(
                  //             onPressed: () => Navigator.of(context).pop(),
                  //             child: const Text('OK'),
                  //           ),
                  //         ],
                  //       ),
                  //     );
                  //   }
                  // },
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class CitasDataSource extends CalendarDataSource {
  CitasDataSource(List<ModelClienteCitas> citas) {
    appointments = citas
        .map(
          (cita) => Appointment(
            startTime: cita.fecha,
            endTime: cita.fecha.add(const Duration(minutes: 30)),
            subject: cita.nombre,
            id: cita.idOferta,
            color: Colors.blue,
            isAllDay: false,
          ),
        )
        .toList();
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].startTime;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].endTime;
  }

  @override
  String getSubject(int index) {
    return appointments![index].subject;
  }

  @override
  Color getColor(int index) {
    return Colors.amber;
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].isAllDay;
  }
}
