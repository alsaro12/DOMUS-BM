import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:myapp/Theme.dart';
import 'package:myapp/pages/hall_page.dart';
import 'package:myapp/share_preference/preferencias_usuario.dart';
import 'package:myapp/share_preference/route_transition_do.dart';

class LandingPage extends StatefulWidget {
  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  void initState() {
    iniciarFuncion();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    PreferenciasUsuario pref = PreferenciasUsuario();
    return Scaffold(
        backgroundColor: ThisColors.primary,
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: double.infinity,
                child: Image.asset('assets/hallPageBG.jpg', fit: BoxFit.cover),
              ),
              Container(
                width: double.infinity,
                height: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    FadeInDown(
                      duration: const Duration(milliseconds: 1500),
                      child: Container(
                        height: 160,
                        width: 160,
                        decoration: ThisColors.boxDecoration(
                            15, Colors.white.withOpacity(0.7)),
                        child:
                            Image.asset('assets/img3.png', fit: BoxFit.cover),
                      ),
                    ),
                    FadeInLeft(
                      duration: const Duration(milliseconds: 1500),
                      child: Container(
                        // color: Colors.red,
                        width: 265,
                        height: 80,
                        child: Center(
                          child: Text(
                            pref.nombreEdificio,
                            style: ThisColors.titulo(
                                ThisColors.primary, 34, FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  void iniciarFuncion() async {
    DateTime now = DateTime.now();
    if (now.year == 2022 && now.month == 5 && now.day < 29) {
      await Future.delayed(const Duration(milliseconds: 2500));
      RouteTransitionDo(
        context: context,
        animationType: AnimationType.fadeIn,
        child: HallPage(),
      );
    }
  }
}
