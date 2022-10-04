import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/colors.dart';
import '../utils/typography.dart';

final appTheme = ThemeData(
  backgroundColor: AppColors.white,
  scaffoldBackgroundColor: AppColors.white,
  appBarTheme: AppBarTheme(
    iconTheme: const IconThemeData(color: AppColors.black),
    backgroundColor: AppColors.white,
    titleTextStyle: AppTypography.appBar(),
    centerTitle: true,
    elevation: 1,
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: AppColors.white,
    ),
  ),
);
