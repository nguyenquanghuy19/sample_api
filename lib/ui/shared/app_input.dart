import 'package:elearning/ui/shared/app_theme.dart';
import 'package:flutter/material.dart';

class AppInput extends StatelessWidget {
  final String hintText;
  final Widget? prefixIcon;
  final double radius;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final double contentPaddingHorizontal;
  final double contentPaddingVertical;
  final FormFieldValidator<String>? validator;
  final TextInputType? keyboardType;
  final TextStyle? textFormFieldStyle;
  final TextStyle? textLabelStyle;
  final TextStyle? hintStyle;
  final bool obscureText;
  final Widget? suffixIcon;
  final bool readOnly;
  final String? label;
  final Function()? onTap;
  final int maxLines;
  final TextInputAction? textInputAction;
  final Color? fillColor;
  final int? maxLength;
  final bool isBorder;
  final bool autoFocus;
  final Function()? onDone;
  final FocusNode? focusNode;

  const AppInput({
    Key? key,
    required this.hintText,
    this.prefixIcon,
    this.radius = 24,
    this.controller,
    this.onChanged,
    this.contentPaddingHorizontal = 8,
    this.contentPaddingVertical = 13.5,
    this.validator,
    this.keyboardType,
    this.textLabelStyle,
    this.textFormFieldStyle,
    this.hintStyle,
    this.obscureText = false,
    this.suffixIcon,
    this.readOnly = false,
    this.label,
    this.onTap,
    this.maxLines = 1,
    this.textInputAction,
    this.fillColor,
    this.maxLength,
    this.isBorder = true,
    this.autoFocus = false,
    this.onDone,
    this.focusNode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Padding(
            padding: const EdgeInsets.only(
              bottom: 8,
            ),
            child: Text(
              label!,
              style: textLabelStyle ??
                  AppText.text16.copyWith(color: AppColor.primary.shade400),
            ),
          ),
        TextFormField(
          style: textFormFieldStyle ??
              AppText.text20.copyWith(fontWeight: FontWeight.bold),
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
            prefixIcon: prefixIcon != null
                ? Padding(
                    padding: const EdgeInsets.only(
                      left: 4,
                    ),
                    child: prefixIcon,
                  )
                : null,
            suffixIcon: suffixIcon != null
                ? Padding(
                    padding: const EdgeInsets.only(
                      right: 4,
                    ),
                    child: suffixIcon,
                  )
                : null,
            isDense: true,
            hintText: hintText,
            contentPadding: EdgeInsets.only(
              left: prefixIcon != null ? contentPaddingHorizontal : 16,
              right: suffixIcon != null ? contentPaddingHorizontal : 16,
              top: contentPaddingVertical,
              bottom: contentPaddingVertical,
            ),
            errorMaxLines: 5,
            hintStyle:
                hintStyle ?? AppText.text14.copyWith(color: AppColor.neutrals.shade300),
            border: isBorder
                ? OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: AppColor.neutrals,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(radius),
                  )
                : InputBorder.none,
            enabledBorder: isBorder
                ? OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: AppColor.neutrals,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(radius),
                  )
                : InputBorder.none,
          ),
        ),
      ],
    );
  }
}
