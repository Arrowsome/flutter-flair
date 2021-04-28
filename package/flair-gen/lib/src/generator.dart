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
    final path = annotation.peek('path')!.stringValue;
    final yaml = loadYaml(File(path).readAsStringSync());
    final hasThemes = yaml['themes'] != null;
    final hasLangs = yaml['langs'] != null;
    final outcome = YamlConverter(
      constThemes: !hasThemes,
      constLangs: !hasLangs,
    ).convert(yaml);
    final sb = StringBuffer();
    sb.writeln('import \'package:flutter/widgets.dart\';');
    if (hasThemes || hasLangs)
      sb.writeln('import \'package:flair_runtime/flair_runtime.dart\';');
    sb.writeln('class Flairs {');
    sb.writeln('Flairs._internal();');
    sb.writeln(outcome);
    sb.writeln('}');
    return sb.toString();
  }
}
