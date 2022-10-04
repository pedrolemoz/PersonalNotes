import 'package:flutter/material.dart';

import 'colors.dart';

class AppTypography {
  static const _fontFamily = 'Inter';

  static TextStyle title({Color? color, bool boldText = false}) => TextStyle(
        fontFamily: _fontFamily,
        fontSize: 32,
        fontWeight: boldText ? FontWeight.w700 : FontWeight.w500,
        color: color ?? AppColors.black,
      );

  static TextStyle appBar({Color? color, bool boldText = false}) => TextStyle(
        fontFamily: _fontFamily,
        fontSize: 24,
        fontWeight: boldText ? FontWeight.w700 : FontWeight.w500,
        color: color ?? AppColors.black,
      );

  static TextStyle button({Color? color, bool boldText = false}) => TextStyle(
        fontFamily: _fontFamily,
        fontSize: 18,
        fontWeight: boldText ? FontWeight.w700 : FontWeight.w500,
        color: color ?? AppColors.lightGray1,
      );

  static TextStyle textField({Color? color, bool boldText = false}) => TextStyle(
        fontFamily: _fontFamily,
        fontSize: 18,
        fontWeight: boldText ? FontWeight.w700 : FontWeight.w500,
        color: color ?? AppColors.darkGray3,
      );

  static TextStyle textHeadline({Color? color, bool boldText = false}) => TextStyle(
        fontFamily: _fontFamily,
        fontSize: 18,
        fontWeight: boldText ? FontWeight.w700 : FontWeight.w500,
        color: color ?? AppColors.darkGray3,
      );

  static TextStyle textSubtitle({Color? color, bool boldText = false}) => TextStyle(
        fontFamily: _fontFamily,
        fontSize: 16,
        fontWeight: boldText ? FontWeight.w700 : FontWeight.w500,
        color: color ?? AppColors.darkGray2,
      );

  static TextStyle textOverline({Color? color, bool boldText = false}) => TextStyle(
        fontFamily: _fontFamily,
        fontSize: 14,
        fontWeight: boldText ? FontWeight.w700 : FontWeight.w500,
        color: color ?? AppColors.darkGray1,
      );
}
