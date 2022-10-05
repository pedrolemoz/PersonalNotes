import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path;

Future<void> hiveInitializer({required void Function() execute}) async {
  final applicationDocumentsDirectory = await path.getApplicationDocumentsDirectory();
  Hive.init(applicationDocumentsDirectory.path);
  execute();
}
