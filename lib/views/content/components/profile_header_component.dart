import 'package:fastrecipes/core/theme/app_colors.dart';
import 'package:fastrecipes/core/theme/app_typhography.dart';
import 'package:fastrecipes/views/content/components/warning_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'action_button.dart';

class ProfileHeaderComponent extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Function goBack;

  ProfileHeaderComponent({Key key, this.goBack}) : super(key: key);

  void _singOut() {
    _auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          goBack != null
              ? ActionButton(
                  action: goBack,
                  icon: Icon(
                    Icons.arrow_back,
                    size: 30,
                    color: AppColors.primaryColor,
                  ),
                  iconColor: AppColors.primaryColor,
                  minWidth: double.minPositive,
                  buttonColor: Colors.transparent,
                  borderRadius: 50,
                  outlined: true,
                  padding: EdgeInsets.all(0),
                )
              : Spacer(
                  flex: 2,
                ),
          Text("Meus dados", style: AppTyphography.bodyText1SemiBold(context)),
          Spacer(),
          goBack == null
              ? ActionButton(
                  action: () => showDialog(
                      context: context,
                      builder: (context) {
                        return WarningDialog(
                          title: "Tem certeza que deseja sair?",
                          content:
                              "Você não poderá mais ficar por dentro das melhoroes receitas caseiras.",
                          primaryButtonText: "Sair",
                          primaryButtonAction: () {
                            _singOut();
                          },
                          secondaryButtonText: "Cancelar",
                          secondaryButtonAction: () {
                            Navigator.pop(context);
                          },
                        );
                      }),
                  icon: Icon(
                    Icons.exit_to_app,
                    size: 30,
                    color: AppColors.primaryColor,
                  ),
                  iconColor: AppColors.primaryColor,
                  minWidth: double.minPositive,
                  buttonColor: Colors.transparent,
                  borderRadius: 50,
                  outlined: true,
                  padding: EdgeInsets.all(0),
                )
              : Spacer(
                  flex: 2,
                ),
        ],
      ),
    );
  }
}
