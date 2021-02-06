import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Style {
  static ThemeData get(bool isDark) {
    Color backgroundColor = isDark ? Colors.black : Colors.white;
    Color foregroundColor = isDark ? Colors.white : Colors.black;
    return ThemeData(
      brightness: isDark ? Brightness.dark : Brightness.light,
      backgroundColor: backgroundColor,
      canvasColor: backgroundColor,
      textSelectionColor: isDark ? Colors.white12 : Colors.grey.shade300,
      primaryColor: Color(0xFF249991),
      accentColor: Color(0xFF249991),
      appBarTheme: AppBarTheme(
          textTheme: TextTheme(
            headline6: TextStyle(
              color: foregroundColor,
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          color: backgroundColor,
          elevation: 0,
          iconTheme: IconThemeData(color: foregroundColor)),
      textTheme: TextTheme(
        headline4:
            TextStyle(color: foregroundColor, fontWeight: FontWeight.bold),
        bodyText1: TextStyle(
          color: foregroundColor,
          fontWeight: FontWeight.bold,
          fontSize: 18.0,
          fontFamily: 'Roboto',
        ),
      ),
    );
  }
}

class StorageManager {
  static void saveData(String key, dynamic value) async {
    final prefs = await SharedPreferences.getInstance();
    if (value is int) {
      prefs.setInt(key, value);
    } else if (value is String) {
      prefs.setString(key, value);
    } else if (value is bool) {
      prefs.setBool(key, value);
    } else {
      print("Invalid Type");
    }
  }

  static Future<dynamic> readData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    dynamic obj = prefs.get(key);
    return obj;
  }

  static Future<bool> deleteData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.remove(key);
  }
}

// class ThemeNotifier with ChangeNotifier {
//   final darkTheme = ThemeData(
//     primarySwatch: Colors.grey,
//     primaryColor: Colors.black,
//     brightness: Brightness.dark,
//     backgroundColor: const Color(0xFF212121),
//     accentColor: Colors.white,
//     accentIconTheme: IconThemeData(color: Colors.black),
//     dividerColor: Colors.black12,
//   );

//   final lightTheme = ThemeData(
//     primarySwatch: Colors.grey,
//     primaryColor: Colors.white,
//     brightness: Brightness.light,
//     backgroundColor: const Color(0xFFE5E5E5),
//     accentColor: Colors.black,
//     accentIconTheme: IconThemeData(color: Colors.white),
//     dividerColor: Colors.white54,
//   );

//   ThemeData _themeData;

//   ThemeNotifier() {
//     StorageManager.readData('themeMode').then((value) {
//       print('value read from storage: ' + value.toString());
//       var themeMode = value ?? 'light';
//       if (themeMode == 'light') {
//         _themeData = lightTheme;
//       } else {
//         print('setting dark theme');
//         _themeData = darkTheme;
//       }
//       notifyListeners();
//     });
//   }

//   void setDarkMode() async {
//     _themeData = darkTheme;
//     StorageManager.saveData('themeMode', 'dark');
//     notifyListeners();
//   }

//   void setLightMode() async {
//     _themeData = lightTheme;
//     StorageManager.saveData('themeMode', 'light');
//     notifyListeners();
//   }
// }
