import 'package:fastrecipes/core/theme/app_colors.dart';
import 'package:fastrecipes/views/content/login.dart';
import 'package:fastrecipes/views/content/splash_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fastrecipes/providers/google_sign_in.dart';
import 'package:fastrecipes/views/content/content.dart';
import 'package:provider/provider.dart';

class AuthPageProvider extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        extendBodyBehindAppBar: true,
        body: ChangeNotifierProvider(
          create: (context) => GoogleSignInProvider(),
          child: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              final provider = Provider.of<GoogleSignInProvider>(context);
              if (provider.isSigningIn) {
                return SplashPage(); /* buildLoading(); */
              } else if (snapshot.hasData) {
                return Recipes();
              } else {
                return LoginPage();
              }
            },
          ),
        ),
      );

  Widget buildLoading() => Stack(
        fit: StackFit.expand,
        children: [
          Center(
              child: CircularProgressIndicator(
            backgroundColor: AppColors.primaryColor,
          )),
        ],
      );
}
