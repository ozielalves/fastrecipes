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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          textTheme: GoogleFonts.montserratTextTheme(
            Theme.of(context).textTheme,
          ),
          accentColor: Colors.white,
          primaryColor: Color(0xFFDD2C00),
          primaryColorLight: Color(0xFFCCC0AE)),
      home: HomePage(),
    );
  }
}
