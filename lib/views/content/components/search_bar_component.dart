import 'package:fastrecipes/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

import 'input.dart';

class SearchBarComponent extends StatelessWidget {
  final TextEditingController searchController;
  final Function handleSearch;

  const SearchBarComponent(
      {Key key, @required this.searchController, @required this.handleSearch})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.textButtonColor,
          boxShadow: kElevationToShadow[3],
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(19, 30, 19, 15),
            child: Row(
              children: [
                Input(
                  controller: searchController,
                  borderRadius: 10.0,
                  label: 'O que tem na sua geladeira?',
                  labelFontSize: 18,
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  icon: Icon(
                    Icons.search,
                    color: Theme.of(context).primaryColor,
                    size: 30,
                  ),
                  onChanged: (text) {
                    handleSearch(text);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
