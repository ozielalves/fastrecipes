import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

class PageHeader extends StatelessWidget {
  final String title;

  PageHeader({this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ActionButton(
            action: () {
              Navigator.of(context).pop();
            },
            icon: Icons.arrow_back,
            buttonColor: Theme.of(context).primaryColor),
        SizedBox(
          width: 50,
        ),
        Text(title,
            style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.w600,
                fontStyle: FontStyle.normal,
                color: Theme.of(context).primaryColor))
      ],
    );
  }
}

class TaskCardWidget extends StatelessWidget {
  final String title;
  final String desc;

  TaskCardWidget({this.title, this.desc});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: 32.0,
        horizontal: 24.0,
      ),
      margin: EdgeInsets.only(
        bottom: 20.0,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title ?? "(Unnamed Task)",
            style: TextStyle(
              color: Color(0xFF211551),
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: 10.0,
            ),
            child: Text(
              desc ?? "No Description Added",
              style: TextStyle(
                fontSize: 16.0,
                color: Color(0xFF86829D),
                height: 1.5,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ActionButton extends StatelessWidget {
  final String text;
  final Color textColor;
  final Color buttonColor;
  final Function action;
  final bool outlined;
  final IconData icon;
  final double iconSize;

  ActionButton({
    this.text,
    this.textColor,
    this.buttonColor,
    this.action,
    this.outlined = false,
    this.icon,
    this.iconSize = 30,
  });

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: action,
      elevation: outlined ? 0 : 2.0,
      fillColor: outlined ? Colors.transparent : buttonColor,
      child: icon != null
          ? Icon(
              icon,
              size: iconSize,
              color: Colors.white,
            )
          : Text(text,
              style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.normal,
                  color: textColor)),
      padding: icon != null
          ? EdgeInsets.all(7.0)
          : EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
      shape: icon != null
          ? CircleBorder()
          : RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              side: BorderSide(
                  width: 2,
                  color: outlined ? buttonColor : Colors.transparent)),
      constraints: BoxConstraints(minWidth: 0),
    );
  }
}

class Input extends StatelessWidget {
  final String label;
  final double labelFontSize;
  final String errorMessage;
  final TextEditingController controller;
  final int maxLines;
  final bool mandatory;
  final String type;
  final Function onSubmit;
  final Function validator;
  final Icon icon;
  final double borderRadius;
  final FloatingLabelBehavior floatingLabelBehavior;
  final Function onChanged;

  Input(
      {this.label,
      this.labelFontSize = 16,
      this.errorMessage,
      this.controller,
      this.maxLines,
      this.mandatory = false,
      this.type = 'text',
      this.onSubmit,
      this.validator,
      this.icon,
      this.borderRadius = 10,
      this.floatingLabelBehavior = FloatingLabelBehavior.auto,
      this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: TextFormField(
        maxLines: maxLines,
        onFieldSubmitted: onSubmit,
        keyboardType:
            type != 'text' ? TextInputType.number : TextInputType.text,
        inputFormatters: type != 'text'
            ? <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly]
            : null,
        controller: controller,
        validator: validator,
        decoration: InputDecoration(
            floatingLabelBehavior: floatingLabelBehavior,
            prefixIcon: icon,
            labelText: label,
            errorText: errorMessage,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius)),
            suffixIcon: mandatory
                ? Icon(
                    Icons.error,
                  )
                : null,
            focusedBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: Color(0xFF7B7B7B), width: 2.0),
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            labelStyle:
                TextStyle(color: Color(0xFF7B7B7B), fontSize: labelFontSize)),
        onChanged: onChanged,
      ),
    );
  }
}

class FoodChip extends StatelessWidget {
  final String food;
  final String substituteFood;
  final Function onRemove;

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

class Modal {
  mainBottomSheet(BuildContext context) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
        ),
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 400.0,
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(
                    top: 32.0,
                    bottom: 32.0,
                  ),
                  child: SvgPicture.asset(
                    'assets/images/oziel_logo.svg',
                  ),
                ),
                Text(
                  'What Todo!?',
                  style: TextStyle(
                    fontSize: 36.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF211551),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0, bottom: 30.0),
                  child: Text(
                    'What todo, is a simples app to list your tasks and to check when finished',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.normal,
                      color: Color(0xFF211551),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: 300.0,
                    height: 60.0,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Color(0xFF7349FE), Color(0xFF643FDB)],
                          begin: Alignment(0.0, -1.0),
                          end: Alignment(0.0, 1.0)),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Text(
                      'Get Started',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }
}

class NoGlowBehaviour extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
