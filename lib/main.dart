import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fastrecipes/screens/homepage.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /* SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.black38, // navigation bar color
      statusBarColor: Colors.transparent  // status bar color
    )); */
    TextTheme textTheme = Theme.of(context).textTheme;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          /* textTheme: GoogleFonts.montserratTextTheme(
                Theme.of(context).textTheme,
              ), */
          accentColor: Colors.white,
          primaryColor: Color(0xFFDD2C00),
          primaryColorLight: Color(0xFFCCC0AE),
          textTheme: GoogleFonts.montserratTextTheme(
              textTheme) /* .copyWith(
              headline1: GoogleFonts.montserrat(textStyle: textTheme.headline1),
              headline2: GoogleFonts.montserrat(textStyle: textTheme.headline2),
              headline3: GoogleFonts.montserrat(textStyle: textTheme.headline3),
              headline4: GoogleFonts.montserrat(textStyle: textTheme.headline4),
              headline5: GoogleFonts.montserrat(textStyle: textTheme.headline5),
              bodyText1:
                  GoogleFonts.montserrat(textStyle: textTheme.bodyText1)) */
          ),
      home: HomePage(),
    );
  }
}
