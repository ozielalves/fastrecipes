import 'package:fastrecipes/widgets/search_bar.dart';
import 'package:flutter/material.dart';

import 'page_header.dart';

SliverAppBar createAppBar(PageHeader pageHeader) {
  return SliverAppBar(
    backgroundColor: Colors.white,
    expandedHeight: 300,
    pinned: true,
    floating: false,
    elevation: 0,
    flexibleSpace: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return FlexibleSpaceBar(
        collapseMode: CollapseMode.parallax,
        background: Container(
          margin: EdgeInsets.fromLTRB(19, 54, 19, 19),
          child: pageHeader,
        ),
      );
    }),
  );
}

SliverAppBar createSearchBar(
    TextEditingController controller, Function onChanged) {
  return SliverAppBar(
    backgroundColor: Colors.white,
    title: Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      height: 40,
      decoration: BoxDecoration(
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.grey.withOpacity(0.6),
              offset: const Offset(1.1, 1.1),
              blurRadius: 5.0),
        ],
      ),
      child: SearchBar(
        controller: controller,
        onChanged: onChanged,
      ),
    ),
  );
}
