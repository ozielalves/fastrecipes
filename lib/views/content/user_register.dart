import 'package:fastrecipes/core/theme/app_colors.dart';
import 'package:fastrecipes/core/theme/app_typhography.dart';
import 'package:fastrecipes/helpers/helpers.dart';
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

  // FocusNode
  FocusNode emailFocusNode = FocusNode();

  @override
  void initState() {
    checkAuth(context: context, auth: _auth, route: Recipes());
    super.initState();
  }

  void _singUp() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      try {
        bool userExists = await apiManager.getUserByEmail(_email) != null;
        if (!userExists) {
          UserCredential user = await _auth.createUserWithEmailAndPassword(
              email: _email, password: _password);
          if (user != null) {
            _auth.currentUser.updateProfile(displayName: "$_name $_lastname");
            String userKey = await apiManager.addUser(IUser.fromJson({
              "name": _name,
              "lastame": _lastname,
              "email": _email,
              "favoriteRecipesKeys": [""]
            }));
            setState(() {
              newUserKey = userKey;
            });
            _showSnackBar(
                message: "Cadastro realizado com sucesso",
                color: AppColors.successColor);
          }
        } else {
          _showSnackBar(
              message: "O e-mail informado já está sendo usado por outra conta",
              color: AppColors.errorColor);
          emailController.clear();
          emailFocusNode.requestFocus();
        }
      } on FirebaseAuthException catch (e) {
        showError(context: context, errorMessage: e.message);
      }
    }
  }

  _showSnackBar({String message, Color color}) =>
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        margin: EdgeInsets.fromLTRB(10.0, 0, 10.0, 77.0),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        content: Text(message, style: TextStyle(color: AppColors.white)),
        action: SnackBarAction(
          label: 'Limpar',
          textColor: AppColors.white,
          onPressed: () {},
        ),
      ));

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
        child: SingleChildScrollView(
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
                                type: TextInputType.name,
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
                                type: TextInputType.name,
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
                                focusNode: emailFocusNode,
                                controller: emailController,
                                type: TextInputType.emailAddress,
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
                                type: TextInputType.visiblePassword,
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
                                type: TextInputType.visiblePassword,
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
                        textColor: AppColors.white,
                        minWidth: double.maxFinite,
                        buttonColor: Theme.of(context).primaryColor,
                        action: _singUp),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
