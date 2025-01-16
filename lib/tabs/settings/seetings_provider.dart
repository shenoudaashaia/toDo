import 'package:flutter/material.dart';

class SettingProvider with ChangeNotifier {
  ThemeMode theme = ThemeMode.light;
  bool isDark = false;
  Locale locale=Locale("en");
  bool isEnglish=true;
  
  void changeLanguage() {
    isEnglish=!isEnglish;
    locale=isEnglish ?  Locale("en"): Locale("er");
    notifyListeners();
  }

  void changeThemMode() {
    isDark=!isDark;
    theme=isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }


 
}