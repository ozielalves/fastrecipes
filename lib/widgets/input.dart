import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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