import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ActionButton extends StatelessWidget {
  final String text;
  final Color textColor;
  final Color buttonColor;
  final VoidCallback action;
  final bool outlined;
  final Widget icon;
  final SvgPicture svgIcon;
  final double iconSize;
  final Color iconColor;
  final double borderRadius;
  final double minWidth;
  final EdgeInsets padding;

  ActionButton({
    this.text,
    this.textColor,
    this.buttonColor,
    this.action,
    this.outlined = false,
    this.icon,
    this.svgIcon,
    this.iconSize = 30,
    this.iconColor = Colors.white,
    this.borderRadius,
    this.minWidth = 153.5,
    this.padding = const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
  });

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: action,
      elevation: outlined ? 0 : 2.0,
      fillColor: outlined ? Colors.transparent : buttonColor,
      child: icon != null
          ? icon
          : svgIcon != null && text != null
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    svgIcon,
                    SizedBox(
                      width: 12,
                    ),
                    Text(text,
                        style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.normal,
                            color: textColor)),
                  ],
                )
              : Text(text,
                  style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.normal,
                      color: textColor)),
      padding: padding,
      shape: borderRadius != null
          ? RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(borderRadius)))
          : RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.all(Radius.circular(borderRadius ?? 10)),
              side: BorderSide(
                  width: 2,
                  color: outlined ? buttonColor : Colors.transparent)),
      constraints: BoxConstraints(minWidth: minWidth),
    );
  }
}
