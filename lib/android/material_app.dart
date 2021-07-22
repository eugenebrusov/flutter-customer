
import 'package:customer/android/splash_screen.dart';
import 'package:flutter/material.dart' as System;
import 'package:flutter/material.dart';

class MaterialApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return System.MaterialApp(
      title: 'Ebda Android App',
      theme: ThemeData(
        primaryColor: Color(0xFF5DA1A2),
      ),
      home: SplashScreen(),
    );
  }
}