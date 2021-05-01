import 'utils.dart';
import 'package:yaml/yaml.dart';
import 'converter.dart';

class YamlConverter extends Converter<YamlMap> {
  final bool constThemes;
  final bool constLangs;

  YamlConverter({this.constThemes = true, this.constLangs = true});

  @override
  String colors(YamlMap input) {
    final sb = StringBuffer();
    if (constThemes) {
      input.forEach((key, value) {
        final tokens = value.toString().split(' ');
        final hex = tokens[0].substring(1).trim();
        var alpha = 'ff';
        if (tokens.length > 1) alpha = Utils.opacToHex(int.parse(tokens[1]));
        sb.writeln('Color get $key => const Color(0x$alpha$hex);');
      });
    } else {
      var i = 0;
      input.keys.forEach((e) {
        sb.writeln('Color get $e => Flair.colors[$i];');
        ++i;
      });
    }
    return sb.toString();
  }

  @override
  String insets(YamlMap input) {
    final sb = StringBuffer();
    input.forEach((key, value) {
      final tokens = value.toString().split('-');
      if (tokens.length == 1) {
        sb.writeln(
            'EdgeInsets get $key => const EdgeInsets.all(${tokens[0]});');
      } else if (tokens.length == 2) {
        sb.writeln(
          'EdgeInsets get $key => const EdgeInsets.symmetric(horizontal: ${tokens[0]}, vertical: ${tokens[1]},);',
        );
      } else if (tokens.length == 4) {
        sb.writeln(
          'EdgeInsets get $key => const EdgeInsets.only(left: ${tokens[0]}, top: ${tokens[1]}, right: ${tokens[2]}, bottom: ${tokens[3]},);',
        );
      }
    });
    return sb.toString();
  }

  @override
  String strings(YamlMap input) {
    final sb = StringBuffer();
    if (constLangs) {
      input.forEach((key, value) {
        sb.writeln('String get $key => \'$value\';');
      });
    } else {
      var i = 0;
      input.keys.forEach((e) {
        sb.writeln('String get $e => Flair.strings[$i];');
        ++i;
      });
    }
    return sb.toString();
  }
}
