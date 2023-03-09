import 'package:core/domain.dart';

abstract class MovieStorage {
  Future<List<Map>> readAll();
  Future<Map> read(String key);
  Future<Unit> put(String key, Map value);
  Future<Unit> delete(String key);
  Future<bool> containsKey(String key);
}
