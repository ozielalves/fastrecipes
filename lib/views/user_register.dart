import 'package:fastrecipes/core/theme/app_colors.dart';
import 'package:fastrecipes/core/theme/app_typhography.dart';
import 'package:fastrecipes/helpers/api_manager.dart';
import 'package:fastrecipes/models/recipe.dart';
import 'package:fastrecipes/models/user.dart';
import 'package:fastrecipes/views/content/content.dart';
import 'package:fastrecipes/views/content/components/action_button.dart';
import 'package:fastrecipes/views/content/components/input.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fastrecipes/providers/api_%20fastrecipe.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UserRegister extends StatefulWidget {
  @override
  _UserRegisterState createState() => _UserRegisterState();
}

class _UserRegisterState extends State<UserRegister> {
  final ApiManager apiManager = ApiManager();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _email, _password, _name, _lastname, newUserKey;

  List<Ingredient> ingredients = [];
  Recipe recipe;

  // Controllers
  TextEditingController nameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmController = TextEditingController();

  @override
  void initState() {
    super.initState();
    checkAuth(
        context: context, auth: _auth, route: Recipes(userKey: newUserKey));
    /* this._checkAuth(); */
  }

  /* void _checkAuth() async {
    _auth.authStateChanges().listen((user) {
      if (user != null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Recipes()));
      }
    });
  } */

  void _singUp() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      try {
        UserCredential user = await _auth.createUserWithEmailAndPassword(
            email: _email, password: _password);
        if (user != null) {
          _auth.currentUser.updateProfile(displayName: "$_name $_lastname");
          String userKey = await apiManager.addUser(IUser.fromJson({
            "name": _name,
            "lastame": _lastname,
            "email": _email,
            "favoriteRecipesIds": []
          }));
          setState(() {
            newUserKey = userKey;
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
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 54, bottom: 62),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 19),
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Faça parte da',
                                    style: TextStyle(
                                        fontSize: 36.0,
                                        fontWeight: FontWeight.w400,
                                        fontStyle: FontStyle.normal,
                                        color: AppColors.primaryColor)),
                                Text('família',
                                    style: TextStyle(
                                        fontSize: 36.0,
                                        fontWeight: FontWeight.w400,
                                        fontStyle: FontStyle.normal,
                                        color: AppColors.primaryColor)),
                                Text(
                                  'FastRecipe',
                                  style: AppTyphography.h1,
                                ),
                              ]),
                          SvgPicture.asset('assets/images/Chef.svg')
                        ])),
                SizedBox(
                  height: 70.0,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 19),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 19),
                        child: Row(
                          children: [
                            Input(
                              label: 'Nome',
                              controller: nameController,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Informe o nome';
                                }
                              },
                              onSaved: (input) => _name = input,
                            ),
                            SizedBox(width: 20),
                            Input(
                              label: 'Sobrenome',
                              controller: lastnameController,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Informe o sobrenome';
                                }
                              },
                              onSaved: (input) => _lastname = input,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 19),
                        child: Row(
                          children: [
                            Input(
                              label: 'E-mail',
                              controller: emailController,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Informe o seu e-mail';
                                }
                              },
                              onSaved: (input) => _email = input,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 19),
                        child: Row(
                          children: [
                            Input(
                              label: 'Senha',
                              controller: passwordController,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Informe a senha';
                                }
                                if (value.length < 6) {
                                  return 'A senha precisa ter pelo menos 6 caracteres';
                                }
                              },
                              onSaved: (input) => _password = input,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 19),
                        child: Row(
                          children: [
                            Input(
                              label: 'Confirme a senha',
                              controller: passwordConfirmController,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Informe a senha novamente';
                                }
                                if (value != passwordController.text) {
                                  return 'As senhas não coincidem';
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(19, 13, 19, 0),
                  child: ActionButton(
                      text: 'Cadastrar',
                      textColor: AppColors.textButtonColor,
                      minWidth: double.maxFinite,
                      buttonColor: Theme.of(context).primaryColor,
                      action: _singUp),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
