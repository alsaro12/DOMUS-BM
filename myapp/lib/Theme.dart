import 'dart:ui' show Color;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ArgonColors {
  static const Color black = Color(0xFF000000);

  static const Color white = Color(0xFFFFFFFF);

  static const Color initial = Color.fromRGBO(23, 43, 77, 1.0);

  static const Color primary = Color.fromRGBO(94, 114, 228, 1.0);

  static const Color secondary = Color.fromRGBO(247, 250, 252, 1.0);

  static const Color label = Color.fromRGBO(254, 36, 114, 1.0);

  static const Color info = Color.fromRGBO(17, 205, 239, 1.0);

  static const Color error = Color.fromRGBO(245, 54, 92, 1.0);

  static const Color success = Color.fromRGBO(45, 206, 137, 1.0);

  static const Color warning = Color.fromRGBO(251, 99, 64, 1.0);

  static const Color header = Color.fromRGBO(82, 95, 127, 1.0);

  static const Color bgColorScreen = Color.fromRGBO(248, 249, 254, 1.0);

  static const Color border = Color.fromRGBO(202, 209, 215, 1.0);

  static const Color inputSuccess = Color.fromRGBO(123, 222, 177, 1.0);

  static const Color inputError = Color.fromRGBO(252, 179, 164, 1.0);

  static const Color muted = Color.fromRGBO(136, 152, 170, 1.0);

  static const Color text = Color.fromRGBO(50, 50, 93, 1.0);
}


class ThisColors {
  static const Color turquesa = Color(0xFF00C4D6);
  static const Color black = Color(0xFF000000);

  static const Color white = Color(0xFFFFFFFF);

  static const Color plomo = Color(0xff717174);

  static const Color defaultColor = Color.fromRGBO(136, 136, 136, 1.0);

  static const Color primary = Color.fromRGBO(78, 53, 118, 1.0);

  // static const Color secondary = Color.fromARGB(255, 199, 137, 23);
  static const Color secondary = Color.fromRGBO(29, 145, 210, 1.0);

  static const Color label = Color.fromRGBO(254, 36, 114, 1.0);

  static const Color neutral = Color.fromRGBO(255, 255, 255, 0.2);

  static const Color tabs = Color.fromRGBO(222, 222, 222, 0.3);

  static const Color info = Color.fromRGBO(44, 168, 255, 1.0);

  static const Color error = Color.fromRGBO(255, 54, 54, 1.0);

  static const Color success = Color.fromRGBO(24, 206, 15, 1.0);

  static const Color warning = Color.fromRGBO(255, 178, 54, 1.0);

  static const Color text = Color.fromRGBO(44, 44, 44, 1.0);

  static const Color bgColorScreen = Color.fromRGBO(255, 255, 255, 1.0);

  static const Color border = Color.fromRGBO(231, 231, 231, 1.0);

  static const Color inputSuccess = Color.fromRGBO(27, 230, 17, 1.0);

  static const Color input = Color.fromRGBO(220, 220, 220, 1.0);

  static const Color inputError = Color.fromRGBO(255, 54, 54, 1.0);

  static const Color muted = Color.fromRGBO(136, 152, 170, 1.0);

  // static const Color text = Color.fromRGBO(50, 50, 93, 1.0);

  static const Color time = Color.fromRGBO(154, 154, 154, 1.0);

  static const Color priceColor = Color.fromRGBO(234, 213, 251, 1.0);

  static const Color active = Color.fromRGBO(249, 99, 50, 1.0);

  static const Color buttonColor = Color.fromRGBO(156, 38, 176, 1.0);

  static const Color placeholder = Color.fromRGBO(159, 165, 170, 1.0);

  static const Color switchON = Color.fromRGBO(249, 99, 50, 1.0);

  static const Color switchOFF = Color.fromRGBO(137, 137, 137, 1.0);

  static const Color gradientStart = Color.fromRGBO(107, 36, 170, 1.0);

  static const Color gradientEnd = Color.fromRGBO(172, 38, 136, 1.0);

  static const Color socialFacebook = Color.fromRGBO(59, 89, 152, 1.0);

  static const Color socialTwitter = Color.fromRGBO(91, 192, 222, 1.0);

  static const Color socialDribbble = Color.fromRGBO(234, 76, 137, 1.0);

  static TextStyle titulo(
    Color color,
    double size,
    FontWeight fontWeight,
  ) {
    return GoogleFonts.roboto(
      fontSize: size,
      color: color,
      fontWeight: fontWeight,
    );
  }
  static TextStyle descripcion(
    Color color,
    double size,
    FontWeight fontWeight,
  ) {
    return GoogleFonts.padauk(
      fontSize: size,
      color: color,
      fontWeight: fontWeight,
    );
  }
  static TextStyle subtitulo(
    Color color,
    double size,
    FontWeight fontWeight,
  ) {
    return GoogleFonts.poppins(
      fontSize: size,
      color: color,
      fontWeight: fontWeight,
    );
  }

  static BoxDecoration boxDecoration(double radius, Color color) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(radius),
      color: color,
    );
  }
}
List lisMesesAbreviacion=[
'',
'ENE',
'FEB',
'MAR',
'ABR',
'MAY',
'JUN',
'JUL',
'AGO',
'SET',
'OCT',
'NOV',
'DIC',
];
