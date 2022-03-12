import 'package:flutter/material.dart';
import 'package:puninar_absen_test/colors/light_colors.dart';
import 'package:puninar_absen_test/models/absensi_model.dart';

class CardAbsensiWidget extends StatelessWidget {
  Map<String, dynamic> absensiData;
  CardAbsensiWidget({Key? key, required this.absensiData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(20, 5, 20, 0),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: LightColors.white,
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
        child: Column(
          children: [
            Text(
              absensiData['type'] ?? "Type",
              // style: TextStyle(color: LightColors.white),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  absensiData['tanggal'],
                  // style: TextStyle(color: LightColors.white),
                ),
                Text(
                  absensiData['jam'],
                  // style: TextStyle(color: LightColors.white),
                ),
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Latitude",
                  // style: TextStyle(color: LightColors.white),
                ),
                Text(
                  absensiData['lat'],
                  // style: TextStyle(color: LightColors.white),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Longitude",
                  // style: TextStyle(color: LightColors.white),
                ),
                Text(
                  absensiData['long'],
                  // style: TextStyle(color: LightColors.white),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
