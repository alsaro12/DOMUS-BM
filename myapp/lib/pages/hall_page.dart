import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:myapp/Theme.dart';
import 'package:myapp/pages/login_page.dart';
import 'package:myapp/pages/propiedades/mis_propiedades_page.dart';
import 'package:myapp/providers.dart';
import 'package:myapp/share_preference/preferencias_usuario.dart';
import 'package:myapp/share_preference/route_transition_do.dart';
import 'package:provider/provider.dart';

class HallPage extends StatefulWidget {
  HallPage({Key? key}) : super(key: key);

  @override
  State<HallPage> createState() => _HallPageState();
}

class _HallPageState extends State<HallPage> {
  botonIniciar() async {
    PreferenciasUsuario pref = PreferenciasUsuario();
    if ((DateTime.now().millisecond - pref.lastLogin.millisecond) >
        pref.expires_in * 1000) {
      pref.restaurarValoresPref();
      RouteTransitionDo(
        context: context,
        animationType: AnimationType.fadeIn,
        child: LoginPage(),
      );
    } else {
      var notificacionesP =
          Provider.of<NotificacionesProvider>(context, listen: false);
      await notificacionesP.cargarNotificaciones();
      await RouteTransitionDo(
        context: context,
        animationType: AnimationType.fadeIn,
        child: MisPropiedadesPage(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var pref = PreferenciasUsuario();
    return Scaffold(
      backgroundColor: ThisColors.primary,
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            child: Image.asset('assets/hallPageBG.jpg', fit: BoxFit.cover),
          ),
          Column(
            children: [
              Gap(40),
              Container(
                height: 160,
                width: 160,
                decoration: ThisColors.boxDecoration(
                    15, Colors.white.withOpacity(0.7)),
                child: Image.asset('assets/img3.png', fit: BoxFit.cover),
              ),
              SizedBox(
                width: 265,
                height: 80,
                child: Center(
                  child: Text(
                    pref.nombreEdificio,
                    style: ThisColors.titulo(
                        ThisColors.primary, 34, FontWeight.w800),
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Gap(70),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 60.0),
                      child: Container(
                        child: Text(
                          'Ponte cómodo y accede a toda la información que necesitas de tus propiedades, en un solo sitio. \n\n LA ADMINISTRACIÓN.',
                          textAlign: TextAlign.left,
                          style: ThisColors.subtitulo(
                              Colors.white, 17, FontWeight.w300),
                        ),
                      ),
                    ),
                    // Gap(60),
                    Expanded(
                      child: Container(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 130.0),
                      child: Theme(
                        data: ThemeData(
                          splashColor: Colors.red,
                          highlightColor: Colors.black.withOpacity(.5),
                        ),
                        child: GestureDetector(
                          onTap: () {
                            botonIniciar();
                          },
                          child: Container(
                            width: 180,
                            height: 50,
                            decoration: ThisColors.boxDecoration(
                                15, Colors.white.withOpacity(0.7)),
                            child: Center(
                              child: Text(
                                'Iniciar',
                                style: ThisColors.subtitulo(
                                    ThisColors.primary,
                                    17,
                                    FontWeight.w600),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
