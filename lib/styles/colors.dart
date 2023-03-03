import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Map<int, Color> color = {
  50: Color.fromRGBO(250, 158, 52, .1),
  100: Color.fromRGBO(250, 158, 52, .2),
  200: Color.fromRGBO(250, 158, 52, .3),
  300: Color.fromRGBO(250, 158, 52, .4),
  400: Color.fromRGBO(250, 158, 52, .5),
  500: Color.fromRGBO(250, 158, 52, .6),
  600: Color.fromRGBO(250, 158, 52, .7),
  700: Color.fromRGBO(250, 158, 52, .8),
  800: Color.fromRGBO(250, 158, 52, .9),
  900: Color.fromRGBO(250, 158, 52, 1),
};

final primaryColor = MaterialColor(0xffFA9E34, color);

Color textColor = primaryColor;
Color lighttextColor = primaryColor;
Color listitemselectedbgcolor = Color(0xffFA9E34);

final appTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    dividerColor: Colors.transparent,
    primarySwatch: primaryColor,
    primaryColor: primaryColor,
    fontFamily: GoogleFonts.barlow().fontFamily,
    floatingActionButtonTheme:
        FloatingActionButtonThemeData(backgroundColor: primaryColor));
