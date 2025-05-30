import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(ExamStudyApp());
}

class ExamStudyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'مطالعه امتحان جامع',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Vazir',
      ),
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}