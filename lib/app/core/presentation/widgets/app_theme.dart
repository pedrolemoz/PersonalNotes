import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/typography.dart';

final appTheme = ThemeData(
  useMaterial3: false,
  backgroundColor: AppColors.white,
  scaffoldBackgroundColor: AppColors.white,
  primaryColor: AppColors.blue,
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    shape: const CircleBorder(side: BorderSide(color: AppColors.purple)),
    elevation: 0,
    backgroundColor: AppColors.blue,
    splashColor: AppColors.blue,
    focusColor: AppColors.blue.withOpacity(0.5),
    hoverColor: AppColors.blue.withOpacity(0.5),
    foregroundColor: AppColors.blue.withOpacity(0.5),
  ),
  appBarTheme: AppBarTheme(
    iconTheme: const IconThemeData(color: AppColors.black),
    backgroundColor: AppColors.white,
    titleTextStyle: AppTypography.appBar(),
    centerTitle: true,
    elevation: 1,
  ),
);
