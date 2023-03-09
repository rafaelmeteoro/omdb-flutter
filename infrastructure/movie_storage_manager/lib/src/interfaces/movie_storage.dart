import 'package:core/domain.dart';

abstract class MovieStorage {
  Future<List<Map>> read(String key);
  Future<Unit> put(String key, Map value);
}
