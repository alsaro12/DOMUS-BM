import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gap/gap.dart';
import 'package:myapp/Theme.dart';
import 'package:myapp/pages/propiedades/mis_propiedades_page.dart';
import 'package:myapp/pages/restaurar_contrasena_page.dart';
import 'package:myapp/providers.dart';
import 'package:myapp/share_preference/preferencias_usuario.dart';
import 'package:myapp/widgets.dart';
import 'package:provider/provider.dart';
import 'package:myapp/share_preference/route_transition_do.dart';

import 'dart:convert' as convert;

import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  @override
  void initState() {
    emailController.text = 'cuenta_residente@domusbm.com';
    passwordController.text = 'cu3nt4resd\$test';
    super.initState();
  }

  loginFunsion() async {
      PreferenciasUsuario pref = PreferenciasUsuario();
    try {
      EasyLoading.show();
      var url = Uri.parse('https://app.domusbm.com/api/auth/login/resident');
      var response = await http.post(url, body: {
        'email': emailController.text,
        'password': passwordController.text
      });
      var responseBodyMap = response.body;
      final userMap = convert.json.decode(responseBodyMap);
      var usuarioP = Provider.of<UsuarioProvider>(context, listen: false);
      var notificacionesP = Provider.of<NotificacionesProvider>(context, listen: false);
      usuarioP.usuarioSelected.fromJson(userMap['user']);
      pref.lastLogin = DateTime.now();
      pref.access_token = userMap['access_token'];
      pref.expires_in = 10800;
      pref.userName = usuarioP.usuarioSelected.name!;
      pref.userEmail = usuarioP.usuarioSelected.email!;
      pref.userCodeUser = usuarioP.usuarioSelected.codeUser!;
      pref.userCustomerId= usuarioP.usuarioSelected.customerId!;
      pref.userId= usuarioP.usuarioSelected.id!;
      pref.residentId=usuarioP.usuarioSelected.residentId!;
      await notificacionesP.cargarNotificaciones();
      RouteTransitionDo(
        context: context,
        animationType: AnimationType.fadeIn,
        child: MisPropiedadesPage(),
      );
      EasyLoading.showSuccess('Bienvenido: \n${usuarioP.usuarioSelected.name}');
    } catch (e) {
      EasyLoading.showError('Verifique sus credenciales');
      pref.restaurarValoresPref();
    }
  }

  @override
  Widget build(BuildContext context) {
    var pref=PreferenciasUsuario();
    return Scaffold(
        backgroundColor: ThisColors.primary,
        body: Stack(
          
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              // color: Colors.red,
              child: Image.asset('assets/bgLogin.jpg',fit: BoxFit.fitWidth,),
            ),
            Container(
              width: double.infinity,
              height: double.infinity,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Gap(30),
                    FadeInDown(
                      duration: const Duration(milliseconds: 1500),
                      child: SizedBox(
                        width: 330,
                        height: 150,
                        child: Image.asset('assets/img4.png', fit: BoxFit.fitHeight,alignment: Alignment.center),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 45.0),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(pref.nombreEdificio,
                            style: TextStyle(
                                fontSize: 44,
                                color: ThisColors.primary,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 45.0, left: 25, right: 25),
                      child: Input(
                        placeholder: "Correo electrónico",
                        prefixIcon: Icon(Icons.ac_unit),
                        controller: emailController,
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 16.0, left: 25, right: 25),
                      child: Input(
                        placeholder: "Contraseña",
                        prefixIcon: Icon(Icons.lock),
                        // autofocus: false,
                        controller: passwordController,
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 34.0, right: 34.0, top: 45),
                        child: RaisedButton(
                          textColor: ArgonColors.white,
                          color: ThisColors.primary,
                          onPressed: () async {
                            await loginFunsion();
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: Padding(
                              padding: EdgeInsets.only(
                                  left: 16.0, right: 16.0, top: 12, bottom: 12),
                              child: Text("INGRESAR",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16.0))),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 34.0, right: 34.0, top: 30),
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: 16.0, right: 16.0, top: 12, bottom: 12),
                          child: GestureDetector(
                            onTap: () {
                              RouteTransitionDo(
                                  context: context, // BuildContext
                                  animationType:
                                      AnimationType.fadeIn, // Animation you want
                                  child: RestaurarContrasenaPage() // Page to go
                                  );
                            },
                            child: Text("Restaurar contraseña aqui.",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: ThisColors.primary,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          
          ],
        ));
  }
}
