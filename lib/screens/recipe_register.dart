import 'package:fastrecipes/models/recipe.dart';
import 'package:flutter/material.dart';
import 'package:fastrecipes/widgets/widgets.dart';

class RecipeRegister extends StatefulWidget {
  @override
  _RecipeRegisterState createState() => _RecipeRegisterState();
}

class _RecipeRegisterState extends State<RecipeRegister> {
  List<Igredient> igredients = [
    Igredient(1, Food(1, 'Feijão preto'), null),
    Igredient(2, Food(3, 'Arroz'), null),
    Igredient(3, Food(5, 'Carne'), Food(6, 'Frango')),
    Igredient(4, Food(7, 'Acabate'), Food(8, 'Morango')),
    Igredient(5, Food(9, 'Cebola'), Food(10, 'Tomate')),
    Igredient(6, Food(11, 'Espinafre'), Food(12, 'Uva')),
    Igredient(7, Food(13, 'Ovo'), Food(14, 'Óleo')),
    Igredient(8, Food(15, 'Banana'), Food(16, 'Maçã')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFF3E0),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 54, bottom: 19),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    RawMaterialButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      elevation: 2.0,
                      fillColor: Theme.of(context).primaryColor,
                      child: Icon(
                        Icons.arrow_back,
                        size: 30.0,
                        color: Colors.white,
                      ),
                      padding: EdgeInsets.all(7.0),
                      shape: CircleBorder(),
                      constraints: BoxConstraints(minWidth: 0),
                    ),
                    SizedBox(
                      width: 50,
                    ),
                    Text('Nova Receita',
                        style: TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.w600,
                            fontStyle: FontStyle.normal,
                            color: Theme.of(context).primaryColor))
                  ],
                ),
              ),
              SizedBox(
                height: 24.0,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Text('Indentificação',
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            color: Color(0xFF333333))),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Text('Ingredientes',
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            color: Color(0xFF333333))),
                  ],
                ),
              ),
              Container(
                height: 28,
                margin: EdgeInsets.symmetric(vertical: 18),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    for (var i in igredients)
                      Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                        ),
                        padding: EdgeInsets.only(left: 14),
                        margin: EdgeInsets.only(right: 9),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                                i.foodSubstitute != null
                                    ? '${i.food.name} - ${i.foodSubstitute.name}'
                                    : '${i.food.name}',
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w700,
                                    fontStyle: FontStyle.normal,
                                    color: Colors.white)),
                            RawMaterialButton(
                              onPressed: () {},
                              child: Icon(
                                Icons.close,
                                size: 20,
                                color: Colors.white,
                              ),
                              /* padding: EdgeInsets.all(2.0), */
                              shape: CircleBorder(),
                              constraints: BoxConstraints(minWidth: 0),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                margin: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: kElevationToShadow[4],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: TextFormField(
                        initialValue: 'Feijão',
                        decoration: InputDecoration(
                          focusColor: Color(0xFF7B7B7B),
                          labelText: 'Ingrediente',
                          errorText: 'Error message',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          suffixIcon: Icon(
                            Icons.error,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 30),
                    Flexible(
                      child: TextFormField(
                        initialValue: 'Feijão',
                        decoration: InputDecoration(
                          focusColor: Color(0xFF7B7B7B),
                          labelText: 'Ingrediente',
                          errorText: 'Error message',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          suffixIcon: Icon(
                            Icons.error,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 20, left: 20, top: 13),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ActionButton(
                        text: 'Adcionar',
                        textColor: Theme.of(context).primaryColor,
                        buttonColor: Theme.of(context).primaryColor,
                        action: () {
                          Navigator.of(context).pop();
                        },
                        outlined: true),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Modo de preparo',
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            color: Color(0xFF333333))),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Flexible(
                        child: TextFormField(
                          maxLines: 8,
                          initialValue: 'Preparo da receita',
                          decoration: InputDecoration(
                            focusColor: Color(0xFF7B7B7B),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Row(
                  children: [
                    Flexible(
                      child: TextFormField(
                        initialValue: 'Exemplo',
                        decoration: InputDecoration(
                          focusColor: Color(0xFF7B7B7B),
                          labelText: 'Tempo',
                          errorText: 'Error message',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          suffixIcon: Icon(
                            Icons.error,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 30),
                    Flexible(
                      child: TextFormField(
                        initialValue: 'Exemplo',
                        decoration: InputDecoration(
                          focusColor: Color(0xFF7B7B7B),
                          labelText: 'Dificuldade',
                          errorText: 'Error message',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          suffixIcon: Icon(
                            Icons.error,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 13),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ActionButton(
                        text: 'Cadastrar',
                        textColor: Colors.white,
                        buttonColor: Theme.of(context).primaryColor,
                        action: () {
                          Navigator.of(context).pop();
                        }),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
