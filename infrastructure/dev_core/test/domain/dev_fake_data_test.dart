import 'package:dev_core/domain/dev_fake_data.dart';
import 'package:dev_core/domain/dev_fake_data_interface.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late FakeDataContract fakeData;

  setUp(() {
    fakeData = FakeData();
  });

  group('fake data test', () {
    test('fake data string', () {
      expect(fakeData.fakeData(), equals('fake data'));
    });
  });
}
