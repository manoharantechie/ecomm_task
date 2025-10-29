import 'package:flutter/material.dart';

enum MyThemeKeys {
  LIGHT,
  DARK,
}

class MyThemes {
  static final ThemeData lightTheme = ThemeData(
      primaryColor: const Color(0xFF000000),
      primaryColorDark: const Color(0xFFEAECEF),
      brightness: Brightness.light,
      disabledColor: const Color(0xFFF7931B),
      dialogBackgroundColor: const Color(0xFF1F1E1E),
      canvasColor: const Color(0xFFFFFFFF),
      primaryColorLight: const Color(0xFF616161),

      cardColor: const Color(0xFFFFFFFF),
      dividerColor: const Color(0xFF616161),
      shadowColor: const Color(0xFFAFAFAF),
      // cursorColor: Color(0xFFFFFFFF),
      splashColor: const Color(0xFFFFFFFF),
      focusColor: const Color(0xFF181A20),
      highlightColor: const Color(0xff1A94AE),
      // errorColor: Color(0xFF5968B1),
      hintColor: const Color(0xFF616161),

      secondaryHeaderColor: const Color(0xFF474D57),
      indicatorColor: const Color(0xFF00CE7D),
      hoverColor: const Color(0xFFFF4A7A),
      unselectedWidgetColor: const Color(0xFF666969),
      scaffoldBackgroundColor: const Color(0xFFF0F8FF),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: Colors.amber,           // blinking cursor
      selectionColor: Colors.amberAccent,  // selected text background
      selectionHandleColor: Colors.amber,  // drag handles
    ),
  );


  static final ThemeData darkTheme = ThemeData(
      primaryColor: const Color(0xFFFFFFFF),
      primaryColorDark: const Color(0xFF000000),
      brightness: Brightness.dark,
      disabledColor: const Color(0xFF676767),
      focusColor: const Color(0xFFffffff),
      dialogBackgroundColor: const Color(0xFF1F1E1E),
      primaryColorLight: const Color(0xFF2C2C2C),
      canvasColor: const Color(0xFF5C5C5C),
      cardColor: const Color(0xFF6B6B6B),
      dividerColor: const Color(0xFF79869B),
      // cursorColor: Color(0xFF0e1839),
      shadowColor: const Color(0xFF828D99),
      secondaryHeaderColor: const Color(0xFF474D57),
      splashColor: const Color(0xFFC8C8C8),
      highlightColor: const Color(0xff1A94AE),
      // errorColor: Color(0xFF5968B1),
      hintColor: const Color(0xFF252432),
      indicatorColor: const Color(0xFF00CE7D),
      hoverColor: const Color(0xFFFF4A7A),
      unselectedWidgetColor: const Color(0xFF3A3A47),
      scaffoldBackgroundColor: const Color(0xFFF0F8FF),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: Colors.amber,           // blinking cursor
      selectionColor: Colors.amberAccent,  // selected text background
      selectionHandleColor: Colors.amber,  // drag handles
    ),
  );

  static ThemeData getThemeFromKey(MyThemeKeys themeKey) {
    switch (themeKey) {
      case MyThemeKeys.LIGHT:
        return lightTheme;
      case MyThemeKeys.DARK:
        return darkTheme;
      default:
        return lightTheme;
    }
  }
}
