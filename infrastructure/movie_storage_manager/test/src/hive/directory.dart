import 'dart:io';
import 'dart:math';

import 'package:path/path.dart' as path;

String tempPath = path.join(
  Directory.current.path,
  '.dart_tool',
  'test',
  'tmp',
);

Future<Directory> getTempDir() async {
  final random = Random();
  final name = random.nextInt(pow(2, 32) as int);
  final dir = Directory(path.join(tempPath, '${name}_tmp'));

  if (await dir.exists()) {
    await dir.delete(recursive: true);
  }

  await dir.create(recursive: true);
  return dir;
}
