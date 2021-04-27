import 'package:source_gen/source_gen.dart';
import 'package:build/build.dart';
import 'generator.dart';

Builder resourceBuilder(BuilderOptions options) => LibraryBuilder(
      FlairsGenerator(),
      generatedExtension: '.flairs.dart',
    );
