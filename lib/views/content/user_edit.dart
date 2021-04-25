import 'package:fastrecipes/core/theme/app_colors.dart';
import 'package:fastrecipes/models/user.dart';
import 'package:fastrecipes/views/content/components/action_button.dart';
import 'package:fastrecipes/views/content/components/input.dart';
import 'package:fastrecipes/views/content/components/page_header.dart';
import 'package:fastrecipes/views/content/components/warning_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fastrecipes/providers/api_%20fastrecipe.dart';
import 'package:flutter/services.dart';

class UserEdition extends StatefulWidget {
  final IUser userLoggedIn;
  final Function updateUser;

  const UserEdition({Key key, @required this.userLoggedIn, this.updateUser})
      : super(key: key);

  @override
  _UserEditionState createState() => _UserEditionState();
}

class _UserEditionState extends State<UserEdition> {
  final ApiManager apiManager = ApiManager();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  IUser currentUser;

  String _name, _lastname;

  // Controllers
  TextEditingController nameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    currentUser = widget.userLoggedIn;
    nameController.text = widget.userLoggedIn.name;
    lastnameController.text = widget.userLoggedIn.lastname;
  }

  bool _isChanged() {
    return nameController.text != currentUser.name ||
        lastnameController.text != currentUser.lastname;
  }

  Future<void> _updateUser() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      try {
        await apiManager.updateUser(
            userKey: currentUser.key,
            changes: {"name": _name, "lastname": _lastname});
        _auth.currentUser.updateProfile(displayName: "$_name $_lastname");
        await widget.updateUser();
        // SNACKBAR
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          margin: EdgeInsets.fromLTRB(10.0, 0, 10.0, 77.0),
          backgroundColor: AppColors.successColor,
          behavior: SnackBarBehavior.floating,
          content: Text('Usuário alterado com sucesso',
              style: TextStyle(color: AppColors.white)),
          action: SnackBarAction(
            label: 'Limpar',
            textColor: AppColors.white,
            onPressed: () {},
          ),
        ));

        return Navigator.of(context).pop();
      } catch (Exception) {
        print(Exception);
        print("Não foi possível editar o Usuário");
      }
    } else {
      // SNACKBAR
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        margin: EdgeInsets.fromLTRB(10.0, 0, 10.0, 77.0),
        backgroundColor: AppColors.errorColor,
        behavior: SnackBarBehavior.floating,
        content: Text('Existem campos não preenchidos ou inválidos',
            style: TextStyle(color: AppColors.white)),
        action: SnackBarAction(
          label: 'Limpar',
          textColor: AppColors.white,
          onPressed: () {},
        ),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
        child: Form(
          key: _formKey,
          child: Container(
            margin: EdgeInsets.only(top: 30, bottom: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 19),
                    child: PageHeader(
                      onGoBack: () {
                        if (_isChanged()) {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return WarningDialog(
                                  title:
                                      "Abandonar a edição dos dados pessoais?",
                                  content:
                                      "Os dados alterados serão descartados",
                                  primaryButtonText: "Confirmar",
                                  primaryButtonAction: () {
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                  },
                                  secondaryButtonText: "Cancelar",
                                  secondaryButtonAction: () {
                                    Navigator.pop(context);
                                  },
                                );
                              });
                        } else {
                          Navigator.pop(context);
                        }
                      },
                      title: 'Editar informações',
                    )),
                SizedBox(
                  height: 24.0,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 19),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 20),
                        child: Row(
                          children: [
                            Input(
                              label: 'Nome',
                              controller: nameController,
                              type: TextInputType.text,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Informe o nome';
                                }
                                return null;
                              },
                              onSaved: (input) => _name = input,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 20),
                        child: Row(
                          children: [
                            Input(
                              label: 'Sobrenome',
                              controller: lastnameController,
                              type: TextInputType.text,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Informe o sobrenome';
                                }
                                return null;
                              },
                              onSaved: (input) => _lastname = input,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Container(
                    margin: EdgeInsets.fromLTRB(19, 13, 19, 0),
                    child: ActionButton(
                      text: 'Alterar',
                      textColor: AppColors.white,
                      minWidth: double.maxFinite,
                      buttonColor: AppColors.primaryColor,
                      action: _updateUser,
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
