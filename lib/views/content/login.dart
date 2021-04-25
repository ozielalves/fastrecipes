import 'package:fastrecipes/core/theme/app_colors.dart';
import 'package:fastrecipes/helpers/helpers.dart';
import 'package:fastrecipes/providers/api_%20fastrecipe.dart';
import 'package:fastrecipes/providers/google_sign_in.dart';
import 'package:fastrecipes/views/content/content.dart';
import 'package:fastrecipes/views/content/user_register.dart';
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

  String _email, _password;

  Future<void> _login() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      try {
        await _auth.signInWithEmailAndPassword(
            email: _email, password: _password);
      } on FirebaseAuthException catch (e) {
        showError(context: context, errorMessage: e.message);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    checkAuth(context: context, auth: _auth, route: Recipes());
  }

  // Controllers
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
        child: Container(
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
                      height: height * 0.80,
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
                        mainAxisAlignment: MainAxisAlignment.start,
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
                                          type: TextInputType.emailAddress,
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
                                        type: TextInputType.visiblePassword,
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'Informe a senha';
                                          }
                                          if (value.length < 6) {
                                            return 'A senha informada não é válida';
                                          }
                                          return null;
                                        },
                                        onSaved: (input) => _password = input,
                                      ),
                                    ],
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 30),
                                    alignment: Alignment.center,
                                    child: Column(
                                      children: [
                                        ActionButton(
                                            text: 'Entrar',
                                            textColor: AppColors.white,
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
                                              text:
                                                  'Ainda não possuo uma conta',
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
                                              ),
                                            )),
                                          ],
                                        )
                                      ],
                                    ),
                                  )
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
      ),
    );
  }
}
