import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:puninar_absen_test/colors/light_colors.dart';
import 'package:puninar_absen_test/models/absensi_model.dart';
import 'package:puninar_absen_test/screens/camera_page.dart';
import 'package:puninar_absen_test/widgets/btn_widget.dart';
import 'package:intl/intl.dart';
import 'package:geocoder/geocoder.dart';

class AbsensiPage extends StatefulWidget {
  const AbsensiPage({Key? key}) : super(key: key);

  @override
  State<AbsensiPage> createState() => _AbsensiPageState();
}

class _AbsensiPageState extends State<AbsensiPage> {
  Completer<GoogleMapController> _controller = Completer();
  late BitmapDescriptor pinLocationIcon;
  Set<Marker> _markers = {};

  final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(double.parse(Get.arguments[1].latitude),
        double.parse(Get.arguments[1].longitude)),
    zoom: 17,
    // bearing: 192.8334901395799,
  );

  LatLng pinPosition = LatLng(double.parse(Get.arguments[1].latitude),
      double.parse(Get.arguments[1].longitude));

  var addresses;
  Address address = Address();

  String date = "";
  String day = "";
  String time = "";

  Absensi absensiData = Absensi();

  _getDateNow() {
    var now = new DateTime.now();
    var formatter = DateFormat('dd MMM yyyy');
    var formatterDay = DateFormat('EEEE');
    var formatterTime = DateFormat('HH:mm');

    date = formatter.format(now);
    day = formatterDay.format(now);
    time = formatterTime.format(now);

    print(time);
  }

  void _getAddress() async {
    try {
      // var geocoding = AppState.of(context).mode;
      final coordinates = new Coordinates(
          double.parse(Get.arguments[1].latitude),
          double.parse(Get.arguments[1].longitude));
      addresses =
          await Geocoder.local.findAddressesFromCoordinates(coordinates);
      address = addresses.first;
      print("address ${address.addressLine}");
    } catch (e) {
      print("Error occured: $e");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getDateNow();
    setCustomMapPin();

    _getAddress();

    absensiData.tanggal = date;
    absensiData.jam = time;
    absensiData.lat = Get.arguments[1].latitude;
    absensiData.long = Get.arguments[1].longitude;
    absensiData.type = Get.arguments[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            GoogleMap(
              myLocationEnabled: true,
              mapType: MapType.normal,
              markers: _markers,
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
                setState(() {
                  _markers.add(Marker(
                      markerId: MarkerId("<MARKER_ID>"),
                      position: pinPosition,
                      icon: pinLocationIcon));
                });
              },
            ),
            Positioned(
              top: 40,
              left: 20,
              right: 20,
              child: Container(
                padding: EdgeInsets.all(25),
                // height: 200,
                decoration: BoxDecoration(
                  color: LightColors.mainColor,
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
                child: Text(
                  address.addressLine ?? "Address",
                  style: TextStyle(color: LightColors.white),
                ),
              ),
            ),
            Positioned(
              bottom: 100,
              left: 20,
              right: 20,
              child: Container(
                padding: EdgeInsets.all(25),
                height: 200,
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
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.date_range, color: LightColors.mainColor),
                        SizedBox(width: 10),
                        Text("${date}, ${time}",
                            style: TextStyle(color: LightColors.mainColor)),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.location_on,
                          color: LightColors.mainColor,
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Lat. ${Get.arguments[1].latitude}",
                                style: TextStyle(color: LightColors.mainColor)),
                            Text("Long. ${Get.arguments[1].longitude}",
                                style: TextStyle(color: LightColors.mainColor)),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    InkWell(
                      onTap: () => Get.to(CameraPage(absensiData: absensiData)),
                      child: BtnWidget(
                          title: Get.arguments[0],
                          color: Get.arguments[0] == "Check In"
                              ? LightColors.mainColor
                              : LightColors.red,
                          width: 300),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void setCustomMapPin() async {
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration(devicePixelRatio: 1), 'assets/images/pin.png')
        .then((onValue) {
      pinLocationIcon = onValue;
    });
  }
}
