import 'package:flutter/material.dart';

import 'input.dart';

class SearchBar extends StatelessWidget {
  final TextEditingController controller;
  final Function onChanged;

  SearchBar({this.controller, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(19, 0, 19, 15),
      child: Row(
        children: [
          Input(
            controller: controller,
            borderRadius: 50.0,
            label: 'O que tem na sua geladeira?',
            labelFontSize: 18,
            floatingLabelBehavior: FloatingLabelBehavior.never,
            icon: Icon(
              Icons.search,
              color: Theme.of(context).primaryColor,
              size: 30,
            ),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
