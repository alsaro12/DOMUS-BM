import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:myapp/Theme.dart';
import 'package:myapp/providers.dart';
import 'package:myapp/widgets.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class VerRecibosPage extends StatefulWidget {
  @override
  State<VerRecibosPage> createState() => _VerRecibosPageState();
}

class _VerRecibosPageState extends State<VerRecibosPage> {
  @override
  Widget build(BuildContext context) {
    var UsuarioP = Provider.of<UsuarioProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.grey[200],
      drawer: ArgonDrawer(),
      appBar: Navbar(
        title: 'RECIBOS',
        bgColor: const Color(0xff4A94CF),
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
                  'LISTA DE RECIBOS',
                  style: ThisColors.titulo(
                      const Color(0xff565657), 16, FontWeight.w700),
                ),
              ),
              const Gap(10),
              Expanded(
                child: ListView.builder(
                  itemCount: UsuarioP.usuarioSelected.listRecibos.length,
                  itemBuilder: (BuildContext context, int index) {
                    Recibos recibo = Recibos();
                    recibo =
                        UsuarioP.usuarioSelected.listRecibos.elementAt(index);
                    // List date=recibo.collection_date.split('-');
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Container(
                        width: double.infinity,
                        height: 70,
                        decoration: ThisColors.boxDecoration(
                          15,
                          Colors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Gap(10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // const Gap(10),
                                  Text(
                                    recibo.name_period_receipt,
                                    style: ThisColors.titulo(
                                        const Color(0xff565657),
                                        16,
                                        FontWeight.w700),
                                  ),
                                  Gap(10),
                                  Text(
                                    recibo.total_receipt,
                                    style: ThisColors.titulo(
                                        const Color(0xff4A94CF),
                                        20,
                                        FontWeight.w700),
                                  ),
                                ],
                              ),
                              Expanded(child: Container()),
                              GestureDetector(
                                    onTap: () async {
                                      if (!await launch(recibo.url_receipt)) {
                                        throw EasyLoading.showInfo(
                                            'No se pudo abrir link de PDF');
                                      }
                                    },
                                    child: const Padding(
                                      padding: EdgeInsets.only( right: 10),
                                      child: Icon(FontAwesomeIcons.filePdf,
                                          size: 50, color: Color(0xff4A94CF)),
                                    ),
                                  ),
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
