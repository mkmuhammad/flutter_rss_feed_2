import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

class AppTheme {

  static ThemeData appThemeDataLight = ThemeData.light().copyWith(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    primaryColor: mPrimaryColor,
    primaryColorLight: mPrimaryColorLight,
    accentColor: mAccentColor,
    backgroundColor: mBackgroundColor,
    errorColor: mErrorColor,
    textTheme: GoogleFonts.overlockTextTheme(),
  );

}