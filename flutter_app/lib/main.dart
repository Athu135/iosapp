import 'package:flutter/material.dart';
import 'package:flutter_app/views/home.dart';
import 'package:flutter_app/welcomescreen/WelcomeScreen.dart';

import 'loginscreen/SignIn.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Wallpaper hub',
      theme: ThemeData(
          primaryColor: Color(0xff15191c),
      ),
      home: WelcomeScreen(),
    );
  }
}
