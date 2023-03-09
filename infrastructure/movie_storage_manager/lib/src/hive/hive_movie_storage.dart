import 'package:core/domain.dart';

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

  /// Recupera os dados de todas as chaves presentes
  @override
  Future<List<Map>> readAll() async {
    try {
      final box = await _openBox(movieBox);
      if (box.isEmpty) {
        return [];
      }
      final movies = <Map>[];
      for (final key in box.keys) {
        final movie = await read(key);
        movies.add(movie);
      }
      return movies;
    } catch (e) {
      throw MovieStorageException(message: '$e');
    }
  }

  /// Recupera a estrutura de dados na chave [key]
  ///
  /// ```dart
  /// try {
  ///   final result = awaitfinalvieStorage.read('my_key');
  /// } catch (e) {
  ///   ...
  /// }
  /// ```
  @override
  Future<Map> read(String key) async {
    try {
      final box = await _openBox(movieBox);
      final response = await box.get(key);
      return response ?? {};
    } catch (e) {
      throw MovieStorageException(message: '$e');
    }
  }

  /// Armazena a estrutura de dados [value] na chave [key]
  ///
  /// ```dart
  /// try {
  ///   final result = await movieStorage.put('my_key', value);
  /// } catch (e) {
  ///   ...
  /// }
  /// ```
  @override
  Future<Unit> put(String key, Map value) async {
    try {
      final box = await _openBox(movieBox);
      await box.put(key, value);
      return unit;
    } catch (e) {
      throw MovieStorageException(message: '$e');
    }
  }

  /// Apaga a chave [key]
  ///
  /// ```dart
  /// try {
  ///   final result = await movieStorage.delete('my_key');
  /// } catch (e) {
  ///   ...
  /// }
  /// ```
  @override
  Future<Unit> delete(String key) async {
    try {
      final box = await _openBox(movieBox);
      await box.delete(key);
      return unit;
    } catch (e) {
      throw MovieStorageException(message: '$e');
    }
  }

  /// Verifica se o box possui a [key] informada
  ///
  /// ```dart
  /// try {
  ///   final result = await movieStorage.containsKey('my_key');
  /// } catch (e) {
  ///   ...
  /// }
  /// ```
  @override
  Future<bool> containsKey(String key) async {
    try {
      final box = await _openBox(movieBox);
      return box.containsKey(key);
    } catch (e) {
      throw MovieStorageException(message: '$e');
    }
  }
}
