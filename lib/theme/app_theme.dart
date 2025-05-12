import 'package:flutter/material.dart';

class Themes {
  static final light = ThemeData.light().copyWith(
    brightness: Brightness.light,
    cardColor: const Color(0xffF0F0F2),
    unselectedWidgetColor: const Color(0xff3E3E3E),
  );

  static final dark = ThemeData.dark().copyWith(
    brightness: Brightness.dark,
    cardColor: const Color(0xff090C0B),
    unselectedWidgetColor: const Color(0xffFFFFFF),
  );
}
