import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:what_todo/widgets/widgets.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  /* DatabaseHelper _dbHelper = DatabaseHelper();
  Modal modal = new Modal(); */

  /* Task _lastRemovedTask;
  List<Todo> _lastRemovedTaskTodos; */

  /* void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => modal.mainBottomSheet(context));
  } */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: /* SafeArea(
        child: */
          Container(
        width: double.infinity,
        color: Color(0xFFFFF3E0),
        child: Stack(
          children: [
            Container(
              height: double.maxFinite,
              width: 140.0,
              color: Theme.of(context).primaryColorLight,
            ),
            Row(
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
                  margin: EdgeInsets.only(
                    top: 270.0,
                  ),
                  child: Image(
                    image: AssetImage(
                      'assets/images/rice.png',
                    ),
                  ),
                ),
              ],
            ),
            Container(
                padding: EdgeInsets.only(
                  left: 169.0,
                  top: 63.0,
                ),
                child: Column(
                  children: [
                    Text("FastRecipe",
                        style: TextStyle(
                            fontSize: 36.0,
                            fontWeight: FontWeight.w600,
                            fontStyle: FontStyle.normal)),
                    Container(
                      margin: EdgeInsets.only(top: 28),
                      width: 195.0,
                      child: Text(
                          "Seu novo jeito de vivenciar experiências gastronômicas",
                          style: TextStyle(
                              fontSize: 22.0,
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal)),
                    ),
                    Expanded(
                        child: Container(
                      alignment: Alignment.bottomCenter,
                      margin: EdgeInsets.only(bottom: 18.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RawMaterialButton(
                            onPressed: () {},
                            elevation: 2.0,
                            fillColor: Theme.of(context).primaryColor,
                            child: Icon(
                              Icons.add,
                              size: 35.0,
                              color: Colors.white,
                            ),
                            padding: EdgeInsets.all(15.0),
                            shape: CircleBorder(),
                          ),
                          RawMaterialButton(
                            onPressed: () {},
                            elevation: 2.0,
                            fillColor: Theme.of(context).primaryColor,
                            child: Icon(
                              Icons.list,
                              size: 35.0,
                              color: Colors.white,
                            ),
                            padding: EdgeInsets.all(15.0),
                            shape: CircleBorder(),
                          ),
                        ],
                      ),
                    ))
                  ],
                )),
          ],
        ),
      ),
      /* ), */
    );
  }
}
