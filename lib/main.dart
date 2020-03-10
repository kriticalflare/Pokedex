import 'package:flutter/material.dart';
import 'package:poke_dex/screens/detail_page.dart';
import 'screens/home_page.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

