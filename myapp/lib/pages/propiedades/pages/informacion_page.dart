import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:myapp/Theme.dart';
import 'package:myapp/providers.dart';
import 'package:myapp/widgets.dart';
import 'package:provider/provider.dart';

class InformacionPage extends StatefulWidget {
  const InformacionPage({Key? key}) : super(key: key);

  @override
  State<InformacionPage> createState() => _InformacionPageState();
}

class _InformacionPageState extends State<InformacionPage> {
  DateTime now = DateTime.now();
  @override
  Widget build(BuildContext context) {
    var UsuarioP = Provider.of<UsuarioProvider>(context, listen: false);
    return Scaffold(
      drawer: ArgonDrawer(),
      appBar: Navbar(
        title: 'Informacion',

        bgColor: Color(0xff48C1D3),
        backButton: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Container(
                    width: double.infinity,
                    height: 120,
                    decoration: ThisColors.boxDecoration(
                      15,
                      Color.fromARGB(255, 182, 182, 188).withOpacity(0.3),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  Gap(10),
                                  Text(
                                    'Area',
                                    style: ThisColors.titulo(
                                        Color(0xff565657), 16, FontWeight.w700),
                                  ),
                                  Gap(10),
                                  Text(
                                    UsuarioP.propiedadSelected
                                        .informacionPropiedad.totalArea
                                        .toString(),
                                    style: ThisColors.titulo(
                                        Color(0xff48C1D3), 20, FontWeight.w700),
                                  ),
                                  Gap(10),
                                  Text(
                                    'Metros cuadrados',
                                    style: ThisColors.titulo(
                                        Color.fromARGB(255, 115, 115, 118),
                                        13,
                                        FontWeight.w700),
                                  ),
                                  Gap(5),
                                ],
                              ),
                              Column(
                                children: [
                                  Gap(10),
                                  Text(
                                    'Participacion',
                                    style: ThisColors.titulo(
                                        Color(0xff565657), 16, FontWeight.w700),
                                  ),
                                  Gap(10),
                                  Text(
                                    UsuarioP.propiedadSelected
                                        .informacionPropiedad.totalHolding
                                        .toString(),
                                    style: ThisColors.titulo(
                                        Color(0xff48C1D3), 20, FontWeight.w700),
                                  ),
                                  Gap(10),
                                  Text(
                                    'Pocentaje',
                                    style: ThisColors.titulo(
                                        Color.fromARGB(255, 115, 115, 118),
                                        13,
                                        FontWeight.w700),
                                  ),
                                  Gap(5),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Container(
                    width: double.infinity,
                    height: 130,
                    decoration: ThisColors.boxDecoration(
                      15,
                      Color.fromARGB(255, 182, 182, 188).withOpacity(0.3),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Gap(10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  Gap(10),
                                  Text(
                                    'Saldo a Favor',
                                    style: ThisColors.titulo(
                                        Color(0xff565657), 16, FontWeight.w700),
                                  ),
                                  Gap(10),
                                  Text(
                                    UsuarioP
                                        .propiedadSelected
                                        .informacionPropiedad
                                        .totalPositiveBalance
                                        .toString(),
                                    style: ThisColors.titulo(
                                        Color(0xff48C1D3), 20, FontWeight.w700),
                                  ),
                                  Gap(10),
                                  Text(
                                    'Saldo al: ${now.day} ${lisMesesAbreviacion.elementAt(now.month)}, ${now.year}',
                                    style: ThisColors.titulo(
                                        Color.fromARGB(255, 115, 115, 118),
                                        13,
                                        FontWeight.w700),
                                  ),
                                  Gap(5),
                                ],
                              ),
                              GestureDetector(
                                onTap: () async {
                                  await showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      double alto = 50;
                                      return SimpleDialog(
                                        children: [
                                          Container(
                                            height: UsuarioP
                                                    .propiedadSelected
                                                    .informacionPropiedad
                                                    .residents!
                                                    .length *
                                                alto,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.80,
                                            child: ListView.builder(
                                              itemCount: UsuarioP
                                                  .propiedadSelected
                                                  .informacionPropiedad
                                                  .residents!
                                                  .length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return ListTile(
                                                  title: Container(
                                                    height: 50,
                                                    child: Center(
                                                      child: Text(
                                                          UsuarioP
                                                              .propiedadSelected
                                                              .informacionPropiedad
                                                              .residents!
                                                              .elementAt(index)
                                                              .fullname!,
                                                          style: ThisColors
                                                              .subtitulo(
                                                                  ThisColors
                                                                      .primary,
                                                                  16,
                                                                  FontWeight
                                                                      .normal)),
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          )
                                        ],
                                      );
                                    },
                                  );
                                },
                                child: Column(
                                  children: [
                                    Gap(14),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 15.0),
                                      child: Text(
                                        'Personas',
                                        style: ThisColors.titulo(
                                            Color(0xff565657),
                                            16,
                                            FontWeight.w700),
                                      ),
                                    ),
                                    Gap(5),
                                    Row(
                                      children: [
                                        Text(
                                          UsuarioP
                                              .propiedadSelected
                                              .informacionPropiedad
                                              .residents!
                                              .length
                                              .toString(),
                                          style: ThisColors.titulo(
                                              Color(0xff48C1D3),
                                              20,
                                              FontWeight.w700),
                                        ),
                                        Gap(10),
                                        const Icon(
                                          Icons.people,
                                          size: 40,
                                          color: Color(0xff48C1D3),
                                        ),
                                      ],
                                    ),
                                    // Gap(10),
                                    Text(
                                      'Ver Personas'.toString(),
                                      style: ThisColors.titulo(Color(0xff48C1D3),
                                          14, FontWeight.w700),
                                    ),
                                    Gap(10),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Container(
                    width: double.infinity,
                    height: 120,
                    decoration: ThisColors.boxDecoration(
                      15,
                      Color.fromARGB(255, 182, 182, 188).withOpacity(0.3),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  await showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      double alto = 65;
                                      return SimpleDialog(
                                        children: [
                                          Container(
                                            height: UsuarioP
                                                    .propiedadSelected
                                                    .informacionPropiedad
                                                    .parkings!
                                                    .length *
                                                alto,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.80,
                                            child: ListView.builder(
                                              itemCount: UsuarioP
                                                  .propiedadSelected
                                                  .informacionPropiedad
                                                  .parkings!
                                                  .length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return Container(
                                                  height: 60,
                                                  child: ListTile(
                                                    title: Text(
                                                        UsuarioP
                                                            .propiedadSelected
                                                            .informacionPropiedad
                                                            .parkings!
                                                            .elementAt(index)
                                                            .numberSection!,
                                                        style: ThisColors
                                                            .subtitulo(
                                                                ThisColors
                                                                    .primary,
                                                                16,
                                                                FontWeight
                                                                    .normal)),
                                                    subtitle: Column(
                                                      children: [
                                                        Text(
                                                            'Area: ${UsuarioP.propiedadSelected.informacionPropiedad.parkings!.elementAt(index).area!} mtrs2'),
                                                        Gap(5),
                                                        Text(
                                                            'Participacion: ${UsuarioP.propiedadSelected.informacionPropiedad.parkings!.elementAt(index).holding!}'),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          )
                                        ],
                                      );
                                    },
                                  );
                                },
                                child: Column(
                                  children: [
                                    Gap(10),
                                    Text(
                                      'Estacionamiento(s)',
                                      style: ThisColors.titulo(
                                          Color(0xff565657),
                                          16,
                                          FontWeight.w700),
                                    ),
                                    Gap(10),
                                    Row(
                                      children: [
                                        Text(
                                          UsuarioP
                                              .propiedadSelected
                                              .informacionPropiedad
                                              .parkings!
                                              .length
                                              .toString(),
                                          style: ThisColors.titulo(
                                              Color(0xff48C1D3),
                                              20,
                                              FontWeight.w700),
                                        ),
                                        Gap(10),
                                        Icon(
                                          FontAwesomeIcons.squareParking,
                                          size: 30,
                                          color: Color(0xff48C1D3),
                                        )
                                      ],
                                    ),
                                    Gap(10),
                                    Text(
                                      'Parking',
                                      style: ThisColors.titulo(
                                          Color.fromARGB(255, 115, 115, 118),
                                          13,
                                          FontWeight.w700),
                                    ),
                                    Gap(5),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Container(
                    width: double.infinity,
                    height: 120,
                    decoration: ThisColors.boxDecoration(
                      15,
                      Color.fromARGB(255, 182, 182, 188).withOpacity(0.3),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  await showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      double alto = 65;
                                      return SimpleDialog(
                                        children: [
                                          Container(
                                            height: UsuarioP
                                                    .propiedadSelected
                                                    .informacionPropiedad
                                                    .warehouses!
                                                    .length *
                                                alto,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.80,
                                            child: ListView.builder(
                                              itemCount: UsuarioP
                                                  .propiedadSelected
                                                  .informacionPropiedad
                                                  .warehouses!
                                                  .length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return Container(
                                                  height: 60,
                                                  child: ListTile(
                                                    title: Text(
                                                        UsuarioP
                                                            .propiedadSelected
                                                            .informacionPropiedad
                                                            .warehouses!
                                                            .elementAt(index)
                                                            .numberSection!,
                                                        style: ThisColors
                                                            .subtitulo(
                                                                ThisColors
                                                                    .primary,
                                                                16,
                                                                FontWeight
                                                                    .normal)),
                                                    subtitle: Column(
                                                      children: [
                                                        Text(
                                                            'Area: ${UsuarioP.propiedadSelected.informacionPropiedad.warehouses!.elementAt(index).area!} mtrs2'),
                                                        Gap(5),
                                                        Text(
                                                            'Participacion: ${UsuarioP.propiedadSelected.informacionPropiedad.warehouses!.elementAt(index).holding!}'),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          )
                                        ],
                                      );
                                    },
                                  );
                                },
                                child: Column(
                                  children: [
                                    Gap(10),
                                    Text(
                                      'Almacen(es)',
                                      style: ThisColors.titulo(
                                          Color(0xff565657),
                                          16,
                                          FontWeight.w700),
                                    ),
                                    Gap(10),
                                    Row(
                                      children: [
                                        Text(
                                          UsuarioP
                                              .propiedadSelected
                                              .informacionPropiedad
                                              .warehouses!
                                              .length
                                              .toString(),
                                          style: ThisColors.titulo(
                                              Color(0xff48C1D3),
                                              20,
                                              FontWeight.w700),
                                        ),
                                        Gap(10),
                                        Icon(
                                          FontAwesomeIcons.warehouse,
                                          size: 30,
                                          color: Color(0xff48C1D3),
                                        )
                                      ],
                                    ),
                                    Gap(10),
                                    Text(
                                      'Warehouses',
                                      style: ThisColors.titulo(
                                          Color.fromARGB(255, 115, 115, 118),
                                          13,
                                          FontWeight.w700),
                                    ),
                                    Gap(5),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Container(
                    width: double.infinity,
                    height: 120,
                    decoration: ThisColors.boxDecoration(
                      15,
                      Color.fromARGB(255, 182, 182, 188).withOpacity(0.3),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  await showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      double alto = 65;
                                      return SimpleDialog(
                                        children: [
                                          Container(
                                            height: UsuarioP
                                                    .propiedadSelected
                                                    .informacionPropiedad
                                                    .estates!
                                                    .length *
                                                alto,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.80,
                                            child: ListView.builder(
                                              itemCount: UsuarioP
                                                  .propiedadSelected
                                                  .informacionPropiedad
                                                  .estates!
                                                  .length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return Container(
                                                  height: 60,
                                                  child: ListTile(
                                                    title: Text(
                                                        UsuarioP
                                                            .propiedadSelected
                                                            .informacionPropiedad
                                                            .estates!
                                                            .elementAt(index)
                                                            .numberSection!,
                                                        style: ThisColors
                                                            .subtitulo(
                                                                ThisColors
                                                                    .primary,
                                                                16,
                                                                FontWeight
                                                                    .normal)),
                                                    subtitle: Column(
                                                      children: [
                                                        Text(
                                                            'Area: ${UsuarioP.propiedadSelected.informacionPropiedad.estates!.elementAt(index).area!} mtrs2'),
                                                        Gap(5),
                                                        Text(
                                                            'Participacion: ${UsuarioP.propiedadSelected.informacionPropiedad.estates!.elementAt(index).holding!}'),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          )
                                        ],
                                      );
                                    },
                                  );
                                },
                                child: Column(
                                  children: [
                                    Gap(10),
                                    Text(
                                      'Tienda(s)',
                                      style: ThisColors.titulo(
                                          Color(0xff565657),
                                          16,
                                          FontWeight.w700),
                                    ),
                                    Gap(10),
                                    Row(
                                      children: [
                                        Text(
                                          UsuarioP
                                              .propiedadSelected
                                              .informacionPropiedad
                                              .estates!
                                              .length
                                              .toString(),
                                          style: ThisColors.titulo(
                                              Color(0xff48C1D3),
                                              20,
                                              FontWeight.w700),
                                        ),
                                        Gap(10),
                                        Icon(
                                          FontAwesomeIcons.store,
                                          size: 30,
                                          color: Color(0xff48C1D3),
                                        )
                                      ],
                                    ),
                                    Gap(10),
                                    Text(
                                      'Estates',
                                      style: ThisColors.titulo(
                                          Color.fromARGB(255, 115, 115, 118),
                                          13,
                                          FontWeight.w700),
                                    ),
                                    Gap(5),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
