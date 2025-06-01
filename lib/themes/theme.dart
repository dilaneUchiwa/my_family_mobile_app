import 'package:flutter/material.dart';

class AppColors {
  AppColors._();
  static final primary = Color.fromRGBO(51, 72, 120, 1);
  static final accentColor = Color(0xFFE1EAF8);
  static final blueColor = Color(0xFF2280FF);
  static final blue2 = Color(0xFF004751);
  static final darkBlueColor = Color(0xFF0A2F61);
  static final buttonColor = Color(0xFF425190);
  static final purple = Color(0xFFCABDFF);
  static final green = Color(0xFF60D39C);

  static final cardColorLight = Colors.white;
  static final black = Color(0xFF1D1E25);
  static final black2 = Color(0xFF061423);
  static final fontColorLight = Color.fromARGB(255, 36, 30, 33);
  static final hintColor = Color(0xFF808D9E);
  static final greyColor3 = Color(0xFF7E8CA0);
  static final fontColorDarkTitle = Color(0xFF32353E);
  static final iconColorLight = Color.fromARGB(255, 36, 30, 33);

  static final whiteBackground = Color(0xFFF4F5F7);
  static final white = Colors.white;
  static final lightWhiteBackground = Color.fromARGB(255, 244, 244, 244);
  static final blackBackground = Color.fromARGB(255, 36, 30, 33);
  static final textBlackColor = Color.fromARGB(255, 29, 21, 3);
  static final textBlackColor1 = Color.fromARGB(255, 51, 51, 51);
  static final lightGreyColor = Color.fromARGB(255, 118, 120, 122);
  static final lightGreyColor1 = Color.fromARGB(255, 228, 229, 230);
  static final lightGreyColor2 = Color.fromARGB(255, 118, 118, 118);
  static final lightGreyColor3 = Color.fromARGB(255, 181, 181, 181);
  static final lightGreyColor4 = Color.fromARGB(255, 239, 239, 239);
  static final greyColor = Color.fromARGB(255, 102, 102, 102);
  static final greyColor1 = Color.fromARGB(255, 129, 129, 129);
  static final bottomBarDark = Color(0xFF202833);
  static final borderColor = Color.fromARGB(255, 219, 219, 219);
  static final borderColor1 = Color.fromARGB(255, 227, 227, 227);
  static final dividerColor = Color.fromARGB(255, 236, 236, 236);
  static final backgroundColor = Color.fromARGB(255, 228, 228, 228);
  static final backgroundColor1 = Color.fromARGB(255, 244, 242, 242);
  static final greyColor2 = Color.fromARGB(255, 226, 226, 226);
  static final greyColor4 = Color(0xFFF7F7F7);
  static final greyColor5 = Color(0xFFD9D9D9);
  static final greyColor6 = Color(0xFFD1D1D1);
  static final greyColor7 = Color(0xFFEEEEEE);
  static final yellow = Color(0xFFFECE20);

  static final navTextColor = Color.fromRGBO(118, 120, 122, 1);
}

class Themes {
  static final lightTheme = ThemeData(
    useMaterial3: false,
    brightness: Brightness.light,
    primaryColor: AppColors.primary,
    splashColor: AppColors.primary,
    appBarTheme: AppBarTheme(
      elevation: 0,
      backgroundColor: AppColors.primary,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 16,
      ),
      centerTitle: true,
    ),
    cardColor: AppColors.cardColorLight,
    canvasColor: Color(0xFFFFFFFF),
    scaffoldBackgroundColor: Color(0xFFF9F9F9),
    textSelectionTheme: TextSelectionThemeData(
        selectionColor: AppColors.fontColorLight,
        selectionHandleColor: AppColors.fontColorDarkTitle),
    dividerColor: AppColors.iconColorLight,
    hintColor: AppColors.hintColor,
    fontFamily: "Poppins",
    colorScheme: ThemeData().colorScheme.copyWith(
          secondary: AppColors.primary,
          primary: AppColors.primary,
        ),
    textTheme: TextTheme(
      headlineMedium: TextStyle(
        fontSize: 18,
        fontFamily: "Arial Bold",
        color: AppColors.textBlackColor,
        fontWeight: FontWeight.bold,
      ),
      displaySmall: TextStyle(fontSize: 25, fontFamily: "Poppins Bold"),
      displayLarge: TextStyle(fontSize: 25, fontFamily: "Poppins Medium"),
      displayMedium: TextStyle(fontSize: 30, fontFamily: "Poppins"),
      bodyMedium: TextStyle(
          color: AppColors.black, fontFamily: "Poppins", fontSize: 15),
      bodyLarge: TextStyle(fontSize: 16, fontFamily: "Poppins"),
      titleMedium: TextStyle(fontSize: 16, fontFamily: "Poppins"),
      labelLarge: TextStyle(
        fontSize: 16,
        fontFamily: "Poppins",
        color: Colors.white,
      ),
      labelSmall: TextStyle(fontSize: 10, fontFamily: "Poppins"),
    ),
  );

  static final smallTextStyle =
      TextStyle(color: AppColors.primary, fontSize: 14, fontFamily: 'Poppins');

  static final largeTextStyle = TextStyle(
      color: AppColors.textBlackColor,
      fontSize: 24,
      fontFamily: 'Poppins Bold');

  static final labelStyle = Themes.smallTextStyle.merge(TextStyle(
    color: AppColors.textBlackColor1,
  ));
}
