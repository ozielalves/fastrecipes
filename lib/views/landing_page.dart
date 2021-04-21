import 'package:fastrecipes/core/theme/app_colors.dart';
import 'package:fastrecipes/core/theme/app_typhography.dart';
import 'package:fastrecipes/views/content/components/action_button.dart';
import 'package:fastrecipes/views/content/components/logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart';

import 'auth_page_provider.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      body: Container(
        width: double.infinity,
        color: AppColors.secondaryColor,
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(46.0, 62.0, 33.0, 72.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildLogo(),
                    Container(
                      margin: EdgeInsets.only(top: 28, left: 46),
                      width: 195.0,
                      child: Text(
                          "Seu novo jeito de vivenciar experiências gastronômicas",
                          style: AppTyphography.h3),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  left: 25.0,
                ),
                child: SvgPicture.asset(
                  'assets/images/people_having_fun.svg',
                ),
              ),
              Expanded(
                  child: Container(
                alignment: Alignment.bottomCenter,
                margin: EdgeInsets.fromLTRB(80, 0, 80, 62.0),
                child: ActionButton(
                    text: 'Quero começar',
                    textColor: AppColors.textButtonColor,
                    buttonColor: Theme.of(context).primaryColor,
                    minWidth: double.maxFinite,
                    action: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => AuthPageProvider()));
                    }),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
