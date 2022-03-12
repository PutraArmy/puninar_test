import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:puninar_absen_test/colors/light_colors.dart';
import 'package:puninar_absen_test/screens/home_page.dart';
import 'package:slider_button/slider_button.dart';
// import 'package:slider_button/slider_button.dart';
// import 'package:slider_button/slider_button.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _projectVersion = "";

  String txtLogin = "Login";

  @override
  void initState() {
    super.initState();
    // Timer(Duration(seconds: 3), () {
    //   setState(() {
    //     Get.off(Catalog());
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    // _checkLoginStatus();
    double heightAll = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: heightAll - 150,
            child: Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 100, left: 75, right: 75),
                  child: Center(
                    child: Column(
                      children: [
                        Hero(
                          tag: "login_icon",
                          child: Image.asset(
                            'assets/images/logo.png',
                            scale: 2,
                          ),
                        ),
                        // Text(
                        //   "Tunas - Putra Army",
                        //   style: TextStyle(
                        //       color: LightColors.mainColor,
                        //       fontWeight: FontWeight.w700,
                        //       fontSize: 20),
                        // ),
                      ],
                    ),
                  ),
                ),

                // SlideButton(
                //   height: 64,
                //   borderRadius: 0.0,
                //   backgroundColor: Colors.transparent,
                //   slidingChild: Center(
                //     child: Text("This is a sliding text."),
                //   ),
                //   slidingBarColor: Colors.blue,
                //   slideDirection: SlideDirection.RIGHT,
                // ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: SliderButton(
                      action: () {
                        ///Do something here
                        Get.off(HomePage());
                      },
                      label: Text(
                        "Slide",
                        style: TextStyle(
                            color: Color(0xff4a4a4a),
                            fontWeight: FontWeight.w500,
                            fontSize: 17),
                      ),
                      buttonColor: LightColors.mainColor,
                      icon: Text(
                        ">",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 44,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
