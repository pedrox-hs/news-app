import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as path;

const kDefaultAssetsDir = 'test/fixtures/assets/';
const kDefaultJsonAssetsDir = '$kDefaultAssetsDir/json/';

extension FileX on File {
  static File fromFixtureAssets(
    String file, {
    String assetsDir = kDefaultAssetsDir,
  }) {
    final filename = path.join(assetsDir, file);
    return File(filename);
  }

  static File fromFixtureJson(
    String file, {
    String assetsDir = kDefaultJsonAssetsDir,
  }) => FileX.fromFixtureAssets('$file.json', assetsDir: assetsDir);

  dynamic readAsJson() {
    final content = readAsStringSync();
    return jsonDecode(content);
  }
}