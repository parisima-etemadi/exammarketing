import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(ExamStudyApp());
}

class ExamStudyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'مطالعه امتحان جامع',
      
      // RTL Configuration
      locale: Locale('fa', 'IR'), // Persian Iran locale
      supportedLocales: [
        Locale('fa', 'IR'), // Persian
        Locale('en', 'US'), // English (fallback)
      ],
      
      // Add localization delegates
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      
      // Builder to wrap the entire app with Directionality
      builder: (context, child) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: child!,
        );
      },
      
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Vazir',
        // Ensure RTL text direction for the theme
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}