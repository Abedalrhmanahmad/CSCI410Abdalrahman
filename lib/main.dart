import 'package:flutter/material.dart';
import 'home.dart';

void main() {
  runApp(const OnlineLearningApp());
}

class OnlineLearningApp extends StatelessWidget {
  const OnlineLearningApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Online Learning',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomeScreen(),
    );
  }
}
