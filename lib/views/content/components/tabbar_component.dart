import 'package:fastrecipes/core/theme/app_colors.dart';
import 'package:fastrecipes/core/theme/app_typhography.dart';
import 'package:fastrecipes/views/content/components/warning_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'action_button.dart';

class AppBarContent extends StatelessWidget {
  final TabController tabController;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Function(int) onTap;

  AppBarContent({Key key, @required this.tabController, @required this.onTap})
      : super(key: key);

  void _singOut() {
    _auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: (width / 2.7) - 20),
              child: TabBar(
                controller: tabController,
                onTap: onTap,
                labelStyle: AppTyphography.bodyText(context),
                labelPadding: EdgeInsets.zero,
                indicatorPadding: EdgeInsets.zero,
                overlayColor: MaterialStateProperty.all(Colors.transparent),
                labelColor: AppColors.textColor,
                unselectedLabelColor: AppColors.textFadedColor,
                indicatorColor: AppColors.primaryColor,
                indicatorWeight: 3,
                tabs: [
                  Tab(
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Recentes')),
                  ),
                  Tab(
                    child: Align(
                        alignment: Alignment.center, child: Text('Favoritas')),
                  )
                ],
              ),
            ),
          ),
          ActionButton(
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
            icon: Icons.exit_to_app,
            iconColor: AppColors.primaryColor,
            minWidth: double.minPositive,
            buttonColor: Colors.transparent,
            borderRadius: 50,
            outlined: true,
            padding: EdgeInsets.all(0),
          ),
        ],
      ),
    );
  }
}
