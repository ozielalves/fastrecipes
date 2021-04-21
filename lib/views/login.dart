import 'package:fastrecipes/core/theme/app_colors.dart';
import 'package:fastrecipes/core/theme/app_typhography.dart';
import 'package:fastrecipes/helpers/api_manager.dart';
import 'package:fastrecipes/providers/api_%20fastrecipe.dart';
import 'package:fastrecipes/providers/google_sign_in.dart';
import 'package:fastrecipes/views/content/content.dart';
import 'package:fastrecipes/views/user_register.dart';
import 'package:fastrecipes/views/content/components/action_button.dart';
import 'package:fastrecipes/views/content/components/input.dart';
import 'package:fastrecipes/views/content/components/logo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  ApiManager apiManager = ApiManager();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _email, _password, userKey;

  /* void _checkAuth() async {
    _auth.authStateChanges().listen((user) {
      if (user != null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Recipes()));
      }
    });
  } */

  void _login() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      try {
        UserCredential user = await _auth.signInWithEmailAndPassword(
            email: _email, password: _password);

        if (user != null) {
          String userKeyByEmail = await apiManager.getUserKeyByEmail(_email);
          setState(() async {
            userKey = userKeyByEmail;
          });
        }
      } on FirebaseAuthException catch (e) {
        showError(context: context, errorMessage: e.message);
      }
    }
  }

  /* void _showError(String errorMessage) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: AppColors.errorColor,
      behavior: SnackBarBehavior.floating,
      content: Text(errorMessage,
          style: TextStyle(color: AppColors.textButtonColor)),
      action: SnackBarAction(
        label: 'Limpar',
        textColor: AppColors.textButtonColor,
        onPressed: () {},
      ),
    ));
  } */

  @override
  void initState() {
    super.initState();
    checkAuth(
        context: context,
        auth: _auth,
        route: Recipes(
          userKey: userKey,
        ));
    /* this._checkAuth(); */
  }

  // Controllers
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double cWidth = MediaQuery.of(context).size.width;
    final double cHeight = MediaQuery.of(context).size.height;
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      /* extendBodyBehindAppBar: true, */
      body: Container(
          width: double.maxFinite,
          color: AppColors.backgroundColor,
          child: Stack(
            children: [
              SvgPicture.asset(
                'assets/images/LoginBackground.svg',
                fit: BoxFit.cover,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: SingleChildScrollView(
                  child: Container(
                    height: cHeight * 0.80,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black45,
                            offset: const Offset(
                              0.0,
                              0.0,
                            ),
                            blurRadius: 6.0,
                            spreadRadius: 1.0,
                          ),
                        ]),
                    padding: EdgeInsets.fromLTRB(19, 65, 19, 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        buildLogo(),
                        Container(
                          margin: EdgeInsets.only(top: 50),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Input(
                                        label: 'E-mail',
                                        controller: emailController,
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'Informe o e-mail';
                                          }
                                        },
                                        onSaved: (input) => _email = input),
                                  ],
                                ),
                                SizedBox(
                                  height: 19,
                                ),
                                Row(
                                  children: [
                                    Input(
                                      label: 'Senha',
                                      controller: passwordController,
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Informe a senha';
                                        }
                                        return null;
                                      },
                                      onSaved: (input) => _password = input,
                                    ),
                                  ],
                                ),
                                /* Expanded(
                                            child:  */
                                Container(
                                  margin: EdgeInsets.only(top: 30),
                                  alignment: Alignment.center,
                                  child: Column(
                                    children: [
                                      ActionButton(
                                          text: 'Entrar',
                                          textColor: AppColors.textButtonColor,
                                          buttonColor:
                                              Theme.of(context).primaryColor,
                                          minWidth: double.maxFinite,
                                          action: _login),
                                      SizedBox(
                                        height: 19,
                                      ),
                                      ActionButton(
                                          text: 'Entrar com o Google',
                                          svgIcon: SvgPicture.asset(
                                              'assets/images/GoogleLogo.svg'),
                                          textColor: AppColors.primaryColor,
                                          buttonColor: AppColors.primaryColor,
                                          outlined: true,
                                          minWidth: double.maxFinite,
                                          action: () {
                                            final provider = Provider.of<
                                                    GoogleSignInProvider>(
                                                context,
                                                listen: false);
                                            provider.login();
                                          }),
                                      SizedBox(
                                        height: 30,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          RichText(
                                              text: TextSpan(
                                            text: 'Ainda não possuo uma conta',
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            UserRegister()));
                                              },
                                            style: TextStyle(
                                              color: AppColors.primaryColor,
                                              fontSize: 16,
                                              decoration:
                                                  TextDecoration.underline,
                                            ),
                                          )),
                                        ],
                                      )
                                    ],
                                  ),
                                ) /* ) */
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
