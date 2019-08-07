import 'package:flutter/material.dart';
import 'package:golsat_flutter_poc_app/src/ui/home.page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PoC Golsat Flutter App',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
