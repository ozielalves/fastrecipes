import 'package:fastrecipes/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Input extends StatelessWidget {
  final String label;
  final String initialValue;
  final double labelFontSize;
  final String errorMessage;
  final TextEditingController controller;
  final int maxLines;
  final bool mandatory;
  final TextInputType type;
  final Function onSubmit;
  final Function validator;
  final Icon icon;
  final double borderRadius;
  final FloatingLabelBehavior floatingLabelBehavior;
  final Function onChanged;
  final Function onSaved;
  final Color fillColor;
  final Color labelColor;
  final FocusNode focusNode;

  const Input(
      {Key key,
      this.label,
      this.initialValue,
      this.labelFontSize = 16,
      this.errorMessage,
      this.controller,
      this.maxLines,
      this.mandatory = false,
      @required this.type,
      this.onSubmit,
      this.validator,
      this.icon,
      this.borderRadius = 10,
      this.floatingLabelBehavior = FloatingLabelBehavior.auto,
      this.onChanged,
      this.fillColor,
      this.onSaved,
      this.labelColor,
      this.focusNode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: TextFormField(
          maxLines: maxLines,
          onFieldSubmitted: onSubmit,
          focusNode: focusNode,
          initialValue: initialValue,
          keyboardType: type,
          inputFormatters: type == TextInputType.number
              ? <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly]
              : null,
          controller: controller,
          validator: validator,
          decoration: InputDecoration(
              fillColor: fillColor,
              filled: fillColor != null ? true : false,
              floatingLabelBehavior: floatingLabelBehavior,
              prefixIcon: icon,
              labelText: label,
              errorText: errorMessage,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                borderSide: BorderSide(
                    color: fillColor != null ? fillColor : Color(0xFF7B7B7B),
                    width: 1),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
              ),
              suffixIcon: mandatory
                  ? Icon(
                      Icons.error,
                    )
                  : null,
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: fillColor != null ? fillColor : Color(0xFF7B7B7B),
                    width: 2.0),
                borderRadius: BorderRadius.circular(borderRadius),
              ),
              labelStyle: TextStyle(
                  color: labelColor != null ? labelColor : AppColors.darkGrey,
                  fontSize: labelFontSize)),
          onChanged: onChanged,
          onSaved: onSaved),
    );
  }
}
