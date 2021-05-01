import 'package:flutter/widgets.dart';
import 'package:simple/resources.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initFlair();
  runApp(FaithApp());
}
