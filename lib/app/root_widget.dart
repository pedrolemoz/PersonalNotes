import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'core/utils/colors.dart';
import 'core/utils/typography.dart';

class RootWidget extends StatelessWidget {
  const RootWidget({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: AppColors.white,
      ),
    );

    return MaterialApp.router(
      title: 'Personal Notes',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
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
      ),
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
    );
  }
}
