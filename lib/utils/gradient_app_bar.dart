import 'package:flutter/material.dart';
import 'app_colors.dart';

class GradientAppBar extends AppBar {
  GradientAppBar({
    Key? key,
    required Widget title,
    List<Widget>? actions,
    PreferredSizeWidget? bottom,
    Widget? leading,
    bool centerTitle = false,
  }) : super(
          key: key,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: title,
          actions: actions,
          leading: leading,
          bottom: bottom,
          centerTitle: centerTitle,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: AppColors.primaryGradient,
              ),
            ),
          ),
        );
} 