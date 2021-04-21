import 'package:flutter/material.dart';

class FoodChip extends StatelessWidget {
  final String food;
  final String substituteFood;
  final VoidCallback onRemove;

  FoodChip({this.food, this.substituteFood, this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.all(Radius.circular(50)),
      ),
      padding: EdgeInsets.only(left: 14),
      margin: EdgeInsets.only(left: 9),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(substituteFood != null ? '$food - $substituteFood' : '$food',
              style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.normal,
                  color: Colors.white)),
          RawMaterialButton(
            onPressed: onRemove,
            child: Icon(
              Icons.close,
              size: 20,
              color: Colors.white,
            ),
            shape: CircleBorder(),
            constraints: BoxConstraints(minWidth: 0),
          ),
        ],
      ),
    );
  }
}
