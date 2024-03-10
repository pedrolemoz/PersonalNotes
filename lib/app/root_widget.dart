import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'core/presentation/widgets/app_theme.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Personal Notes',
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
    );
  }
}
