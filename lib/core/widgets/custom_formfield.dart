import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constant/colors/app_colors.dart';
import '../constant/style/app_fonts.dart';
import '../utils/extensions/mediaquery_extension.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;
  final String? prefixText;
  final bool readOnly;
  final Widget? suffixIcon;
  final ValueNotifier<bool>? obscureNotifier;
  final int? maxLines;
  final int? minLines;
  final List<TextInputFormatter>? inputFormatters;
  final String? suffixText;

  /// NEW: For focus management
  final FocusNode? focusNode;
  final FocusNode? nextFocus;

  /// NEW: For auto submit
  final VoidCallback? onSubmit;

  const CustomTextField({
    super.key,
    required this.hintText,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.done,
    required this.controller,
    this.validator,
    this.onChanged,
    this.prefixText,
    this.suffixIcon,
    this.onEditingComplete,
    this.obscureNotifier,
    this.readOnly = false,
    this.focusNode,
    this.nextFocus,
    this.onSubmit,
    this.maxLines = 1, // default single-line
    this.minLines,
    this.inputFormatters,
    this.suffixText,
  });

  @override
  Widget build(BuildContext context) {
    if (obscureText && obscureNotifier == null) {
      throw Exception(
        'If obscureText is true, you must provide obscureNotifier',
      );
    }

    return obscureText
        ? ValueListenableBuilder<bool>(
      valueListenable: obscureNotifier!,
      builder: (context, isObscure, _) {
        return _buildTextField(context, isObscure);
      },
    )
        : _buildTextField(context, false);
  }


  Widget _buildTextField(BuildContext context, bool isObscure) {
    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: controller,
      builder: (context, value, _) {
        bool hasValue = value.text.isNotEmpty;

        return TextFormField(
          controller: controller,
          focusNode: focusNode,
          obscureText: isObscure,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          validator: validator,
          readOnly: readOnly,
          inputFormatters: inputFormatters,
          style: TextStyle(color: AppColors.textOnPrimary),

          cursorColor: AppColors.primaryColors,
          maxLines: maxLines,
          minLines: minLines,

          onChanged: (val) {
            if (onChanged != null) onChanged!(val);
          },
          onFieldSubmitted: (_) {
            if (nextFocus != null) {
              FocusScope.of(context).requestFocus(nextFocus);
            } else {
              if (onSubmit != null) onSubmit!();
            }
          },
          decoration: InputDecoration(
            prefixIcon: prefixText?.isNotEmpty == true
                ? Container(
              padding: const EdgeInsets.only(left: 10),
              alignment: Alignment.centerLeft,
              width: context.widthPct(0.12),
              child: Text(
                prefixText!,
                style: TextStyle(
                  color: AppColors.black,
                  fontSize: context.scaledFont(14),
                  fontFamily: AppFonts.primaryFont,
                ),
              ),
            )
                : null,
            prefixIconConstraints: const BoxConstraints(
              minWidth: 0,
              minHeight: 0,
            ),
            contentPadding: context.responsivePadding(
              horizontal: 0.03,
              vertical: 0.01,
            ),
            hintText: hintText,

            hintStyle: TextStyle(
              color: AppColors.textHint,
              fontSize: context.scaledFont(14),
              fontFamily: AppFonts.primaryFont,
            ),

            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: AppColors.borderColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: AppColors.primaryColors, //  Always Primary on Focus
                width: 1.5,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: hasValue
                    ? AppColors.primaryColors
                    : AppColors.borderColor, //  Dynamic
              ),
            ),
            suffixIcon:
            suffixIcon ??
                (obscureText
                    ? IconButton(
                  icon: Icon(
                    isObscure
                        ? CupertinoIcons.eye_slash
                        : CupertinoIcons.eye,
                    color: AppColors.borderColor,
                  ),
                  onPressed: () {
                    obscureNotifier?.value = !isObscure;
                  },
                )
                    : null),
            suffixText: suffixText,
            suffixStyle: TextStyle(
              color: AppColors.textHint,
              fontSize: context.scaledFont(14),
              fontFamily: AppFonts.primaryFont,
            ),
          ),
        );
      },
    );
  }
}













