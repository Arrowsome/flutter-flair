import 'dart:io';

import 'package:build/src/builder/build_step.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:source_gen/source_gen.dart';
import 'package:yaml/yaml.dart';
import 'yaml_converter.dart';

import 'resource.dart';

class FlairsGenerator extends GeneratorForAnnotation<Resource> {
  @override
  generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    final path = (element as TopLevelVariableElement)
        .computeConstantValue()!
        .toStringValue()!;
    final yaml = loadYaml(File(path).readAsStringSync());
    final hasThemes = yaml['themes'] != null;
    final hasLangs = yaml['langs'] != null;
    final converter = YamlConverter(
      constThemes: !hasThemes,
      constLangs: !hasLangs,
    );

    String? colors;
    if (yaml['colors'] != null) {
      colors = converter.colors(yaml['colors']);
    }

    String? insets;
    if (yaml['insets'] != null) {
      insets = converter.insets(yaml['insets']);
    }

    String? strings;
    if (yaml['strings'] != null) {
      strings = converter.strings(yaml['strings']);
    }

    final sb = StringBuffer();
    sb.writeln('import \'package:flutter/widgets.dart\';');
    if (hasThemes || hasLangs)
      sb.writeln('import \'package:flair/flair.dart\';');

    sb.writeln('class _Colors {');
    sb.writeln('const _Colors();');
    if (colors != null) sb.writeln(colors);
    sb.writeln('}');

    sb.writeln('class _Insets {');
    sb.writeln('const _Insets();');
    if (insets != null) sb.writeln(insets);
    sb.writeln('}');

    sb.writeln('class _Strings {');
    sb.writeln('const _Strings();');
    if (strings != null) sb.writeln(strings);
    sb.writeln('}');

    sb.writeAll([
      'const colors = _Colors();',
      'const insets = _Insets();',
      'const strings = _Strings();',
    ], '\n');
    return sb.toString();
  }
}
