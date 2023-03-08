import '../../movie_storage_manager.dart';

/// Implementação do [MovieStorage] utilizando o [hivedb](https://docs.hivedb.dev/#/README)
///
/// ```dart
/// final movieStorage = HiveMovieStorage(Hive)
///
/// try {
///   final result = await movieStorage.read('my_key');
/// } catch (e) {
///   ...
/// }
/// ```
class HiveMovieStorage implements MovieStorage {
  HiveMovieStorage({
    required HiveInterface hive,
  }) : _hive = hive;

  static const String movieBox = 'movie_box';
  final HiveInterface _hive;

  Future<Box> _openBox(String name) async {
    try {
      await _hive.initFlutter();
      final box = await _hive.openBox(name);
      return box;
    } catch (e) {
      throw MovieStorageException(message: '$e');
    }
  }

  /// Recupera a estrutura de dados na chave [key]
  ///
  /// ```dart
  /// try {
  ///   final result = await movieStorage.read('my_key');
  /// } catch (e) {
  ///   ...
  /// }
  /// ```
  @override
  Future<List<Map>> read(String key) async {
    try {
      final box = await _openBox(movieBox);
      final response = await box.get(key);
      return response ?? [];
    } catch (e) {
      throw MovieStorageException(message: '$e');
    }
  }
}
