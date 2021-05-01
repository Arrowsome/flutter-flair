import 'package:flair_gen/flair_gen.dart';
import 'package:flair/flair.dart';

@resource
const _resPath = 'asset/resources.flair.yaml';

Future<void> initFlair() async {
  Flair.init(path: _resPath);
  Flair.update(theme: 'dracula', lang: 'fr');
}
