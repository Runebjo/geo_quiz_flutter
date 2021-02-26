import 'package:flutter/material.dart';
import 'screens/continents_screen.dart';
import 'screens/question_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Geo Quiz',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ContinentsScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
