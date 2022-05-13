import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:myapp/Theme.dart';
import 'package:myapp/providers.dart';
import 'package:myapp/widgets.dart';
import 'package:provider/provider.dart';

class VerPagosPage extends StatefulWidget {

  @override
  State<VerPagosPage> createState() => _VerPagosPageState();
}

class _VerPagosPageState extends State<VerPagosPage> {
  @override
  Widget build(BuildContext context) {
    var UsuarioP = Provider.of<UsuarioProvider>(context, listen: false);
    return Scaffold(
      drawer: ArgonDrawer(),
      appBar: Navbar(
        title: 'PAGOS',
        bgColor: const Color(0xff19A64C),
        backButton: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              const Gap(10),
              Expanded(
                child: ListView.builder(
                  itemCount: UsuarioP.usuarioSelected.listaPagos.length,
                  itemBuilder: (BuildContext context, int index) {
                    Pago pago= Pago();
                    pago=UsuarioP.usuarioSelected.listaPagos.elementAt(index);
                    List date=pago.collection_date.split('-');
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Container(
                        width: double.infinity,
                        height: 63,
                        decoration: ThisColors.boxDecoration(
                          15,
                          const Color.fromARGB(255, 182, 182, 188).withOpacity(0.3),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    pago.total_amount_collection,
                                    style: ThisColors.titulo(
                                        const Color(0xff19A64C),
                                        20,
                                        FontWeight.w700),
                                  ),
                                  const Gap(5),
                                  
                                  Text(
                                    '${date.elementAt(0)} ${lisMesesAbreviacion.elementAt(int.parse(date.elementAt(1)))} ${date.elementAt(2)}',
                                    style: ThisColors.subtitulo(
                                        const Color(0xff565657), 13, FontWeight.normal),
                                  ),
                                  
                                  
                                ],
                              ),
                              
                              Expanded(child: Container()),
                              Icon(
                                Icons.monetization_on,
                                size: 35,
                                color:  Color(0xff19A64C)
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
