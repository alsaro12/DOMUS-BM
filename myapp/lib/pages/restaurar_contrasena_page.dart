import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:myapp/Theme.dart';
import 'package:myapp/pages/login_page.dart';
import 'package:myapp/share_preference/route_transition_do.dart';
import 'dart:convert' as convert;

import 'package:http/http.dart' as http;
import 'package:myapp/widgets.dart';

class RestaurarContrasenaPage extends StatefulWidget {
  RestaurarContrasenaPage({Key? key}) : super(key: key);

  @override
  State<RestaurarContrasenaPage> createState() =>
      _RestaurarContrasenaPageState();
}

class _RestaurarContrasenaPageState extends State<RestaurarContrasenaPage> {
  TextEditingController emailController = TextEditingController();
  @override
  void initState() {
    emailController.text = 'cuenta_residente@domusbm.com';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Navbar(
          title: 'Recuperar contraseña',
          bgColor: ThisColors.primary,
          backButton: true,
          rightOptions: false,
        ),
        backgroundColor: ThisColors.primary,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FadeInDown(
                  duration: const Duration(milliseconds: 1500),
                  child: SizedBox(
                    width: 230,
                    height: 220,
                    child: Image.asset('assets/image5.png'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 45.0),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 32),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Recuperar contraseña",
                          style: TextStyle(
                              color: ArgonColors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 16)),
                    ),
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
                SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 34.0, right: 34.0, top: 45),
                    child: RaisedButton(
                      textColor: ArgonColors.white,
                      color: ThisColors.secondary,
                      onPressed: () async {
                        try {
                          EasyLoading.show();
                          var url = Uri.parse(
                              'https://app.domusbm.com/api/auth/password_email/resident/api');
                          var response = await http
                              .post(url, body: {'email': emailController.text});
                          var responseBodyMap = response.body;
                          final userMap = convert.json.decode(responseBodyMap);
                          RouteTransitionDo(
                            context: context,
                            animationType: AnimationType.fadeIn,
                            child: LoginPage(),
                          );
                          EasyLoading.showSuccess(
                              'Revisa tu bandeja de entrada');
                        } catch (e) {
                          EasyLoading.showError('Email Invalido');

                          RouteTransitionDo(
                              context: context,
                              animationType:
                                  AnimationType.fadeIn,
                              child: LoginPage()
                              );
                        }
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Padding(
                          padding: EdgeInsets.only(
                              left: 16.0, right: 16.0, top: 12, bottom: 12),
                          child: Text("ENVIAR",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16.0))),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
