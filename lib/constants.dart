import 'package:flutter/material.dart';

// setting the color pallette for the app
const Color kPrimaryColor = Color.fromRGBO(6, 82, 44, 1);
const Color kSecondaryColor = Color.fromRGBO(203, 253, 207, 1);
const Color kAccentColor = Color.fromRGBO(59, 151, 78, 1);
//dark colors
const Color kDarkPrimaryColor = Color.fromRGBO(115, 241, 144, 1);
const Color kDarkSecondaryColor = Color.fromRGBO(23, 24, 27, 1);

//text color (deben modificarse)
const Color kLightText = Color.fromRGBO(30, 30, 34, 1);
const Color kDarkText = Color.fromRGBO(255, 255, 255, 1);

//background color (deben modificarse)
const Color kLightBackground = Color.fromRGBO(255, 255, 255, 1);
const Color kDarkBackground = Color.fromRGBO(30, 30, 34, 1);

const double kDefaultPadding = 20.0;

const kBoldFontWeight = TextStyle(
  fontWeight: FontWeight.w700,
  fontSize: 30.0,
  color: kLightText,
);

class AppTheme {
  AppTheme._();
  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: kLightBackground,
    fontFamily: 'Roboto',
    colorScheme: const ColorScheme.light(
        primary: kPrimaryColor,
        secondary: kSecondaryColor,
        tertiary: kAccentColor,
        background: kLightBackground,
        onPrimary: kDarkBackground, //para el texto
        onPrimaryContainer: kLightBackground,
        onBackground: kLightBackground),
  );

  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: kDarkBackground,
    fontFamily: 'Roboto',
    colorScheme: const ColorScheme.dark(
        primary: kDarkPrimaryColor,
        secondary: kDarkSecondaryColor,
        tertiary: kAccentColor,
        background: kDarkBackground,
        onPrimary: kLightBackground, //para el texto
        onPrimaryContainer: kDarkSecondaryColor,
        onBackground: kDarkSecondaryColor),
  );
}
