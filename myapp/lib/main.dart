import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:myapp/custom_animation.dart';
import 'package:myapp/elements.dart';
import 'package:myapp/error_page.dart';
import 'package:myapp/pages/notificaciones_page.dart';
import 'package:myapp/pages/hall_page.dart';
import 'package:myapp/pages/landing_page.dart';
import 'package:myapp/pages/login_page.dart';
import 'package:myapp/pages/blog_page.dart';
import 'package:myapp/pages/perfil_page.dart';
import 'package:myapp/pages/propiedades/pages/informacion_page.dart';
import 'package:myapp/pages/restaurar_contrasena_page.dart';
import 'package:myapp/providers.dart';
import 'package:myapp/share_preference/preferencias_usuario.dart';
import 'package:provider/provider.dart';

import 'pages/propiedades/opciones_propiedades.dart';
List<CameraDescription> cameras=[];
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  final prefs = new PreferenciasUsuario();
  await prefs.initPrefs();
  runApp(MyApp());
  configLoading();
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.dualRing
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = true
    ..customAnimation = CustomAnimation();
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UsuarioProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => NavBarProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => BlogProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => DeudaProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => NotificacionesProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'EDIFICIOS',
        initialRoute: 'LandingPage',
        // initialRoute: 'MenuPrincipalPage',
        builder: EasyLoading.init(),
        onGenerateRoute: (setting) {
          switch (setting.name) {
            case 'LoginPage':
              return MaterialPageRoute(builder: (_) => LoginPage());
            case 'Elements':
              return MaterialPageRoute(builder: (_) => Elements());
            case 'BlogPage':
              return MaterialPageRoute(builder: (_) => BlogPage());
            // case 'HomePage':
            //   return MaterialPageRoute(builder: (_) => HomePage());
            case 'HallPage':
              return MaterialPageRoute(builder: (_) => HallPage());
            case 'PerfilPage':
              return MaterialPageRoute(builder: (_) => PerfilPage());
            case 'NotificacionesPage':
              return MaterialPageRoute(builder: (_) => NotificacionesPage());
            case 'LandingPage':
              return MaterialPageRoute(builder: (_) => LandingPage());
            case 'RestaurarContrasenaPage':
              return MaterialPageRoute(builder: (_) => RestaurarContrasenaPage());
            case 'OpcionesPropiedadesPage':
              return MaterialPageRoute(builder: (_) => OpcionesPropiedadesPage());
            case 'InformacionPage':
              return MaterialPageRoute(builder: (_) => InformacionPage());
            // break;
            default:
              return MaterialPageRoute(builder: (_) => ErrorPage());
          }
        },
      ),
    );
  }
}
