import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:puninar_absen_test/screens/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:slider_button/slider_button.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String _projectVersion = "";

  int? id = 0;
  String? token = "";

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          transitionDuration: Duration(seconds: 2),
          pageBuilder: (_, __, ___) => LoginPage(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // _checkLoginStatus();
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Align(
        alignment: Alignment.center,
        child: Container(
          margin: EdgeInsets.all(30),
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          width: width,
          height: height,
          child: Hero(
            tag: "login_icon",
            child: Image.asset(
              'assets/images/logo.png',
              scale: 2,
            ),
          ),
        ),
      ),
    );
  }
}
