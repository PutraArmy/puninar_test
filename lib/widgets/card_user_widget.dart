import 'package:flutter/material.dart';
import 'package:puninar_absen_test/colors/light_colors.dart';

class CardUserWidget extends StatelessWidget {
  const CardUserWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    final double widthCard = width - 40;
    final double heightCard = widthCard / 1.687;
    return Container(
      width: widthCard,
      height: heightCard,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        image: DecorationImage(
          image: AssetImage("assets/images/bgCard.png"),
          fit: BoxFit.cover,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 1,
            offset: Offset(2, 3), // changes position of shadow
          ),
        ],
      ),
      child: Container(
        margin: EdgeInsets.fromLTRB(28, 15, 28, 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Image.asset(
                    'assets/images/logo.png',
                    width: 150,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Image.asset(
                    'assets/images/barcode.png',
                    width: 70,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Image.asset(
                    'assets/images/profile.png',
                    width: 100,
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Putra Army",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: LightColors.mainColor),
                  ),
                  Text(
                    "Programmer - 1120990249299",
                    style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.w500,
                        color: LightColors.mainColor),
                  ),
                  // Text(
                  //   userDashboard.data?.mot?.nameTransporter ?? "",
                  //   style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
