import 'utils.dart';
import 'package:yaml/yaml.dart';
import 'converter.dart';

class YamlConverter extends Converter<YamlMap> {
  final bool constThemes;
  final bool constLangs;
  final StringBuffer sb;

  YamlConverter({this.constThemes = true, this.constLangs = true})
      : sb = StringBuffer();

  void _colors(YamlMap input) {
    if (constThemes) {
      input.forEach((key, value) {
        final tokens = value.toString().split(' ');
        final hex = tokens[0].substring(1).trim();
        var alpha = 'ff';
        if (tokens.length > 1) alpha = Utils.opacToHex(int.parse(tokens[1]));
        sb.writeln('static Color get $key => const Color(0x$alpha$hex);');
      });
    } else {
      var i = 0;
      input.keys.forEach((e) {
        sb.writeln('static Color get $e => FlairRepo.colors[$i];');
        ++i;
      });
    }
  }

  void _insets(YamlMap input) {
    input.forEach((key, value) {
      if (value is int) {
        sb.writeln('static get $key => const EdgeInsets.all($value);');
      } else if (value is String) {
        final tokens = value.split('-');
        if (tokens.length == 2) {
          sb.writeln(
            'static EdgeInsets get $key => const EdgeInsets.symmetric(horizontal: ${tokens[0]}, vertical: ${tokens[1]},);',
          );
        } else if (tokens.length == 4) {
          sb.writeln(
            'static EdgeInsets get $key => const EdgeInsets.only(left: ${tokens[0]}, top: ${tokens[1]}, right: ${tokens[2]}, bottom: ${tokens[3]},);',
          );
        }
      }
    });
  }

  void _strings(YamlMap input) {
    if (constLangs) {
      input.forEach((key, value) {
        sb.writeln('static String get $key => $value;');
      });
    } else {
      var i = 0;
      input.keys.forEach((e) {
        sb.writeln('static String get $e => FlairRepo.color[$i];');
        ++i;
      });
    }
  }

  @override
  String convert(YamlMap input) {
    _colors(input['colors']);
    _insets(input['insets']);
    _strings(input['strings']);
    return sb.toString();
  }
}
