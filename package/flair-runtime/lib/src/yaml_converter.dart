import 'dart:convert';

import 'package:yaml/yaml.dart';
import 'flair_runtime.dart';
import 'utils.dart';

import 'converter.dart';
import 'package:flutter/widgets.dart';

class YamlConverter extends Converter<YamlMap> {
  final int? themeIndex;
  final int? langIndex;

  YamlConverter({
    required this.themeIndex,
    required this.langIndex,
  });

  @override
  void convert(YamlMap input) {
    if (themeIndex != null) _colors(input['colors']);
    if (langIndex != null) _strings(input['strings']);
  }

  void _colors(YamlMap input) {
    input.values.forEach((e) {
      final tokens = e[themeIndex].toString().split(' ');
      final hue = tokens[0].substring(1).trim();
      var alpha = 'ff';
      if (tokens.length > 1) {
        alpha = Utils.opacToHex(int.parse(tokens[1]));
      }
      FlairRuntime.colors.add(Color(int.parse('0x$alpha$hue')));
    });
  }

  void _strings(YamlMap input) {
    input.values.forEach((e) {
      FlairRuntime.strings.add(e[langIndex]);
    });
  }
}
