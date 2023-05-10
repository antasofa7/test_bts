import 'package:flutter/material.dart';

const FontWeight light = FontWeight.w300;
const FontWeight regular = FontWeight.w400;
const FontWeight medium = FontWeight.w500;
const FontWeight semiBold = FontWeight.w600;
const FontWeight bold = FontWeight.w700;

const Color primaryColor = Color(0xff247881);
const Color primaryVariant1 = Color(0xffBDD7D9);
const Color secondaryColor = Color(0xff21BDC6);
const Color neutral100 = Colors.white;
const Color neutral200 = Color(0xffF7F6F6);
const Color neutral300 = Color(0xffD4D3D3);
const Color neutral500 = Color(0xffBDBDBD);
const Color neutral900 = Color(0xff0C0D0E);
const Color danger = Color(0xffCB3A31);

final themeData = ThemeData(
    primaryColor: primaryColor,
    colorScheme: const ColorScheme.light(
        primary: primaryColor,
        primaryContainer: primaryVariant1,
        secondary: secondaryColor,
        background: neutral100,
        onPrimaryContainer: neutral900,
        outline: neutral900,
        error: danger),
    textTheme: const TextTheme(
      headlineLarge:
          TextStyle(fontFamily: 'Inter', fontWeight: bold, color: primaryColor),
      headlineMedium:
          TextStyle(fontFamily: 'Inter', fontWeight: bold, color: primaryColor),
      headlineSmall: TextStyle(
          fontFamily: 'Inter', fontWeight: semiBold, color: primaryColor),
      titleSmall: TextStyle(
          fontFamily: 'Inter', fontWeight: semiBold, color: primaryColor),
      bodyLarge: TextStyle(
          fontFamily: 'Inter', fontWeight: semiBold, color: neutral100),
      bodyMedium: TextStyle(
          fontFamily: 'Inter', fontWeight: regular, color: neutral900),
      labelLarge: TextStyle(
          fontFamily: 'Inter', fontWeight: medium, color: primaryColor),
      labelMedium: TextStyle(
          fontFamily: 'Inter', fontWeight: regular, color: primaryColor),
      labelSmall:
          TextStyle(fontFamily: 'Inter', fontWeight: regular, color: danger),
    ));
