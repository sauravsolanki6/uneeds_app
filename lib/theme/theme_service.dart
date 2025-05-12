// import 'package:get_storage/get_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
//
//
// class ThemeServices{
//   final _box = GetStorage();
//   final _key = 'isThemeMode';
//
//   ThemeMode get theme => loadThemeFromBox() ? ThemeMode.dark : ThemeMode.light;
//
//   bool loadThemeFromBox() => _box.read(_key) ?? false;
//   saveThemeToBox(bool isDarkMode) => _box.write(_key, isDarkMode);
//
//
//   void switchTheme() {
//     Get.changeThemeMode(loadThemeFromBox() ? ThemeMode.light : ThemeMode.dark);
//     saveThemeToBox(!loadThemeFromBox());
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

// class ThemeService {
//   final box = GetStorage();
//   final key = 'isThemeMode';
//
//   ThemeMode get theme => loadThemeFromBox() ? ThemeMode.light : ThemeMode.dark;
//
//   bool loadThemeFromBox() => box.read(key) ?? false;
//   saveThemeToBox(bool isDarkMode) => box.write(key, isDarkMode);
//
//   void switchTheme() {
//     Get.changeThemeMode(loadThemeFromBox() ? ThemeMode.light : ThemeMode.dark);
//     saveThemeToBox(!loadThemeFromBox());
//   }
//
// }

// class AppThemes{
//
//   static final light = ThemeData.dark().copyWith(
//     brightness: Brightness.light,
//     backgroundColor: Colors.white,
//     buttonColor: const Color(0xff242529),
//     bottomAppBarColor: Colors.white,
//     colorScheme: ThemeData().colorScheme.copyWith(primary:const Color(0xff17181A)),
//     cardColor: const Color(0xff242529), /// APP BOTTOMNAVIGATION COLOR SET
//     textTheme: const TextTheme(
//         headline1: TextStyle(color: Color(0xff17181A)), /// App Text Theme color set,
//         headline2: TextStyle(color: Color(0xff17181A)) /// APP BAR BACK AND GO BUTTON AND TEXT THEME SET
//     ),
//   );
//
//   static final dark = ThemeData.light().copyWith(
//     brightness: Brightness.dark,
//     backgroundColor: const Color(0xff242529),
//     buttonColor: const Color(0xff2F3541),
//     bottomAppBarColor: const Color(0xff2F3541),
//     colorScheme: ThemeData().colorScheme.copyWith(primary:  const Color(0xff17181A)),
//     cardColor: const Color(0xffFFFFFF), /// APP BOTTOMNAVIGATION COLOR SET
//     textTheme: const TextTheme(
//         headline1: TextStyle(color: Colors.white), /// App Text Theme color set,
//         headline2: TextStyle(color: Colors.white)  /// APP BAR BACK AND GO BUTTON AND TEXT THEME SET
//     ),
//   );
//
//
// }

class ThemeService {
  final _box = GetStorage();
  final _key = 'isThemeMode';

  ThemeMode get theme => _loadThemeFromBox() ? ThemeMode.dark : ThemeMode.light;

  bool _loadThemeFromBox() => _box.read(_key) ?? false;

  _saveThemeToBox(bool isDarkMode) => _box.write(_key, isDarkMode);

  void switchTheme() {
    Get.changeThemeMode(_loadThemeFromBox() ? ThemeMode.light : ThemeMode.dark);
    _saveThemeToBox(!_loadThemeFromBox());
  }
}
