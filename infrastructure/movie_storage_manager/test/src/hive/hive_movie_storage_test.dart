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
        expect(e, isA<MovieStorageException>());
      }
    });
  });
}
