import 'package:auto_size_text/auto_size_text.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gap/gap.dart';
import 'package:myapp/Theme.dart';
import 'package:myapp/providers.dart';
import 'package:myapp/share_preference/preferencias_usuario.dart';
import 'package:myapp/widgets.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class PerfilPage extends StatefulWidget {
  PerfilPage({Key? key}) : super(key: key);

  @override
  State<PerfilPage> createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  TextEditingController observacionesController = TextEditingController();
  String siglasNombre = '??';
  @override
  void initState() {
    observacionesController.text = '';
    try {
      var pref = PreferenciasUsuario();
      var list = pref.userName.split(' ');
      if (list.length > 1) {
        siglasNombre =
            '${list.elementAt(0).substring(0, 1)}${list.elementAt(1).substring(0, 1)}';
        observacionesController.text = pref.commentary;
      }
    } catch (e) {}
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var pref = PreferenciasUsuario();
    var usuarioP = Provider.of<UsuarioProvider>(context, listen: false);
    return SafeArea(
      top: false,
      child: Scaffold(
        // backgroundColor: ThisColors.primary,
        drawer: ArgonDrawer(),
        appBar: Navbar(
          bgColor: ThisColors.primary,
          title: "Perfil",
        ),
        bottomNavigationBar: BotomNavBarWidget(index: 2),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 75,
                        width: 75,
                        decoration: BoxDecoration(
                          color: ThisColors.primary,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            siglasNombre,
                            style: ThisColors.titulo(
                                ThisColors.white, 25, FontWeight.w400),
                          ),
                        ),
                      ),
                      Gap(20),
                      GestureDetector(
                        onTap: () async {
                          var rpta = await showDialog(
                            // barrierColor: ThisColors.primary,

                            barrierDismissible: true,
                            context: context,
                            builder: (BuildContext context) {
                              return SimpleDialog(
                                backgroundColor: ThisColors.primary,
                                title: Text(
                                  '¿Desea actualizar los datos de su perfil?',
                                  style: ThisColors.titulo(
                                      Color.fromARGB(255, 255, 255, 255),
                                      25,
                                      FontWeight.w400),
                                ),
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context, false);
                                        },
                                        child: Container(
                                          width: 80,
                                          height: 25,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: Color.fromARGB(
                                                255, 217, 49, 49),
                                          ),
                                          child: Center(
                                            child: Text(
                                              'No',
                                              style: ThisColors.titulo(
                                                  ThisColors.white,
                                                  15,
                                                  FontWeight.w400),
                                            ),
                                          ),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context, true);
                                        },
                                        child: Container(
                                          width: 80,
                                          height: 25,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: Color.fromARGB(
                                                255, 66, 179, 49),
                                          ),
                                          child: Center(
                                            child: Text(
                                              'Si',
                                              style: ThisColors.titulo(
                                                  ThisColors.white,
                                                  15,
                                                  FontWeight.w400),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              );
                            },
                          );
                          if (rpta) {
                            // EasyLoading.show(
                            //     status: 'Actualizando datos de perfil');
                            await pref.updatePerfil();
                            EasyLoading.dismiss();
                          }
                        },
                        child: Container(
                          height: 50,
                          width: 70,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: ThisColors.primary.withOpacity(0.85),
                            // shape: BoxShape.rectangle,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                'Actualizar',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 11),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 3.0),
                                child: Icon(
                                  Icons.update,
                                  color: Colors.white,
                                  size: 23,
                                ),
                              ),
                              // Gap(3),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Gap(45),
                  Row(
                    children: [
                      Text(
                        'Nombre:',
                        style: ThisColors.titulo(
                            Color.fromARGB(255, 34, 20, 48),
                            17,
                            FontWeight.bold),
                      ),
                      Gap(20),
                      Container(
                        // color: Colors.red,
                        width: 200,
                        child: AutoSizeText(
                          '${pref.userName}',
                          style: ThisColors.titulo(
                              Color.fromARGB(255, 137, 109, 142),
                              13,
                              FontWeight.bold),
                          maxLines: 2,
                        ),
                      ),
                    ],
                  ),
                  Divider(),
                  Gap(15),
                  Row(
                    children: [
                      Text(
                        'Correo:',
                        style: ThisColors.titulo(
                            Color.fromARGB(255, 34, 20, 48),
                            17,
                            FontWeight.bold),
                      ),
                      Gap(20),
                      Container(
                        // color: Colors.red,
                        width: 200,
                        child: AutoSizeText(
                          '${pref.userEmail}',
                          style: ThisColors.titulo(
                              Color.fromARGB(255, 137, 109, 142),
                              13,
                              FontWeight.bold),
                          maxLines: 2,
                        ),
                      ),
                      // Gap(10),
                      // Icon(EvaIcons.edit),
                    ],
                  ),
                  Divider(),
                  Gap(15),
                  Row(
                    children: [
                      Text(
                        'Usuario:',
                        style: ThisColors.titulo(
                            Color.fromARGB(255, 34, 20, 48),
                            17,
                            FontWeight.bold),
                      ),
                      Gap(20),
                      Container(
                        // color: Colors.red,
                        width: 200,
                        child: AutoSizeText(
                          '${pref.userId}',
                          style: ThisColors.titulo(
                              Color.fromARGB(255, 137, 109, 142),
                              13,
                              FontWeight.bold),
                          maxLines: 2,
                        ),
                      ),
                      // Gap(10),
                      // Icon(EvaIcons.edit),
                    ],
                  ),
                  Divider(),
                  Gap(15),
                  Row(
                    children: [
                      Text(
                        'Doc. identidad:',
                        style: ThisColors.titulo(
                            Color.fromARGB(255, 34, 20, 48),
                            17,
                            FontWeight.bold),
                      ),
                      Gap(20),
                      Container(
                        // color: Colors.red,
                        width: 120,
                        child: AutoSizeText(
                          pref.number_document,
                          style: ThisColors.titulo(
                              Color.fromARGB(255, 137, 109, 142),
                              13,
                              FontWeight.bold),
                          maxLines: 2,
                        ),
                      ),
                      Gap(10),
                      GestureDetector(
                        onTap: () async {
                          TextEditingController dniController =
                              TextEditingController();
                          dniController.text = pref.number_document;
                          var rpta = await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return SimpleDialog(
                                backgroundColor: ThisColors.primary,
                                title: Text('Ingrese su nro de DNI',
                                    style: TextStyle(color: Colors.white)),
                                children: [
                                  Gap(10),
                                  ListTile(
                                    leading: Text('DNI:',
                                        style: TextStyle(color: Colors.white)),
                                    title: TextFormField(
                                      style: TextStyle(color: Colors.white),
                                      controller: dniController,
                                      // initialValue: pref.number_document,

                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      onFieldSubmitted: (value) {
                                        if (value.length < 20) {
                                          print(value);
                                          Navigator.pop(context, value);
                                        } else {
                                          EasyLoading.showInfo(
                                              'Exedio el maximo de caracteres. (20 caracteres)');
                                        }
                                      },
                                      keyboardType:
                                          TextInputType.numberWithOptions(),
                                    ),
                                  ),
                                  Gap(20),
                                  Center(
                                    child: GestureDetector(
                                      onTap: () {
                                        if (dniController.text.length < 20) {
                                          print(dniController.text);
                                          Navigator.pop(
                                              context, dniController.text);
                                        } else {
                                          EasyLoading.showInfo(
                                              'Exedio el maximo de caracteres. (20 caracteres)');
                                        }
                                      },
                                      child: Container(
                                        height: 35,
                                        width: 120,
                                        decoration: BoxDecoration(
                                          color:
                                              Color.fromARGB(255, 50, 33, 78),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: Center(
                                          child: Text(
                                            'Guardar',
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Gap(10),
                                ],
                              );
                            },
                          );
                          if (rpta != null) {
                            if (rpta.isNotEmpty &&
                                rpta
                                        .toString()
                                        .compareTo(pref.number_document) !=
                                    0) {
                              pref.number_document = rpta;
                              setState(() {});
                            }
                          }
                        },
                        child: Icon(EvaIcons.edit),
                      ),
                    ],
                  ),
                  Divider(),
                  Gap(15),
                  Row(
                    children: [
                      Text(
                        'Telefono:',
                        style: ThisColors.titulo(
                            Color.fromARGB(255, 34, 20, 48),
                            17,
                            FontWeight.bold),
                      ),
                      Gap(20),
                      Container(
                        // color: Colors.red,
                        width: 156,
                        child: AutoSizeText(
                          pref.phone,
                          style: ThisColors.titulo(
                              Color.fromARGB(255, 137, 109, 142),
                              13,
                              FontWeight.bold),
                          maxLines: 2,
                        ),
                      ),
                      Gap(10),
                      GestureDetector(
                        onTap: () async {
                          TextEditingController telefonoController =
                              TextEditingController();
                          telefonoController.text = pref.phone;
                          var rpta = await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return SimpleDialog(
                                backgroundColor: ThisColors.primary,
                                title: Text(
                                  'Ingrese su numero de telefono',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                children: [
                                  Gap(10),
                                  ListTile(
                                    leading: Text(
                                      'Numero:',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    title: TextFormField(
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                      controller: telefonoController,
                                      // initialValue: pref.phone,
                                      onFieldSubmitted: (value) {
                                        print(value);
                                        Navigator.pop(context, value);
                                      },
                                      keyboardType: TextInputType.phone,
                                    ),
                                  ),
                                  Gap(20),
                                  Center(
                                    child: GestureDetector(
                                      onTap: () {
                                        if (telefonoController.text.length <
                                            20) {
                                          print(telefonoController.text);
                                          Navigator.pop(
                                              context, telefonoController.text);
                                        } else {
                                          EasyLoading.showInfo(
                                              'Exedio el maximo de caracteres. (20 caracteres)');
                                        }
                                      },
                                      child: Container(
                                        height: 35,
                                        width: 120,
                                        decoration: BoxDecoration(
                                          color:
                                              Color.fromARGB(255, 50, 33, 78),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: Center(
                                          child: Text(
                                            'Guardar',
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Gap(10),
                                ],
                              );
                            },
                          );
                          if (rpta != null) {
                            if (rpta.isNotEmpty &&
                                rpta.toString().compareTo(pref.phone) != 0) {
                              pref.phone = rpta;
                              setState(() {});
                            }
                          }
                        },
                        child: Icon(EvaIcons.edit),
                      ),
                    ],
                  ),
                  Divider(),
                  Gap(15),
                  Row(
                    children: [
                      Text(
                        'F. Nacimiento:',
                        style: ThisColors.titulo(
                            Color.fromARGB(255, 34, 20, 48),
                            17,
                            FontWeight.bold),
                      ),
                      Gap(20),
                      Container(
                        // color: Colors.red,
                        width: 120,
                        child: Text(
                          (pref.date_birth.isNotEmpty)
                              ? pref.date_birth
                              : 'PENDIENTE',
                          // '10.10.1000 9pm',
                          style: ThisColors.titulo(
                              Color.fromARGB(255, 137, 109, 142),
                              13,
                              FontWeight.bold),
                          maxLines: 2,
                        ),
                      ),
                      Gap(10),
                      GestureDetector(
                        onTap: () async {
                          var fecha = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1900),
                              lastDate: DateTime(2100),
                              builder: (context, child) {
                                return Theme(
                                  data: Theme.of(context).copyWith(
                                    colorScheme: ColorScheme.light(
                                      primary: ThisColors
                                          .primary,
                                      onPrimary:
                                          ThisColors.white,
                                      onSurface:
                                          ThisColors.primary,
                                    ),
                                    textButtonTheme: TextButtonThemeData(
                                      style: TextButton.styleFrom(
                                        primary: ThisColors
                                            .primary,
                                      ),
                                    ),
                                  ),
                                  child: child!,
                                );
                              });
                          if (fecha != null) {
                            String mes = '';
                            if (fecha.month < 10) {
                              mes = '0${fecha.month}';
                            }
                            String formattedDate = DateFormat('dd-MM-yyyy').format(fecha);
                            pref.date_birth = formattedDate;
                            setState(() {});
                          }
                        },
                        child: Icon(EvaIcons.edit),
                      ),
                    ],
                  ),
                  Divider(),
                  Gap(15),
                  Row(
                    children: [
                      Text(
                        'Obser:',
                        style: ThisColors.titulo(
                            Color.fromARGB(255, 34, 20, 48),
                            17,
                            FontWeight.bold),
                      ),
                      Gap(20),
                      Container(
                        // color: Colors.red,
                        width: 178,
                        height: 150,
                        child: Text(
                          (pref.commentary.isNotEmpty)
                              ? pref.commentary
                              : 'Ingrese una observacion, maximo 200 letras.',
                          // : 'PENDIENTE',
                          // '10.10.1000 9pm',
                          softWrap: true,
                          style: ThisColors.titulo(
                              (pref.commentary.isNotEmpty)
                                  ? Color.fromARGB(255, 137, 109, 142)
                                  : Color.fromARGB(255, 171, 171, 171),
                              13,
                              FontWeight.bold),
                          maxLines: 10,
                        ),
                      ),
                      Gap(10),
                      GestureDetector(
                        onTap: () async {
                          TextEditingController observacionesController =
                              TextEditingController();
                          observacionesController.text = pref.commentary;
                          var rpta = await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return SimpleDialog(
                                backgroundColor: ThisColors.primary,
                                title: Text(
                                  'Escriba sus observaciones',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                children: [
                                  Gap(10),
                                  ListTile(
                                    leading: Text(
                                      'Obs:',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    title: TextFormField(
                                      style: TextStyle(color: Colors.white),
                                      controller: observacionesController,
                                      // initialValue: pref.commentary,
                                      maxLines: 10,
                                      onFieldSubmitted: (value) {
                                        print(value);
                                        if (value.length <= 200) {
                                          pref.commentary = value;
                                          setState(() {});
                                          Navigator.pop(context, value);
                                        } else {
                                          EasyLoading.showError(
                                              '200 caracateres como maximo');
                                        }
                                      },
                                      // keyboardType: TextInputType.phone,
                                    ),
                                  ),
                                  Gap(20),
                                  Center(
                                    child: GestureDetector(
                                      onTap: () {
                                        if (observacionesController
                                                .text.length <
                                            200) {
                                          print(observacionesController.text);
                                          Navigator.pop(context,
                                              observacionesController.text);
                                        } else {
                                          EasyLoading.showInfo(
                                              'Exedio el maximo de caracteres. (200 caracteres)');
                                        }
                                      },
                                      child: Container(
                                        height: 35,
                                        width: 120,
                                        decoration: BoxDecoration(
                                          color:
                                              Color.fromARGB(255, 50, 33, 78),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: Center(
                                          child: Text(
                                            'Guardar',
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Gap(10),
                                ],
                              );
                            },
                          );
                          if (rpta != null) {
                            if (rpta.isNotEmpty &&
                                rpta.toString().compareTo(pref.commentary) !=
                                    0) {
                              if (rpta.toString().length <= 200) {
                                pref.commentary = rpta;
                                setState(() {});
                              } else {
                                EasyLoading.showError(
                                    '200 caracateres como maximo');
                              }
                            }
                          }
                        },
                        child: Icon(EvaIcons.edit),
                      ),
                    ],
                  ),
                  Divider(),
                  Gap(15),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
