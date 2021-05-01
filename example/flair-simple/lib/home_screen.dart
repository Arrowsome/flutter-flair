import 'package:flair/flair.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'resources.flair.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final String image;
    if (Flair.theme == 'dracula')
      image = 'asset/dark_pic.png';
    else
      image = 'asset/light_pic.png';
    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        title: Text(strings.appName),
        backgroundColor: colors.appBar,
        actions: [
          IconButton(
            icon: Icon(MdiIcons.translate),
            onPressed: _switchLang,
          ),
          IconButton(
            icon: Icon(MdiIcons.themeLightDark),
            onPressed: _switchTheme,
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              image,
              width: 300,
              height: 300,
            ),
            Padding(
              padding: insets.margin8,
              child: Text(
                strings.welcomeMsg,
                style: TextStyle(
                  color: colors.textColor,
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(height: 64),
          ],
        ),
      ),
    );
  }

  void _switchLang() async {
    final lang = Flair.lang;
    switch (lang) {
      case 'en':
        await Flair.update(lang: 'fr');
        break;
      case 'fr':
        await Flair.update(lang: 'en');
        break;
    }
    setState(() {});
  }

  void _switchTheme() async {
    final theme = Flair.theme;
    switch (theme) {
      case 'dracula':
        await Flair.update(theme: 'horizon');
        break;
      case 'horizon':
        await Flair.update(theme: 'dracula');
        break;
    }
    setState(() {});
  }
}
