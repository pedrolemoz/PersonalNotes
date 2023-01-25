import 'package:uuid/uuid.dart';

import '../../infrastucture/datasources/id_generator.dart';
import '../../infrastucture/exceptions/id_generator_exceptions.dart';

class IdGeneratorImplementation implements IdGenerator {
  final Uuid _uuid;

  const IdGeneratorImplementation([this._uuid = const Uuid()]);

  @override
  String generate() {
    try {
      return _uuid.v4();
    } catch (_) {
      throw UnableTGenerateIdException();
    }
  }
}
