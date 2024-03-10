import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'app/app_module.dart';
import 'app/core/presentation/utils/hive_initializer.dart';
import 'app/root_widget.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  hiveInitializer(
    execute: () => runApp(
      ModularApp(
        child: const AppWidget(),
        module: AppModule(),
      ),
    ),
  );
}
