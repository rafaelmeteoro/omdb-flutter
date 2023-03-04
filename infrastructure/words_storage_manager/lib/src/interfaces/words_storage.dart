abstract class WordsStorage {
  void setBox({required String name});
  Future<List<String>> read(String key);
}
