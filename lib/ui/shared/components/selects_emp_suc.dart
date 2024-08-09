import 'package:campanas_grid/providers/prospectos_provider.dart';
import 'package:campanas_grid/style_labels/style_labels.dart';
import 'package:campanas_grid/ui/shared/buttons/custom_dropdown.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectsEmpSuc extends StatefulWidget {
  final double width;
  final Function(dynamic) onChanged;
  final Function(dynamic) onChanged2;

  const SelectsEmpSuc({
    super.key,
    required this.width,
    required this.onChanged,
    required this.onChanged2,
  });

  @override
  State<SelectsEmpSuc> createState() => _SelectsEmpSucState();
}

class _SelectsEmpSucState extends State<SelectsEmpSuc> {
  
  final List<String> arrayEmpresa = [
    'AEF',
    'FISA',
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final prospectos = Provider.of<ProspectosProvider>(context);
    return Column(
      children: [
        size.width > 770
            ? Row(
                children: [
                  CustomDropdown(
                    hintDrop: 'Empresa',
                    onChanged: (value) {
                      setState(() {
                        widget.onChanged(value);
                      });
                    },
                    width: widget.width,
                    height: 49,
                    selectedValue: prospectos.empresa,
                    data: arrayEmpresa,
                  ),
                  SizedBox(width: size.width * 0.01),
                  DropSearchSucursales(
                    width: widget.width,
                    height: 50,
                    empresa: prospectos.empresa,
                    onChanged2: (value) {
                      setState(() {
                        widget.onChanged2(value);
                      });
                    },
                  ),
                  SizedBox(width: size.width * 0.01),
                  prospectos.isVisible == true
                      ? TextButton.icon(
                          onPressed: () {
                            prospectos.reportDownload();
                          },
                          label: Text(
                            'Lista prospectos',
                            style: StyleLabels.dataColumn,
                          ),
                          icon: const Icon(
                            Icons.download_rounded,
                            color: Color.fromARGB(255, 68, 68, 68),
                          ),
                        )
                      : const SizedBox.shrink(),
                ],
              )
            : Column(
                children: [
                  Row(
                    children: [
                      SizedBox(width: size.width * 0.02),
                      CustomDropdown(
                        hintDrop: 'Empresa',
                        onChanged: (value) {
                          setState(() {
                            widget.onChanged(value);
                          });
                        },
                        width: widget.width,
                        height: 49,
                        selectedValue: prospectos.empresa,
                        data: arrayEmpresa,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      SizedBox(width: size.width * 0.02),
                      DropSearchSucursales(
                        width: widget.width,
                        height: 50,
                        empresa: prospectos.empresa,
                        onChanged2: (value) {
                          setState(() {
                            widget.onChanged2(value);
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  prospectos.isVisible == true
                      ? Row(
                          children: [
                            SizedBox(width: size.width * 0.02),
                            TextButton.icon(
                              onPressed: () {
                                prospectos.reportDownload();
                              },
                              label: Text(
                                'Lista prospectos',
                                style: StyleLabels.dataColumn,
                              ),
                              icon: const Icon(
                                Icons.download_rounded,
                                color: Color.fromARGB(255, 68, 68, 68),
                              ),
                            ),
                          ],
                        )
                      : const SizedBox.shrink(),
                ],
              )
      ],
    );
  }
}

// ignore: must_be_immutable
class DropSearchSucursales extends StatefulWidget {
  final double width;
  final double height;
  String? empresa;
  final Function(dynamic) onChanged2;

  DropSearchSucursales({
    super.key,
    required this.width,
    required this.height,
    this.empresa,
    required this.onChanged2,
  });

  @override
  State<DropSearchSucursales> createState() => _DropSearchSucursalesState();
}

class _DropSearchSucursalesState extends State<DropSearchSucursales> {
 

  @override
  void initState() {
    super.initState();
    Provider.of<ProspectosProvider>(context, listen: false).getSucursal();
  }

  @override
  Widget build(BuildContext context) {
    final prospectos = Provider.of<ProspectosProvider>(context);
    return DropdownSearch<dynamic>(
      enabled: widget.empresa != null,
      dropdownDecoratorProps: DropDownDecoratorProps(
        baseStyle: StyleLabels.itemDrop,
        dropdownSearchDecoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          label: Text('Sucursales',
              style: widget.empresa != null
                  ? StyleLabels.textoDrop2
                  : StyleLabels.textoDrop3),
          suffixIconColor: widget.empresa != null
              ? const Color.fromARGB(255, 68, 68, 68)
              : const Color.fromARGB(255, 160, 155, 155),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Color.fromARGB(255, 68, 68, 68),
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Color.fromARGB(255, 160, 155, 155),
            ),
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Color.fromARGB(255, 68, 68, 68),
              )),
          constraints: BoxConstraints(
            maxWidth: widget.width,
            maxHeight: widget.height,
          ),
        ),
      ),
      popupProps: const PopupProps.menu(
          searchFieldProps: TextFieldProps(), showSearchBox: true),
      items: widget.empresa == null
          ? []
          : prospectos.sucursal
              .map((e) => '${e.descripcionSucursal} - ${e.noSucursal}')
              .toList(),
      onChanged: (value) {
        setState(() {
          widget.onChanged2(value);
        });
      },
      selectedItem: prospectos.selectedSucursal,
    );
  }
}
