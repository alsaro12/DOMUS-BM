
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:myapp/Theme.dart';
import 'package:myapp/pages/propiedades/opciones_propiedades.dart';
import 'package:myapp/providers.dart';
import 'package:myapp/share_preference/preferencias_usuario.dart';
import 'package:myapp/share_preference/route_transition_do.dart';
import 'package:myapp/widgets.dart';
import 'package:provider/provider.dart';

class MisPropiedadesPage extends StatefulWidget {
  MisPropiedadesPage({Key? key}) : super(key: key);

  @override
  State<MisPropiedadesPage> createState() => _MisPropiedadesPageState();
}

class _MisPropiedadesPageState extends State<MisPropiedadesPage> {
  @override
  Widget build(BuildContext context) {
    var usuarioP = Provider.of<UsuarioProvider>(context, listen: false);
    var pref = PreferenciasUsuario();
    return SafeArea(
      top: false,
      child: Scaffold(
        drawer: ArgonDrawer(),
        appBar: Navbar(
          title: "Mis Propiedades",
        ),
        bottomNavigationBar: BotomNavBarWidget(index: 1),
        body: SafeArea(
          child: Column(
            children: [
              Gap(10),
              Expanded(
                child: FutureBuilder(
                  future: usuarioP.usuarioSelected.cargarPropiedades(context),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return ListView.builder(
                        itemCount:
                            usuarioP.usuarioSelected.listPropiedades.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 5),
                            child: Container(
                              height: 200,
                              color: ThisColors.primary,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      usuarioP.propiedadSelected = usuarioP
                                          .usuarioSelected.listPropiedades
                                          .elementAt(index);
                                      await usuarioP.propiedadSelected
                                          .CargarAmountDebt(usuarioP
                                              .propiedadSelected.r_block_id);
                                      RouteTransitionDo(
                                        context: context,
                                        animationType: AnimationType.fadeIn,
                                        child: OpcionesPropiedadesPage(),
                                      );
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(7.0),
                                      child: Container(
                                        width: double.infinity,
                                        height: 150,
                                        child: Image.network(
                                          usuarioP
                                              .usuarioSelected.listPropiedades
                                              .elementAt(index)
                                              .image_building,
                                          fit: BoxFit.cover,),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0, vertical: 2.5),
                                    child: Text(
                                      usuarioP.usuarioSelected.listPropiedades
                                          .elementAt(index)
                                          .name_realestate,
                                      style: ThisColors.subtitulo(
                                          ThisColors.white,
                                          18,
                                          FontWeight.w400),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
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
