import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF667eea);
  static const Color secondary = Color(0xFF764ba2);
  
  // Topic Colors
  static const Color searchEngine = Color(0xFF667eea);
  static const Color eMarketing = Color(0xFF4ECDC4);
  static const Color benefits = Color(0xFF2ecc71);
  static const Color growth = Color(0xFFf39c12);
  static const Color webDesign = Color(0xFF9b59b6);
  static const Color quiz = Color(0xFFe74c3c);
  
  // Status Colors
  static const Color success = Color(0xFF27ae60);
  static const Color warning = Color(0xFFf39c12);
  static const Color danger = Color(0xFFe74c3c);
  static const Color info = Color(0xFF3498db);
  static const Color dark = Color(0xFF2c3e50);
  static const Color light = Color(0xFFecf0f1);
}

class AppStyles {
  static const TextStyle heading = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.dark,
  );
  
  static const TextStyle subheading = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: AppColors.dark,
  );
  
  static const TextStyle body = TextStyle(
    fontSize: 16,
    color: AppColors.dark,
    height: 1.6,
  );

  static const TextStyle caption = TextStyle(
    fontSize: 14,
    color: Colors.grey,
  );
} 