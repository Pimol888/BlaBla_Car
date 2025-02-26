import 'package:flutter/material.dart';
import 'package:week3/screens/ride_pref_screen/ride_pref_screen.dart';
import 'theme/theme.dart';

// import 'package:week_3_blabla_project/test/test.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      home: Scaffold(body: RidePrefScreen()),
    );
  }
}