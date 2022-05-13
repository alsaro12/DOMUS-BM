import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gap/gap.dart';
import 'package:line_icons/line_icons.dart';
import 'package:myapp/Theme.dart';
import 'package:myapp/pages/propiedades/pages/camera_page.dart';
import 'package:myapp/providers.dart';
import 'package:myapp/share_preference/route_transition_do.dart';
import 'package:myapp/widgets.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class VerDeudasPage extends StatefulWidget {
  @override
  State<VerDeudasPage> createState() => _VerDeudasPageState();
}

class _VerDeudasPageState extends State<VerDeudasPage> {
  cargarTotal() async {
    var UsuarioP = Provider.of<UsuarioProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    var usuarioP = Provider.of<UsuarioProvider>(context, listen: false);
    return Scaffold(
      drawer: ArgonDrawer(),
      appBar: Navbar(
        title: 'DEUDAS',
        bgColor: ThisColors.label,
        backButton: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(10),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  'TOTAL EN DEUDAS',
                  style: ThisColors.titulo(
                      const Color(0xff565657), 16, FontWeight.w700),
                ),
              ),
              const Gap(10),
              Center(
                child: FutureBuilder(
                  future: cargarTotal(),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    return Container(
                      width: 200,
                      height: 80,
                      decoration:
                          ThisColors.boxDecoration(15, ThisColors.label),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${usuarioP.propiedadSelected.amount_debt}',
                              textAlign: TextAlign.center,
                              style: ThisColors.titulo(
                                  ThisColors.white, 30, FontWeight.w700),
                            ),
                            Text(
                              'Nuevos Soles.',
                              textAlign: TextAlign.center,
                              style: ThisColors.titulo(
                                  ThisColors.white, 13, FontWeight.w700),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const Gap(20),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  'LISTA DE DEUDAS',
                  style: ThisColors.titulo(
                      const Color(0xff565657), 16, FontWeight.w700),
                ),
              ),
              const Gap(10),
              Expanded(
                child: ListView.builder(
                  itemCount: usuarioP.propiedadSelected.listaDeudas.length,
                  itemBuilder: (BuildContext context, int index) {
                    Deuda deuda = Deuda();
                    deuda =
                        usuarioP.propiedadSelected.listaDeudas.elementAt(index);
                    // List date=recibo.collection_date.split('-');
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Container(
                        width: double.infinity,
                        height: 65,
                        decoration: ThisColors.boxDecoration(
                          15,
                          const Color.fromARGB(255, 182, 182, 188)
                              .withOpacity(0.3),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Gap(20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // const Gap(10),
                                  Text(
                                    deuda.name_period_receipt,
                                    style: ThisColors.titulo(
                                        const Color(0xff565657),
                                        16,
                                        FontWeight.w700),
                                  ),
                                  Gap(7),
                                  Text(
                                    deuda.amount_debt,
                                    style: ThisColors.titulo(
                                        // ThisColors.label,
                                        ThisColors.label,
                                        20,
                                        FontWeight.w700),
                                  ),
                                ],
                              ),
                              Expanded(child: Container()),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      if (!await launch(deuda.url_receipt)) {
                                        throw EasyLoading.showInfo(
                                            'No se pudo abrir link de PDF');
                                      }
                                    },
                                    child: Icon(LineIcons.pdfFile,
                                        size: 38, color: ThisColors.label),
                                  ),
                                  Gap(20),
                                  GestureDetector(
                                    onTap: (){
                                      
                                      RouteTransitionDo(
                                    context: context,
                                    animationType: AnimationType.fadeIn,
                                    child: CameraApp(),
                                  );
                                    },
                                    child: Icon(LineIcons.camera,
                                        size: 38, color: ThisColors.label),
                                  ),
                                ],
                              ),
                              Gap(8),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
