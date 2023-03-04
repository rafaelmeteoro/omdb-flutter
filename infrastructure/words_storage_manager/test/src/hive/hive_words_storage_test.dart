import 'package:dev_core/dev_core.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:words_storage_manager/src/hive/hive_words_storage.dart';
import 'package:words_storage_manager/src/interfaces/words_storage.dart';

import 'directory.dart';

class FakePathProviderPlatform extends Fake with MockPlatformInterfaceMixin implements PathProviderPlatform {
  @override
  Future<String?> getApplicationDocumentsPath() async {
    final dir = await getTempDir();
    return dir.path;
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late WordsStorage sut;

  setUp(() {
    PathProviderPlatform.instance = FakePathProviderPlatform();
    sut = HiveWordsStorage(hive: Hive);
  });

  group(HiveWordsStorage, () {
    test('read() must retrieve empty list from key without previews data', () async {
      // Arrange
      final key = 'read_test_empty';
      sut.setBox(name: 'read_empty_tb');

      // Act
      final data = await sut.read(key);

      // Assert
      expect(data, []);
    });

    test('put() must storage the valid data in the given key', () async {
      // Arrange
      final key = 'put_test';
      sut.setBox(name: 'put_tb');

      // Act
      final result1 = await sut.put(key, 'banana');
      final result2 = await sut.put(key, 'maça');
      final result3 = await sut.put(key, 'mamão');
      final result4 = await sut.put(key, 'banana');
      final result5 = await sut.put(key, 'maça');
      final data = await sut.read(key);

      // Assert
      expect(result1, isA<Unit>());
      expect(result2, isA<Unit>());
      expect(result3, isA<Unit>());
      expect(result4, isA<Unit>());
      expect(result5, isA<Unit>());
      expect(data, ['banana', 'maça', 'mamão']);
    });

    test('put() must not storage same value more than once', () async {
      // Arrange
      final key = 'put_test';
      sut.setBox(name: 'put_tb');

      // Act
      final result1 = await sut.put(key, 'banana');
      final result2 = await sut.put(key, 'banana');
      final result3 = await sut.put(key, 'banana');
      final data = await sut.read(key);

      // Assert
      expect(result1, isA<Unit>());
      expect(result2, isA<Unit>());
      expect(result3, isA<Unit>());
      expect(data, ['banana']);
    });

    test('delete() must remove value', () async {
      // Arrange
      final key = 'delete_test';
      sut.setBox(name: 'delete_tb');

      // Act
      await sut.put(key, 'banana');
      await sut.put(key, 'maça');
      await sut.put(key, 'mamão');

      final result = await sut.delete(key, 'maça');
      final data = await sut.read(key);

      // Assert
      expect(result, isA<Unit>());
      expect(data, ['banana', 'mamão']);
    });
  });
}
