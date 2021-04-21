import 'package:fastrecipes/views/landing_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          accentColor: Colors.white,
          primaryColor: Color(0xFFDD2C00),
          primaryColorLight: Color(0xFFCCC0AE),
          fontFamily: 'Montserrat',
          textTheme: GoogleFonts.montserratTextTheme(textTheme)),
      home: LandingPage(),
    );
  }
}
