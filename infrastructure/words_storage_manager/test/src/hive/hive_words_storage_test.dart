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
  });
}
