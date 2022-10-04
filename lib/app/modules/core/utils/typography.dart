import 'package:flutter/material.dart';

import 'colors.dart';

class AppTypography {
  static const _fontFamily = 'Inter';

  static TextStyle title({Color? color}) => TextStyle(
        fontFamily: _fontFamily,
        fontSize: 32,
        fontWeight: FontWeight.w500,
        color: color ?? AppColors.black,
      );

  static TextStyle appBar({Color? color}) => TextStyle(
        fontFamily: _fontFamily,
        fontSize: 24,
        fontWeight: FontWeight.w500,
        color: color ?? AppColors.black,
      );

  static TextStyle button({Color? color}) => TextStyle(
        fontFamily: _fontFamily,
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: color ?? AppColors.darkWhite,
      );

  static TextStyle textField({Color? color}) => TextStyle(
        fontFamily: _fontFamily,
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: color ?? AppColors.darkGrayBorder,
      );

  static TextStyle textHeadline({Color? color}) => TextStyle(
        fontFamily: _fontFamily,
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: color ?? AppColors.black,
      );

  static TextStyle textSubtitle({Color? color}) => TextStyle(
        fontFamily: _fontFamily,
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: color ?? AppColors.black,
      );

  static TextStyle textOverline({Color? color}) => TextStyle(
        fontFamily: _fontFamily,
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: color ?? AppColors.black,
      );
}
