import 'dart:ui';
import 'package:flutter/material.dart';

final class AppColor {
  /// this primary color
  static const primaryColor = Color(0xFFB7D422);

  /// this secondary color
  static const secondaryColor = Color(0xFF00F0FF);

  static const Color accentColor = Color(0xFFF709FD);

  static const Color cardColor = Color(0xFFF9FBF7);

  /// this scaffold color
  static const scaffoldBgColor = Color(0xFF3C3C3B);
  static const appBackgroundColor = Color(0xFF3C3C3B);
  static const appBackgroundDarkColor = Color(0xFF333332);

  /// this appbar color
  static const appbarBgColor = Color(0xFF3C3C3B);

  /// button color primary
  static const Color buttonPrimaryColor = Color(0xFFFF3000);

  /// button color secondary
  static const Color buttonSecondaryColor = Color(0xff4a4a4a);

  /*********  Put All Text Colors in this region only **********/

  /// text color
  static const Color textColor = Color(0xFFFFFFFF);

  /// text dark color
  static const Color textDarkColor = Color(0xFF3C3C3B);

  /// text hint color
  static const Color textHintColor = Color(0xFFD9D9D9);

  static const Color textFieldSecondaryColor = Color(0x40FFFFFF);
  static const Color textFieldColor = Color(0xFFEFEFEF);

  static const Color textTertiary = Color(0xFF2C2C2B);
  static const Color placeholderColor = Color(0xCC3C3C3B);
  static const Color errorColor = Color(0xFFFE0257);
  static const Color colorHint = Color(0xff9FA2AA);

  /// ****************

  static const Color springGreenColor = Color(0xFF00FBB0);
  static const Color greyColor = Color(0xFFC2C2C2);
  static const Color dividerColor = Color(0xFF898E95);
  static const Color lightSky = Color(0xff00F0FF);
  static const Color iconColorPrimary = Color(0xffffffff);
  static const Color white = Color(0xFFFFFFFF);
  static const Color blackColor = Color(0xFF2C2C2B);
  static const Color whiteShade2 = Color(0xFFF2F2F2);
  static const Color purple = Color(0xFFFF00FF);
  static const Color buttonTertiaryColor = Color(0xff000000);
  static const Color transparent = Colors.transparent;
  static const Color electricVioletColor = Color(0xff9500FE);
  static const Color redColor = Color(0xFFFF3000);
  static const Color offWhite = Color(0xFFD9D9D9);
  static const Color blackDialog = Color(0xE53C3C3B);
  static const Color whiteShade = Color(0xFFD9D9D9);
  static const Color greenColor = Color(0xFF4AE96D);
  static const Color blueColor = Color(0xff3000FF);
  static const Color yellow = Color(0xFFEFE604);
  static const Color greyColor1 = Color(0xFF3E4C59);
  static const Color greyColor2 = Color(0xFFCBD2D9);
  static const Color textSecondaryLight = Color(0xFFD9D9D9);

  static MaterialColor from(Color color) {
    return MaterialColor(color.value, <int, Color>{
      50: color.withOpacity(0.1),
      100: color.withOpacity(0.2),
      200: color.withOpacity(0.3),
      300: color.withOpacity(0.4),
      400: color.withOpacity(0.5),
      500: color.withOpacity(0.6),
      600: color.withOpacity(0.7),
      700: color.withOpacity(0.8),
      800: color.withOpacity(0.9),
      900: color.withOpacity(1.0),
    });
  }
}
