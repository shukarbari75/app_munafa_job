import 'package:flutter/material.dart';


import 'package:app_munafa_job/core/utils/extensions/mediaquery_extension.dart';

import '../localization/app_localization.dart';
class AppText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final double? letterSpace;
  final double? height;
  final TextDecoration? decoration;
  final FontStyle? fontStyle;


  const AppText(this.text, {
    super.key,
    this.style,
    this.color,
    this.fontSize,
    this.fontWeight,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.letterSpace,
    this.height,
    this.decoration,
    this.fontStyle,
  });

  // Factory constructors for specific typography semantics
  factory AppText.displayLarge(String text, {
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    double? height,
    FontWeight? fontWeight,
    double? fontSize,
    double? letterSpacing,
  }) =>
      AppText(
        text,
        style: TextStyle(
          fontSize: fontSize ?? 32,
          fontWeight: fontWeight ?? FontWeight.bold,
          letterSpacing: letterSpacing ?? -0.5,
        ),
        color: color,
        textAlign: textAlign,
        maxLines: maxLines,
        height: height,
        fontWeight: fontWeight,
        letterSpace: letterSpacing,
      );

  factory AppText.displayMedium(String text, {
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    double? height,
    FontWeight? fontWeight,
    double? fontSize,
    double? letterSpacing,
  }) =>
      AppText(
        text,
        style: TextStyle(
          fontSize: fontSize ?? 28,
          fontWeight: fontWeight ?? FontWeight.bold,
          letterSpacing: letterSpacing ?? -0.25,
        ),
        color: color,
        textAlign: textAlign,
        maxLines: maxLines,
        height: height,
        fontWeight: fontWeight,
        letterSpace: letterSpacing,
      );

  factory AppText.headlineLarge(String text, {
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    double? height,
    FontWeight? fontWeight,
    double? fontSize,
    double? letterSpacing,
  }) =>
      AppText(
        text,
        style: TextStyle(
          fontSize: fontSize ?? 24,
          fontWeight: fontWeight ?? FontWeight.bold,
          letterSpacing: letterSpacing,
        ),
        color: color,
        textAlign: textAlign,
        maxLines: maxLines,
        height: height,
        fontWeight: fontWeight,
        letterSpace: letterSpacing,
      );

  factory AppText.headlineMedium(String text, {
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    double? height,
    FontWeight? fontWeight,
    double? fontSize,
    double? letterSpacing,
  }) =>
      AppText(
        text,
        style: TextStyle(
          fontSize: fontSize ?? 20,
          fontWeight: fontWeight ?? FontWeight.w600,
          letterSpacing: letterSpacing,
        ),
        color: color,
        textAlign: textAlign,
        maxLines: maxLines,
        height: height,
        fontWeight: fontWeight,
        letterSpace: letterSpacing,
      );

  factory AppText.titleLarge(String text, {
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    double? height,
    FontWeight? fontWeight,
    double? fontSize,
    double? letterSpacing,
  }) =>
      AppText(
        text,
        style: TextStyle(
          fontSize: fontSize ?? 18,
          fontWeight: fontWeight ?? FontWeight.w600,
          letterSpacing: letterSpacing,
        ),
        color: color,
        textAlign: textAlign,
        maxLines: maxLines,
        height: height,
        fontWeight: fontWeight,
        letterSpace: letterSpacing,
      );

  factory AppText.titleMedium(String text, {
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    double? height,
    FontWeight? fontWeight,
    double? fontSize,
    double? letterSpacing,
  }) =>
      AppText(
        text,
        style: TextStyle(
          fontSize: fontSize ?? 16,
          fontWeight: fontWeight ?? FontWeight.w500,
          letterSpacing: letterSpacing,
        ),
        color: color,
        textAlign: textAlign,
        maxLines: maxLines,
        height: height,
        fontWeight: fontWeight,
        letterSpace: letterSpacing,
      );

  factory AppText.bodyLarge(String text, {
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    double? height,
    FontWeight? fontWeight,
    double? fontSize,
    double? letterSpacing,
  }) =>
      AppText(
        text,
        style: TextStyle(
          fontSize: fontSize ?? 16,
          fontWeight: fontWeight ?? FontWeight.normal,
          letterSpacing: letterSpacing,
        ),
        color: color,
        textAlign: textAlign,
        maxLines: maxLines,
        height: height,
        fontWeight: fontWeight,
        letterSpace: letterSpacing,
      );

  factory AppText.bodyMedium(String text, {
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    double? height,
    FontWeight? fontWeight,
    double? fontSize,
    double? letterSpacing,
  }) =>
      AppText(
        text,
        style: TextStyle(
          fontSize: fontSize ?? 14,
          fontWeight: fontWeight ?? FontWeight.normal,
          letterSpacing: letterSpacing,
        ),
        color: color,
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: overflow,
        height: height,
        fontWeight: fontWeight,
        letterSpace: letterSpacing,
      );

  factory AppText.bodySmall(String text, {
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    double? height,
    FontWeight? fontWeight,
    double? fontSize,
    double? letterSpacing,
  }) =>
      AppText(
        text,
        style: TextStyle(
          fontSize: fontSize ?? 12,
          fontWeight: fontWeight ?? FontWeight.normal,
          letterSpacing: letterSpacing,
        ),
        color: color,
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: overflow,
        height: height,
        fontWeight: fontWeight,
        letterSpace: letterSpacing,
      );

  @override
  Widget build(BuildContext context) {
    final themeTextTheme = Theme
        .of(context)
        .textTheme;
    final baseStyle = style ?? themeTextTheme.bodyMedium ?? const TextStyle();

    // Fallback size if none specified anywhere
    final baseFontSize = fontSize ?? baseStyle.fontSize ?? 14.0;

    // Scale the text using context.scaledFont (from mediaquery_extension.dart)
    final scaledFontSize = context.scaledFont(baseFontSize);

    // Automatically lookup translations
    final translatedText =
        AppLocalization.of(context)?.translate(text) ?? text;

    return Text(
      translatedText,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      style: baseStyle.copyWith(
        color: color ?? baseStyle.color,
        fontSize: scaledFontSize,
        fontWeight: fontWeight ?? baseStyle.fontWeight,
        letterSpacing: letterSpace ?? baseStyle.letterSpacing,
        height: height ?? baseStyle.height,
        decoration: decoration ?? baseStyle.decoration,
        fontStyle: fontStyle ?? baseStyle.fontStyle,
      ),
    );
  }


}