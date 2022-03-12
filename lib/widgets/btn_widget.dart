import 'package:flutter/material.dart';
import 'package:puninar_absen_test/colors/light_colors.dart';

class BtnWidget extends StatelessWidget {
  String title;
  Color color;
  double width;
  BtnWidget({required this.title, required this.color, required this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: width,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(Radius.circular(40)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 1,
            offset: Offset(2, 3), // changes position of shadow
          ),
        ],
      ),
      child: Align(
        alignment: Alignment.center,
        child: Text(
          title,
          style: TextStyle(color: LightColors.white),
        ),
      ),
    );
  }
}
