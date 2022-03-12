import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:puninar_absen_test/colors/light_colors.dart';
import 'package:puninar_absen_test/database/db_helper.dart';
import 'package:puninar_absen_test/models/absensi_model.dart';
import 'package:puninar_absen_test/screens/home_page.dart';
import 'package:puninar_absen_test/utils/usable.dart';
import 'package:puninar_absen_test/widgets/btn_widget.dart';

class DisplayPictureScreen extends StatefulWidget {
  final String imagePath;
  final Absensi absensiData;

  const DisplayPictureScreen(
      {Key? key, required this.imagePath, required this.absensiData})
      : super(key: key);

  @override
  State<DisplayPictureScreen> createState() => _DisplayPictureScreenState();
}

class _DisplayPictureScreenState extends State<DisplayPictureScreen> {
  void _refreshData() async {
    final data = await DBHelper.getAbsensi();
    setState(() {});
  }

  Absensi dataAbsensi = Absensi();

  void _buildArrayFromat() {
    dataAbsensi = widget.absensiData;
    dataAbsensi.photo = widget.imagePath;
    String body = absensiToJson(dataAbsensi);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Display the Picture')),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: ListView(
        children: [
          Image.file(File(widget.imagePath)),
          SizedBox(
            height: 10,
          ),
          InkWell(
              onTap: () async {
                await tambahAbsensi();

                AwesomeDialog(
                  context: context,
                  dialogType: DialogType.SUCCES,
                  animType: AnimType.TOPSLIDE,
                  title: 'Success',
                  // desc: 'Dialog description here.............',
                  // btnCancelOnPress: () {},
                  btnOkOnPress: () {
                    Get.offAll(HomePage());
                  },
                )..show();
              },
              child: BtnWidget(
                  title: dataAbsensi.type ?? "Upload",
                  color: LightColors.mainColor,
                  width: 100))
        ],
      ),
    );
  }

  Future<void> tambahAbsensi() async {
    _buildArrayFromat();
    await DBHelper.tambahAbsensi(dataAbsensi);
    if (dataAbsensi.type == "Check In") {
      setCheckin(true);
    } else {
      setCheckin(false);
    }
  }
}
