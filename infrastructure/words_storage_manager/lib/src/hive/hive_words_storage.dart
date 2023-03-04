import 'dart:async';

import 'package:core/domain.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../errors/words_storage_exception.dart';
import '../interfaces/words_storage.dart';

/// Implementação do [WordsStorage] utilizando o [hivedb](https://docs.hivedb.dev/#/README)
///
/// ```dart
/// final wordsStorage = HiveWordsStorage(Hive);
/// wordsStorage.setBox(name: 'my_box_name');
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

  final HiveInterface _hive;
  final Completer<Box> _completer = Completer<Box>();
  String? _boxName;

  /// Define o nome do tablesspace que será utilizado no [HiveWordsStorage]
  ///
  /// ```dart
  /// final wordsStorage = HiveWordsStorage(Hive);
  /// wordsStorage.setBox(name: 'my_box_name');
  /// ```
  @override
  void setBox({required String name}) {
    _boxName = name;
    _init();
  }

  Future<void> _init() async {
    await _hive.initFlutter();
    final box = await _hive.openBox('$_boxName');
    _completer.complete(box);
  }

  /// Recupera a estrutura de dados na chame [key]
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
    final box = await _completer.future;

    try {
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
  @override
  Future<Unit> put(String key, String value) async {
    final box = await _completer.future;

    try {
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
  ///   final result = await wordsStorage.delete('mey_key', value);
  /// } catch (e) {
  ///   ...
  /// }
  @override
  Future<Unit> delete(String key, String value) async {
    final box = await _completer.future;

    try {
      final wordsStorage = await read(key);
      final wordsSet = wordsStorage.toSet()..remove(value);
      await box.put(key, wordsSet.toList());
      return unit;
    } catch (e) {
      throw WordsStorageException(message: '$e');
    }
  }
}
