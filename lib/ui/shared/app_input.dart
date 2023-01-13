import 'package:flutter/material.dart';
import 'package:testproject/ui/shared/app_theme.dart';

class AppInput extends StatelessWidget {
  final String hintText;
  final double radius;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final double contentPaddingHorizontal;
  final double contentPaddingVertical;
  final FormFieldValidator<String>? validator;
  final TextInputType? keyboardType;
  final TextStyle? textFormFieldStyle;
  final TextStyle? textLabelStyle;
  final bool obscureText;
  final Widget? suffixIcon;
  final bool readOnly;
  final String? label;
  final Function()? onTap;
  final int maxLines;
  final TextInputAction? textInputAction;
  final Color? fillColor;
  final int? maxLength;
  final bool autoFocus;
  final Function()? onDone;
  final FocusNode? focusNode;

  const AppInput({
    Key? key,
    required this.hintText,
    this.radius = 24,
    this.controller,
    this.onChanged,
    this.contentPaddingHorizontal = 8,
    this.contentPaddingVertical = 13.5,
    this.validator,
    this.keyboardType,
    this.textLabelStyle,
    this.textFormFieldStyle,
    this.obscureText = false,
    this.suffixIcon,
    this.readOnly = false,
    this.label,
    this.onTap,
    this.maxLines = 1,
    this.textInputAction,
    this.fillColor,
    this.maxLength,
    this.autoFocus = false,
    this.onDone,
    this.focusNode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          style: textFormFieldStyle ??
              AppText.text20.copyWith(fontWeight: FontWeight.bold, color: Colors.white),
          onTap: onTap,
          focusNode: focusNode,
          onEditingComplete: onDone,
          maxLines: maxLines,
          maxLength: maxLength,
          textInputAction: textInputAction,
          validator: validator,
          keyboardType: keyboardType,
          obscureText: obscureText,
          controller: controller,
          onChanged: onChanged,
          readOnly: readOnly,
          autofocus: autoFocus,
          decoration: InputDecoration(
            counterText: '',
            suffixIconConstraints:
                const BoxConstraints(minHeight: 20, minWidth: 50),
            fillColor: fillColor,
            filled: fillColor != null,
            suffixIcon: suffixIcon ,
            isDense: true,
            hintText: hintText,
            contentPadding: const EdgeInsets.only(right: 16),
            hintStyle:
                AppText.text14.copyWith(color: Colors.white.withOpacity(0.5)),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: AppColor.colorsPrimary),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: AppColor.colorsPrimary,
                style: BorderStyle.solid,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
