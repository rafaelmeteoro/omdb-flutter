import 'dart:async';

import 'package:core/domain.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../errors/words_storage_exception.dart';
import '../interfaces/words_storage.dart';

/// Implementação do [WordsStorage] utilizando o [hivedb](https://docs.hivedb.dev/#/README)
///
/// ```dart
/// final wordsStorage = HiveWordsStorage(Hive);
///
/// try {
///   final result = await wordsStorage.read('my_key');
/// } catch(e) {
///   ...
/// }
/// ```
class HiveWordsStorage implements WordsStorage {
  HiveWordsStorage({
    required HiveInterface hive,
  }) : _hive = hive;

  static const String wordsBox = 'words_box';
  final HiveInterface _hive;

  Future<Box> _openBox(String name) async {
    try {
      await _hive.initFlutter();
      final box = await _hive.openBox(name);
      return box;
    } catch (e) {
      throw WordsStorageException(message: '$e');
    }
  }

  /// Recupera a estrutura de dados na chave [key]
  ///
  /// ```dart
  /// try {
  ///   final result = await wordsStorage.read('my_key');
  /// } catch(e) {
  ///   ...
  /// }
  /// ```
  @override
  Future<List<String>> read(String key) async {
    try {
      final box = await _openBox(wordsBox);
      final response = await box.get(key);
      return response ?? [];
    } catch (e) {
      throw WordsStorageException(message: '$e');
    }
  }

  /// Armazena a estrutura de dados [value] na chave [key]
  ///
  /// ```dart
  /// try {
  ///   final result = await wordsStorage.put('my_key', value);
  /// } catch (e) {
  ///   ...
  /// }
  /// ```
  @override
  Future<Unit> put(String key, String value) async {
    try {
      final box = await _openBox(wordsBox);
      final wordsStorage = await read(key);
      final wordsSet = wordsStorage.toSet()..add(value);
      await box.put(key, wordsSet.toList());
      return unit;
    } catch (e) {
      throw WordsStorageException(message: '$e');
    }
  }

  /// Apaga o dado [value] na chave [key]
  ///
  /// ```dart
  /// try {
  ///   final result = await wordsStorage.delete('my_key', value);
  /// } catch (e) {
  ///   ...
  /// }
  /// ```
  @override
  Future<Unit> delete(String key, String value) async {
    try {
      final box = await _openBox(wordsBox);
      final wordsStorage = await read(key);
      final wordsSet = wordsStorage.toSet()..remove(value);
      await box.put(key, wordsSet.toList());
      return unit;
    } catch (e) {
      throw WordsStorageException(message: '$e');
    }
  }
}
