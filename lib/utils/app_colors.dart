import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF2196F3);
  static const Color secondary = Color(0xFF03A9F4);
  static const Color accent = Color(0xFF00BCD4);
  
  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFF44336);
  static const Color warning = Color(0xFFFFC107);
  static const Color info = Color(0xFF2196F3);

  static const Color background = Color(0xFFF5F5F5);
  static const Color surface = Colors.white;
  static const Color text = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color divider = Color(0xFFBDBDBD);

  // Gradient colors
  static const List<Color> primaryGradient = [
    Color(0xFFE3F2FD), // Colors.blue[50]
    Colors.white,
  ];

  static const List<Color> successGradient = [
    Color(0xFF4CAF50),
    Color(0xFF8BC34A),
  ];

  static const List<Color> errorGradient = [
    Color(0xFFF44336),
    Color(0xFFFF5722),
  ];
} 