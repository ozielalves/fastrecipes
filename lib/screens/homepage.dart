import 'package:fastrecipes/screens/recipe_register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fastrecipes/widgets/widgets.dart';
import 'package:flutter/services.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
          width: double.infinity,
          color: Color(0xFFFFF3E0),
          child: Row(
            children: [
              Container(
                height: double.maxFinite,
                width: 70.0,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 4.0,
                      spreadRadius: 0,
                    ),
                  ],
                ),
              ),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(57.0, 62.0, 33.0, 38.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                  right: 12.0,
                                ),
                                child: SvgPicture.asset(
                                  'assets/images/bowl.svg',
                                ),
                              ),
                              Text("FastRecipe",
                                  style: TextStyle(
                                      fontSize: 36.0,
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FontStyle.normal,
                                      color: Theme.of(context).primaryColor)),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 28),
                            width: 195.0,
                            child: Text(
                                "Seu novo jeito de vivenciar experiências gastronômicas",
                                style: TextStyle(
                                    fontSize: 22.0,
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.normal,
                                    color: Color(0xFF333333))),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        left: 30.0,
                      ),
                      child: SvgPicture.asset(
                        'assets/images/people_having_fun.svg',
                      ),
                    ),
                    Expanded(
                        child: Container(
                      alignment: Alignment.bottomCenter,
                      margin: EdgeInsets.fromLTRB(57.0, 0, 33.0, 62.0),
                      child: ActionButton(
                          text: 'Quero começar',
                          textColor: Colors.white,
                          buttonColor: Theme.of(context).primaryColor,
                          action: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => RecipeRegister()));
                          }),
                    ))
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
