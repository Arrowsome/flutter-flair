import 'package:flutter/material.dart';
import 'package:simple/home_screen.dart';

class FaithApp extends StatefulWidget {
  @override
  _FaithAppState createState() => _FaithAppState();
}

class _FaithAppState extends State<FaithApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}
