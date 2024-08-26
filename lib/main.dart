import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:zolup/screens/game_screen.dart';
import 'package:zolup/screens/login_screen.dart';
import 'package:zolup/screens/root_screen.dart';
import 'package:zolup/screens/splash_screen.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

void main() async {
  await initializeDateFormatting();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFEAD4AD),
        sliderTheme: SliderThemeData(),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: const Color(0xFFEAD4AD),
          unselectedItemColor: const Color(0xFF1C1E1F),
          backgroundColor: const Color(0xFFFFFFFF),
        ),
      ),
      initialRoute: '/index',
      routes: {
        '/index': (context) => SplashScreen(),
        '/home': (context) => RootScreen(),
        '/login': (context) => LoginScreen(),
      },
      // home: SplashScreen(),
    ),
  );
}
