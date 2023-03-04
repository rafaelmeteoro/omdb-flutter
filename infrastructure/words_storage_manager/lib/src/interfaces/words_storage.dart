import 'package:core/domain.dart';

abstract class WordsStorage {
  void setBox({required String name});
  Future<List<String>> read(String key);
  Future<Unit> put(String key, String value);
}
