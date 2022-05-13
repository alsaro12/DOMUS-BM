import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:myapp/Theme.dart';
import 'package:myapp/providers.dart';
import 'package:myapp/widgets.dart';
import 'package:provider/provider.dart';

class NotificacionesPage extends StatefulWidget {
  NotificacionesPage({Key? key}) : super(key: key);

  @override
  State<NotificacionesPage> createState() => _NotificacionesPageState();
}

class _NotificacionesPageState extends State<NotificacionesPage> {
  @override
  Widget build(BuildContext context) {
    var notificacionesP =
        Provider.of<NotificacionesProvider>(context, listen: false);
    return SafeArea(
      top: false,
      child: Scaffold(
        drawer: ArgonDrawer(),
        appBar: Navbar(
          title: "Notificaciones",
          backButton: true,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Expanded(
                  child: FutureBuilder(
                    future: notificacionesP.cargarNotificaciones(),
                    builder: (BuildContext context,
                        AsyncSnapshot<dynamic> snapshot) {
                    if(snapshot.hasData){
                        return ListView.builder(
                        itemCount: notificacionesP.listNotificaciones.length,
                        itemBuilder: (BuildContext context, int index) {
                          Notificaciones notificacion = Notificaciones();
                          notificacion = notificacionesP.listNotificaciones
                              .elementAt(index);
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2),
                            child: GestureDetector(
                              onTap: () async {
                                await notificacion.marcaLeida();
                                await showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return SimpleDialog(
                                      children: [
                                        Container(
                                          width: 250,
                                          // height: 300,
                                          decoration: ThisColors.boxDecoration(
                                              15, Colors.white),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  notificacion.title!,
                                                  style: ThisColors.titulo(
                                                      Color.fromARGB(
                                                          255, 30, 30, 30),
                                                      15,
                                                      FontWeight.w600),
                                                ),
                                                Gap(5),
                                                Text(
                                                  notificacion.date_created!,
                                                  style: ThisColors.subtitulo(
                                                      Color.fromARGB(
                                                          255, 30, 30, 30),
                                                      13,
                                                      FontWeight.w400),
                                                ),
                                                Gap(5),
                                                Text(
                                                  notificacion.body!,
                                                  style: ThisColors.descripcion(
                                                      Color.fromARGB(
                                                          255, 30, 30, 30),
                                                      13,
                                                      FontWeight.w400),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    );
                                  },
                                );
                                await notificacionesP.cargarNotificaciones();
                                setState(() {});
                              },
                              child: Container(
                                height: 90,
                                decoration: ThisColors.boxDecoration(
                                    15,
                                    (int.parse(notificacion.condition!)==0)
                                        ? Color.fromARGB(255, 138, 141, 239)
                                        : Color.fromARGB(255, 220, 220, 220)
                                            .withOpacity(0.7)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        notificacion.title!,
                                        style: ThisColors.titulo(
                                            Color.fromARGB(255, 30, 30, 30),
                                            15,
                                            FontWeight.w600),
                                      ),
                                      Gap(2),
                                      Text(
                                        notificacion.date_created!,
                                        style: ThisColors.subtitulo(
                                            (int.parse(notificacion.condition!)==0)
                                        ? Color.fromARGB(255, 220, 220, 220)
                                        : Color.fromARGB(255, 55, 55, 55),
                                            12,
                                            FontWeight.w400),
                                      ),
                                      Gap(2),
                                      RichText(
                                        text: TextSpan(
                                            text: (notificacion.body!.length <
                                                    100)
                                                ? notificacion.body!
                                                : '${notificacion.body!.substring(0, 90)}',
                                                style: TextStyle(
                                                  color: (int.parse(notificacion
                                                                .condition!) ==
                                                            0)
                                                        ? Color.fromARGB(
                                                            255, 220, 220, 220)
                                                        : Color.fromARGB(
                                                            255, 55, 55, 55),
                                                  fontSize: 12,
                                                ),
                                            children: [
                                              TextSpan(
                                                text: ' ver mas...',
                                                style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 68, 0, 131),
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ]),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    
                    }else{
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
      ),
    );
  }
}
