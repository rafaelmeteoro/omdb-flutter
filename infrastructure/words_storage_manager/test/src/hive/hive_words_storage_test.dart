import 'package:dev_core/dev_core.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:words_storage_manager/words_storage_manager.dart';

import 'directory.dart';

class FakePathProviderPlatform extends Fake with MockPlatformInterfaceMixin implements PathProviderPlatform {
  @override
  Future<String?> getApplicationDocumentsPath() async {
    final dir = await getTempDir();
    return dir.path;
  }
}

class MockHiveInterface extends Mock implements HiveInterface {}

class MockHiveBox extends Mock implements Box {}

void main() {
  late HiveInterface mockHiveInterface;
  late Box mockHiveBox;
  late WordsStorage sut;

  setUp(() {
    PathProviderPlatform.instance = FakePathProviderPlatform();
    mockHiveInterface = MockHiveInterface();
    mockHiveBox = MockHiveBox();

    sut = HiveWordsStorage(hive: mockHiveInterface);
  });

  group(HiveWordsStorage, () {
    test('open box catch exception', () async {
      // Arrange
      final key = 'read_box_exception';
      when(() => mockHiveInterface.openBox(any())).thenThrow(Exception());

      // Act
      try {
        await sut.read(key);
      } catch (e) {
        // Assert
        expect(e, isA<WordsStorageException>());
      }
    });

    test('read() must retrieve empty list from key without previews data', () async {
      // Arrange
      final key = 'read_test_empty';
      when(() => mockHiveInterface.openBox(any())).thenAnswer((_) async => mockHiveBox);
      when(() => mockHiveBox.get(key)).thenAnswer((_) async => null);

      // Act
      final data = await sut.read(key);

      // Assert
      expect(data, []);
    });

    test('read() catch exception from box', () async {
      // Arrange
      final key = 'read_exception_test';
      when(() => mockHiveInterface.openBox(any())).thenAnswer((_) async => mockHiveBox);
      when(() => mockHiveBox.get(key)).thenThrow(Exception());

      // Act
      try {
        await sut.read(key);
      } catch (e) {
        // Assert
        expect(e, isA<WordsStorageException>());
      }
    });

    test('put() must storage the valid data in the given key once time', () async {
      // Arrange
      final key = 'put_test';
      // Testando com a instância do hive e verificando a unicidade da persistência
      sut = HiveWordsStorage(hive: Hive);

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

    test('put() catch exception from box', () async {
      // Arrange
      final key = 'put_exception_test';
      when(() => mockHiveInterface.openBox(any())).thenAnswer((_) async => mockHiveBox);
      when(() => mockHiveBox.get(key)).thenThrow(Exception());

      // Act
      try {
        await sut.put(key, 'banana');
      } catch (e) {
        // Assert
        expect(e, isA<WordsStorageException>());
      }
    });

    test('delete() must remove value', () async {
      // Arrange
      final key = 'delete_test';
      // Testando com a instância do hive e verificando a remoção do value
      sut = HiveWordsStorage(hive: Hive);

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

    test('delete() catch exception from box', () async {
      // Arrange
      final key = 'delete_exception_test';
      when(() => mockHiveInterface.openBox(any())).thenAnswer((_) async => mockHiveBox);
      when(() => mockHiveBox.get(key)).thenThrow(Exception());

      // Act
      try {
        await sut.delete(key, 'maça');
      } catch (e) {
        // Assert
        expect(e, isA<WordsStorageException>());
      }
    });
  });
}
