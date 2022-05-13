import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:myapp/Theme.dart';
import 'package:myapp/providers.dart';
import 'package:myapp/share_preference/preferencias_usuario.dart';
import 'package:myapp/widgets.dart';
import 'package:provider/provider.dart';

class PerfilPage extends StatefulWidget {
  PerfilPage({Key? key}) : super(key: key);

  @override
  State<PerfilPage> createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
    String siglasNombre='??';
  @override
  void initState() {

    try {
    var pref = PreferenciasUsuario();
    var list= pref.userName.split(' ');
    if (list.length>1) {
      siglasNombre='${list.elementAt(0).substring(0,1)}${list.elementAt(1).substring(0,1)}';
    }
    } catch (e) {
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var pref = PreferenciasUsuario();
    var usuarioP = Provider.of<UsuarioProvider>(context, listen: false);
    return SafeArea(
      top: false,
      child: Scaffold(
        // backgroundColor: ThisColors.primary,
        drawer: ArgonDrawer(),
        appBar: Navbar(
          bgColor: ThisColors.primary,
          title: "Perfil",
        ),
        bottomNavigationBar: BotomNavBarWidget(index: 2),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                      color: ThisColors.primary,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(siglasNombre, style: ThisColors.titulo(ThisColors.white, 55, FontWeight.w400),),
                    ),
                  ),
                ),
                Gap(45),
                Row(
                  children: [
                    Text(
                      'Nombre:',
                      style: ThisColors.titulo(
                          Color.fromARGB(255, 34, 20, 48), 17, FontWeight.bold),
                    ),
                    Gap(20),
                    Container(
                      // color: Colors.red,
                      width: 200,
                      child: AutoSizeText(
                        '${pref.userName}',
                        style: ThisColors.titulo(
                            Color.fromARGB(255, 137, 109, 142),
                            13,
                            FontWeight.bold),
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
                Divider(),
                Gap(15),
                Row(
                  children: [
                    Text(
                      'Correo:',
                      style: ThisColors.titulo(
                          Color.fromARGB(255, 34, 20, 48), 17, FontWeight.bold),
                    ),
                    Gap(20),
                    Container(
                      // color: Colors.red,
                      width: 200,
                      child: AutoSizeText(
                        '${pref.userEmail}',
                        style: ThisColors.titulo(
                            Color.fromARGB(255, 137, 109, 142),
                            13,
                            FontWeight.bold),
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
                Divider(),
                Gap(15),
                Row(
                  children: [
                    Text(
                      'Usuario:',
                      style: ThisColors.titulo(
                          Color.fromARGB(255, 34, 20, 48), 17, FontWeight.bold),
                    ),
                    Gap(20),
                    Container(
                      // color: Colors.red,
                      width: 200,
                      child: AutoSizeText(
                        '${pref.userId}',
                        style: ThisColors.titulo(
                            Color.fromARGB(255, 137, 109, 142),
                            13,
                            FontWeight.bold),
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
                Divider(),
                Gap(15),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
