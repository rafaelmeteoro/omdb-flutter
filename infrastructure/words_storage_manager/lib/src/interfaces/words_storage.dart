import 'package:core/domain.dart';

abstract class WordsStorage {
  Future<List<String>> read(String key);
  Future<Unit> put(String key, String value);
  Future<Unit> delete(String key, String value);
}
