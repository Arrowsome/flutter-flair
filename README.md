# Flair

Slick way to manage app resources in your flutter project

## Overview

Flair uses a single YAML file to generate and load resources in your Flutter project. These resources include:

- Strings
- EdgeInsets
- Colors

Also resource variants are supported, meaning you can specify different languages and color palettes. 

**Disclaimer**: This project is not stable enough to be used in enterprise application, use in your small/medium project for now. I'm working to streamline the usage process. If you encounter any bug or have ideas how to enhance this package open an issue.

## Manual

1. Add dependencies:

**Note**: Add `flair` dependency only if you need multi lang/theme support.

```yaml
dependencies:
  flair: ^0.0.1

dev_dependencies:
  flair_gen: ^0.0.1
  build_runner: ^2.0.1
```

2. Create a new YAML file preferably inside `asset` directory.

```
asset
|--resources.flair.yaml
lib
|--app
pubspec.yaml
```

**Note**: If you need multi lang/theme support add this file as as asset in `pubspec.yaml`

```yaml
flutter:
  ...
  assets:
    ...
    - resources.flair.yaml
```

3. Every time you want to build this file first: (optional) delete previously generated file second: run following command in your terminal of choice inside project's root:

```bash
flutter packages pub run build_runner build
```

This generates a new file with resources ready to use inside.

**Note**: If you're supporting multi lang/theme you need to also *Hot Restart*

4. Make a new file under your `lib` directory:

```dart
// resources.dart
@resource
const _resPath = 'asset/resources.flair.yaml';
```

**Note**: If your support multi lang/them:

```
@resource
const _resPath = 'asset/resources.flair.yaml';

void initFlair() {
    Flair.init(resPath);
    // You may use user preferences or device local 
    Flair.update(theme: 'light', lang: 'fr');
}
```

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initFlair();
  runApp(...);
}
```

```dart
// Every time you want to reload new theme or lang
// If you need to update only one of these don't pass any value the other
Flair.update(lang: 'my-lang', theme: 'theme');
```

## YAML structure

No theme/lang

```yaml
colors:
  # RGB
  text: '#000000' 
  # 87 is the opacity percentage (default is 100)
  appBar: '#dedede 87'
# ---
insets:
  # EdgeInsets.all(8)
  margin8: 8
  # EdgeInsets.symmetric(horizontal: 16, vertical: 8)
  marginH16V8: 16-8
  # EdgeInsets.only(left: 8, top: 12, right: 4, bottom: 0)
  marginAppBar: 8-12-4-0
# ---
strings:
  appName: Awesome app
  btnSubmit: Submit
```

Multi lang/theme

```yaml
themes:
  - light
  - dark
langs:
  - en
  - fr
# ---
colors:
  text:
    - '#000000 87' # light
    - '#ffffff 60' # dark
  background:
    - '#eeeeee' # light
    - '#505050' # dark
# ---
strings:
  appName:
    - My Awesome App # en
    - Mon application géniale # fr
  btnSubmit:
    - Submit # en
    - Soumettre # fr
```

## RoadMap

- Adding Divider and SizedBox as resources (soon)
- Adding vscode extension to streamline process (soon)
- Bypassing *Hot Reload* on multi lang/theme support