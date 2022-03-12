import 'package:flutter/material.dart';
import 'package:puninar_absen_test/colors/light_colors.dart';
import 'package:puninar_absen_test/models/absensi_model.dart';

class CardAbsensiWidget extends StatelessWidget {
  String address;
  CardAbsensiWidget({Key? key, required this.address}) : super(key: key);

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
        child: Text(address));
  }
}
