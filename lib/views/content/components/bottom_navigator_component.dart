import 'package:fastrecipes/core/theme/app_colors.dart';
import 'package:fastrecipes/core/theme/app_icons.dart';
import 'package:flutter/material.dart';

class BottomNavigatorItemComponent extends StatelessWidget {
  final String label;
  final String activeIcon;
  final String icon;
  final bool isActive;
  final Function onTap;
  final Function goTo;

  BottomNavigatorItemComponent copyWith(
      {String label,
      String activeIcon,
      String icon,
      bool isActive,
      Function onTap,
      Function goTo}) {
    return BottomNavigatorItemComponent(
      label: label ?? this.label,
      activeIcon: activeIcon ?? this.activeIcon,
      icon: icon ?? this.icon,
      isActive: isActive ?? this.activeIcon,
      onTap: onTap ?? this.onTap,
    );
  }

  const BottomNavigatorItemComponent(
      {Key key,
      @required this.label,
      @required this.activeIcon,
      @required this.icon,
      this.isActive = false,
      this.onTap,
      this.goTo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 3.0),
              child: AppIcon(isActive ? activeIcon : icon),
            ),
            Text(
              label,
              style: TextStyle(
                  fontSize: 10,
                  fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                  color: isActive
                      ? AppColors.primaryColor
                      : AppColors.textFadedColor),
            )
          ],
        ),
      ),
    );
  }
}

class BottomNavigatorComponent extends StatelessWidget {
  final List<BottomNavigatorItemComponent> items;
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavigatorComponent(
      {Key key,
      @required this.items,
      this.currentIndex = 0,
      @required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 67.0,
      decoration: BoxDecoration(
          color: AppColors.white,
          border: Border(
              top: BorderSide(color: AppColors.textFadedColor, width: 1.0))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: items
                  .map((e) => e.copyWith(
                      isActive: items.indexOf(e) == currentIndex,
                      onTap: () {
                        onTap(items.indexOf(e));
                        e.goTo != null && e.goTo();
                      }))
                  .toList(),
            ),
          )
        ],
      ),
    );
  }
}
