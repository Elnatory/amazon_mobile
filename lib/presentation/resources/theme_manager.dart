import 'package:amazon_mobile/presentation/resources/color_manager.dart';
import 'package:flutter/material.dart';

ThemeData getThemData() {
  return ThemeData(
    primaryColor: ColorManager.primary,
    appBarTheme: const AppBarTheme(
      backgroundColor: ColorManager.sub,
      elevation: 0.0,
    ),
    textTheme: const TextTheme(
      bodyText1: TextStyle(
        color: ColorManager.text,
      ),
    ),
  );
}