import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:puninar_absen_test/colors/light_colors.dart';
import 'package:puninar_absen_test/main.dart';
import 'package:puninar_absen_test/models/absensi_model.dart';
import 'package:puninar_absen_test/screens/camera_preview_page.dart';
import 'dart:io';

import 'package:puninar_absen_test/widgets/btn_widget.dart';

class CameraPage extends StatefulWidget {
  Absensi absensiData = Absensi();
  CameraPage({Key? key, required this.absensiData}) : super(key: key);

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late CameraController controller;
  late Future<void> initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    controller = CameraController(cameras[1], ResolutionPreset.medium);
    initializeControllerFuture = controller.initialize();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<void>(
        future: initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the Future is complete, display the preview.
            return CameraPreview(controller);
          } else {
            // Otherwise, display a loading indicator.
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: Align(
          alignment: Alignment.bottomCenter,
          child: InkWell(
            onTap: () async {
              try {
                // Ensure that the camera is initialized.
                await initializeControllerFuture;

                // Attempt to take a picture and get the file `image`
                // where it was saved.
                final image = await controller.takePicture();

                await Get.to(
                  DisplayPictureScreen(
                    imagePath: image.path,
                    absensiData: widget.absensiData,
                  ),
                );
              } catch (e) {
                // If an error occurs, log the error to the console.
                print(e);
              }
            },
            child: BtnWidget(
                title: "Take Photo", color: LightColors.mainColor, width: 200),
          )
          // FloatingActionButton(
          //   // Provide an onPressed callback.
          //   onPressed: () async {
          //     // Take the Picture in a try / catch block. If anything goes wrong,
          //     // catch the error.
          //     try {
          //       // Ensure that the camera is initialized.
          //       await initializeControllerFuture;

          //       // Attempt to take a picture and get the file `image`
          //       // where it was saved.
          //       final image = await controller.takePicture();

          //       // If the picture was taken, display it on a new screen.
          //       await Navigator.of(context).push(
          //         MaterialPageRoute(
          //           builder: (context) => DisplayPictureScreen(
          //             // Pass the automatically generated path to
          //             // the DisplayPictureScreen widget.
          //             imagePath: image.path,
          //           ),
          //         ),
          //       );
          //     } catch (e) {
          //       // If an error occurs, log the error to the console.
          //       print(e);
          //     }
          //   },
          //   child: const Icon(Icons.camera_alt),
          // ),
          ),
    );
  }
}
