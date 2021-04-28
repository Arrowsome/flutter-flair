import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:yaml/yaml.dart';
import 'yaml_converter.dart';
import 'flair_runtime_exc.dart';

class FlairRuntime {
  static final colors = <Color>[];
  static final strings = <String>[];

  static String? _path;
  static String? _currentTheme;
  static String? _currentLang;

  FlairRuntime._internal();

  static void init({required String path}) => _path = path;

  static Future<void> update({String? theme, String? lang}) async {
    if (_path == null) {
      throw FlairRuntimeExc(
        message: 'path-not-found',
        todo: 'Invoke init method with provided path first.',
      );
    }
    final yaml = loadYaml(await rootBundle.loadString(_path!));
    int? themeIndex;
    int? langIndex;
    if (theme != null && _currentTheme != theme) {
      FlairRuntime.colors.clear();
      themeIndex = (yaml['themes'] as YamlList?)?.indexOf(theme);
    }
    if (lang != null && _currentLang != lang) {
      FlairRuntime.strings.clear();
      langIndex = (yaml['langs'] as YamlList?)?.indexOf(lang);
    }

    YamlConverter(themeIndex: themeIndex, langIndex: langIndex).convert(yaml);
  }
}
