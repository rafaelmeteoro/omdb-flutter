import 'package:dev_core/dev_core.dart';
import 'package:movie_storage_manager/movie_storage_manager.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

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
  late MovieStorage sut;

  setUp(() {
    PathProviderPlatform.instance = FakePathProviderPlatform();
    mockHiveInterface = MockHiveInterface();
    mockHiveBox = MockHiveBox();

    sut = HiveMovieStorage(hive: mockHiveInterface);
  });

  group(HiveMovieStorage, () {
    test('open box catch exception', () async {
      // Arrange
      final key = 'read_box_exception';
      when(() => mockHiveInterface.openBox(any())).thenThrow(Exception());

      // Act
      try {
        await sut.read(key);
      } catch (e) {
        // Assert
        expect(e, isA<MovieStorageException>());
      }
    });

    test('readAll() must retrieve empty list', () async {
      // Arrange
      sut = HiveMovieStorage(hive: Hive);

      // Act
      final data = await sut.readAll();

      // Assert
      expect(data, []);
    });

    test('readAll() must retrieve list after insert', () async {
      // Arrange
      // Testando com a instância do hive e verificando a persistência
      sut = HiveMovieStorage(hive: Hive);

      // Act
      await sut.put('movie1', {'title': 'movie1'});
      await sut.put('movie2', {'title': 'movie2'});
      await sut.put('movie3', {'title': 'movie3'});
      final data = await sut.readAll();

      // Assert
      expect(data, [
        {'title': 'movie1'},
        {'title': 'movie2'},
        {'title': 'movie3'},
      ]);
    });

    test('readAll() catch exception from box', () async {
      // Arrange
      final key = 'readall_exception_test';
      when(() => mockHiveInterface.openBox(any())).thenAnswer((_) async => mockHiveBox);
      when(() => mockHiveBox.get(key)).thenThrow(Exception());

      // Act
      try {
        await sut.readAll();
      } catch (e) {
        // Assert
        expect(e, isA<MovieStorageException>());
      }
    });

    test('read() must retrieve empty data from key without previews data', () async {
      // Arrange
      final key = 'read_test_empty';
      when(() => mockHiveInterface.openBox(any())).thenAnswer((_) async => mockHiveBox);
      when(() => mockHiveBox.get(key)).thenAnswer((_) async => null);

      // Act
      final data = await sut.read(key);

      // Assert
      expect(data, {});
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
        expect(e, isA<MovieStorageException>());
      }
    });

    test('put() must storage the valid data in the given key', () async {
      // Arrange
      // Testando com a instância do hive e verificando a persistência
      sut = HiveMovieStorage(hive: Hive);

      // Act
      final movie1 = await sut.put('movie1', {'title': 'movie1'});
      final movie2 = await sut.put('movie2', {'title': 'movie2'});
      final data1 = await sut.read('movie1');
      final data2 = await sut.read('movie2');

      // Assert
      expect(movie1, isA<Unit>());
      expect(movie2, isA<Unit>());
      expect(data1, {'title': 'movie1'});
      expect(data2, {'title': 'movie2'});
    });

    test('put() catch exception from box', () async {
      // Arrange
      final key = 'put_exception_test';
      when(() => mockHiveInterface.openBox(any())).thenAnswer((_) async => mockHiveBox);
      when(() => mockHiveBox.get(key)).thenThrow(Exception());

      // Act
      try {
        await sut.put(key, {});
      } catch (e) {
        // Assert
        expect(e, isA<MovieStorageException>());
      }
    });

    test('delete() must remove value', () async {
      // Arrange
      // Testando com a instância do hive e verificando a persistência
      sut = HiveMovieStorage(hive: Hive);

      // Act
      await sut.put('movie1', {'title': 'movie1'});
      await sut.put('movie2', {'title': 'movie2'});
      await sut.put('movie3', {'title': 'movie3'});

      final result = await sut.delete('movie2');
      final data1 = await sut.read('movie1');
      final data2 = await sut.read('movie2');
      final data3 = await sut.read('movie3');

      // Assert
      expect(result, isA<Unit>());
      expect(data1, {'title': 'movie1'});
      expect(data2, {});
      expect(data3, {'title': 'movie3'});
    });

    test('delete() catch exception from box', () async {
      // Arrange
      final key = 'delete_exception_test';
      when(() => mockHiveInterface.openBox(any())).thenAnswer((_) async => mockHiveBox);
      when(() => mockHiveBox.delete(key)).thenThrow(Exception());

      // Act
      try {
        await sut.delete(key);
      } catch (e) {
        // Assert
        expect(e, isA<MovieStorageException>());
      }
    });

    test('contains() return true if the given key exist', () async {
      // Arrange
      final key = 'contains_test';
      sut = HiveMovieStorage(hive: Hive);

      // Act
      await sut.put(key, {'title': 'movie'});
      final result = await sut.containsKey(key);

      // Assert
      expect(result, true);
    });

    test('contains() return false if the given key do not exist', () async {
      // Arrange
      final key = 'contains_false_test';
      sut = HiveMovieStorage(hive: Hive);

      // Act
      final result = await sut.containsKey(key);

      // Assert
      expect(result, false);
    });

    test('contains() catch exception from box', () async {
      // Arrange
      final key = 'contains_exception_test';
      when(() => mockHiveInterface.openBox(any())).thenAnswer((_) async => mockHiveBox);
      when(() => mockHiveBox.containsKey(key)).thenThrow(Exception());

      // Act
      try {
        await sut.containsKey(key);
      } catch (e) {
        // Assert
        expect(e, isA<MovieStorageException>());
      }
    });
  });
}
