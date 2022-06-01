import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:myapp/Theme.dart';
import 'package:myapp/pages/propiedades/pages/informacion_page.dart';
import 'package:myapp/pages/propiedades/pages/recibos_page.dart';
import 'package:myapp/pages/propiedades/pages/ver_deuda_page.dart';
import 'package:myapp/pages/propiedades/pages/ver_pagos_page.dart';
import 'package:myapp/providers.dart';
import 'package:myapp/share_preference/route_transition_do.dart';
import 'package:myapp/widgets.dart';
import 'package:provider/provider.dart';

class OpcionesPropiedadesPage extends StatefulWidget {
  OpcionesPropiedadesPage({Key? key}) : super(key: key);

  @override
  State<OpcionesPropiedadesPage> createState() =>
      _OpcionesPropiedadesPageState();
}

class _OpcionesPropiedadesPageState extends State<OpcionesPropiedadesPage> {
  @override
  Widget build(BuildContext context) {
    var UsuarioP = Provider.of<UsuarioProvider>(context, listen: false);
    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        drawer: ArgonDrawer(),
        appBar: Navbar(
          title: UsuarioP.propiedadSelected.name_realestate,
          bgColor: ThisColors.primary,
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
                      height: 150,
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
                            Text(
                              'DEUDA TOTAL',
                              style: ThisColors.titulo(
                                  Color(0xff565657), 16, FontWeight.w700),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Gap(10),
                                    Text(
                                      UsuarioP.propiedadSelected.amount_debt,
                                      style: ThisColors.titulo(
                                          ThisColors.label, 20, FontWeight.w700),
                                    ),
                                    Gap(10),
                                    Text(
                                      'Total de recibos pendientes de pago.',
                                      style: ThisColors.titulo(
                                          Color.fromARGB(255, 115, 115, 118),
                                          13,
                                          FontWeight.w700),
                                    ),
                                    Gap(5),
                                  ],
                                ),
                                // Gap(20),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 8.0, right: 20),
                                  child: Icon(
                                    FontAwesomeIcons.moneyBill1,
                                    size: 50,
                                    color: ThisColors.label,
                                  ),
                                ),
                              ],
                            ),
                            Divider(
                                color: Color.fromARGB(255, 174, 174, 173),
                                thickness: 1.5),
                            Gap(5),
                            Center(
                              child: GestureDetector(
                                onTap: () async {
                                  await UsuarioP.propiedadSelected.cargarDeudas(
                                      UsuarioP.propiedadSelected.r_block_id);
    
                                  RouteTransitionDo(
                                    context: context,
                                    animationType: AnimationType.fadeIn,
                                    child: VerDeudasPage(),
                                  );
                                },
                                child: Text(
                                  'Ver Deuda',
                                  style: ThisColors.subtitulo(
                                      ThisColors.label, 13, FontWeight.normal),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Container(
                      width: double.infinity,
                      height: 150,
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
                            Text(
                              'INFORMACIÓN',
                              style: ThisColors.titulo(
                                  Color(0xff565657), 16, FontWeight.w700),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Gap(10),
                                    Container(
                                      width: 250,
                                      child: Text(
                                        'Información adicional del departamento: propietario, estacionamiento, etc.',
                                        style: ThisColors.titulo(
                                            Color.fromARGB(255, 115, 115, 118),
                                            13,
                                            FontWeight.w700),
                                      ),
                                    ),
                                    Gap(5),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 8.0, right: 20),
                                  child: Icon(
                                    FontAwesomeIcons.circleInfo,
                                    size: 50,
                                    color: Color(0xff48C1D3),
                                  ),
                                ),
                              ],
                            ),
                            Divider(
                                color: Color.fromARGB(255, 174, 174, 173),
                                thickness: 1.5),
                            Gap(5),
                            Center(
                              child: GestureDetector(
                                onTap: () async {
                                  InformacionPropiedad informacionPropiedad =
                                      await UsuarioP.propiedadSelected
                                          .cargarInformacion(UsuarioP
                                              .propiedadSelected.r_block_id);
                                  UsuarioP.propiedadSelected
                                          .informacionPropiedad =
                                      informacionPropiedad;
    
                                  RouteTransitionDo(
                                    context: context,
                                    animationType: AnimationType.fadeIn,
                                    child: InformacionPage(),
                                  );
                                },
                                child: Text(
                                  'Ver Información',
                                  style: ThisColors.subtitulo(
                                      Color(0xff48C1D3), 13, FontWeight.normal),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Container(
                      width: double.infinity,
                      height: 150,
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
                            Text(
                              'RECIBOS',
                              style: ThisColors.titulo(
                                  Color(0xff565657), 16, FontWeight.w700),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Gap(10),
                                    Container(
                                      width: 250,
                                      child: Text(
                                        'Revisa tus recibos pasados y su estado de pago',
                                        style: ThisColors.titulo(
                                            Color.fromARGB(255, 115, 115, 118),
                                            13,
                                            FontWeight.w700),
                                      ),
                                    ),
                                    Gap(5),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 8.0, right: 20),
                                  child: Icon(
                                    FontAwesomeIcons.fileLines,
                                    size: 50,
                                    color: Color(0xff4A94CF),
                                  ),
                                ),
                              ],
                            ),
                            Divider(
                                color: Color.fromARGB(255, 174, 174, 173),
                                thickness: 1.5),
                            Gap(5),
                            Center(
                              child: GestureDetector(
                                onTap: () async {
                                  await UsuarioP.usuarioSelected.cargarRecibos(
                                      UsuarioP.propiedadSelected.r_block_id);
                                  RouteTransitionDo(
                                    context: context,
                                    animationType: AnimationType.fadeIn,
                                    child: VerRecibosPage(),
                                  );
                                },
                                child: Text(
                                  'Ver Recibos',
                                  style: ThisColors.subtitulo(
                                      Color(0xff4A94CF), 13, FontWeight.normal),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Container(
                      width: double.infinity,
                      height: 150,
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
                            Text(
                              'PAGOS',
                              style: ThisColors.titulo(
                                  Color(0xff565657), 16, FontWeight.w700),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Gap(10),
                                    Container(
                                      width: 250,
                                      child: Text(
                                        'Revisa el historial de pagos.',
                                        style: ThisColors.titulo(
                                            Color.fromARGB(255, 115, 115, 118),
                                            13,
                                            FontWeight.w700),
                                      ),
                                    ),
                                    Gap(5),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 8.0, right: 20),
                                  child: Icon(
                                    FontAwesomeIcons.fileLines,
                                    size: 50,
                                    color: Color(0xff19A64C),
                                  ),
                                ),
                              ],
                            ),
                            Divider(
                                color: Color.fromARGB(255, 174, 174, 173),
                                thickness: 1.5),
                            Gap(5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    await UsuarioP.usuarioSelected.cargarPagos(
                                        UsuarioP.propiedadSelected.r_block_id);
                                    RouteTransitionDo(
                                        context: context,
                                        animationType: AnimationType.fadeIn,
                                        child: VerPagosPage());
                                  },
                                  child: Text(
                                    'Ver Pagos',
                                    style: ThisColors.subtitulo(
                                        Color(0xff19A64C), 13, FontWeight.normal),
                                  ),
                                ),
                              ],
                            )
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
      ),
    );
  }
}
