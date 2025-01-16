import 'package:flutter/material.dart';

class Appthem {
  static const primary = Color(0xff5D9CEC);
  static const backgroundLight = Color(0xffDFECDB);
  static const backgroundDark = Color(0xff060E1E);
  static const white = Color(0xffFFFFFF);
  static const grey = Color(0xff141922);
  static const black = Color(0xff000000);
  // static const grey = Color(0xffC8C9CB);
  static const red = Color(0xffEC4B4B);
  static const green = Color(0xff61E757);

  static ThemeData lightTheme = ThemeData(
    primaryColor: white,
    appBarTheme: AppBarTheme(
      centerTitle: true,
      backgroundColor: Colors.transparent,
    ),
    scaffoldBackgroundColor: backgroundLight,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: white,
      selectedItemColor: primary,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      elevation: 0,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primary,
      foregroundColor: white,
      shape: CircleBorder(
        side: BorderSide(
          color: white,
          width: 4,
        ),
      ),
    ),
    textTheme: TextTheme(
      titleMedium: TextStyle(
        fontSize: 18,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
      titleSmall: TextStyle(
        fontSize: 14,
        color: Colors.black,
        fontWeight: FontWeight.w400,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primary,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: Appthem.primary,
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    primaryColor: grey,

    appBarTheme: AppBarTheme(
      centerTitle: true,
      backgroundColor: Colors.transparent,
    ),
    
    scaffoldBackgroundColor: backgroundDark,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: grey,
      selectedItemColor: primary,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      elevation: 0,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primary,
      foregroundColor: white,
      shape: CircleBorder(
        side: BorderSide(
          color: white,
          width: 4,
        ),
      ),
    ),
    textTheme: TextTheme(
      titleMedium: TextStyle(
        fontSize: 18,
        color: white,
        fontWeight: FontWeight.bold,
      ),
      titleSmall: TextStyle(
        fontSize: 14,
        color: white,
        fontWeight: FontWeight.w400,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primary,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: Appthem.primary,
      ),
      
    ),
    
    );
}
