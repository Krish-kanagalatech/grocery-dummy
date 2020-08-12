import 'package:grocerycustomerdemo/Themes/colors.dart';
import 'package:flutter/material.dart';

class EntryField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String image;
  final String initialValue;
  final bool readOnly;
  final TextInputType keyboardType;
  final int maxLength;
  final int maxLines;
  final String hint;
  final InputBorder border;
  final Widget suffixIcon;
  final Function onTap;
  final TextCapitalization textCapitalization;
  final Color imageColor;
  final Function onChanged;
  final Widget prefixIcon;

  EntryField({
    this.controller,
    this.label,
    this.image,
    this.initialValue,
    this.readOnly,
    this.keyboardType,
    this.maxLength,
    this.hint,
    this.border,
    this.maxLines,
    this.suffixIcon,
    this.onTap,
    this.textCapitalization,
    this.imageColor,
    this.onChanged,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 8.0),
      child: TextFormField(
        textCapitalization: textCapitalization ?? TextCapitalization.sentences,
        cursorColor: kMainColor,
        onTap: onTap,
        autofocus: false,
        controller: controller,
        initialValue: initialValue,
        readOnly: readOnly ?? false,
        keyboardType: keyboardType,
        onChanged: onChanged,
        minLines: 1,
        maxLength: maxLength,
        maxLines: maxLines,
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          labelText: label,
          hintText: hint,
          hintStyle: Theme.of(context)
              .textTheme
              .caption
              .copyWith(color: kLightTextColor),
          border: border,
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
            borderSide: BorderSide(width: 2, color: kLightTextColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
            borderSide: BorderSide(width: 2, color: kLightTextColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(width: 2, color: kLightTextColor),
          ),
          counter: Offstage(),
          icon: (image != null)
              ? ImageIcon(
                  AssetImage(image),
                  color: imageColor ?? kMainColor,
                  size: 20.0,
                )
              : null,
        ),
      ),
    );
  }
}
