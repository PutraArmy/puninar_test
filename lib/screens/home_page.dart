import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:puninar_absen_test/colors/light_colors.dart';
import 'package:puninar_absen_test/database/db_helper.dart';
import 'package:puninar_absen_test/screens/absensi_page.dart';
import 'package:puninar_absen_test/utils/usable.dart';
import 'package:puninar_absen_test/widgets/btn_widget.dart';
import 'package:puninar_absen_test/widgets/card_absensi_widget.dart';
import 'package:puninar_absen_test/widgets/card_user_widget.dart';
import 'package:safe_device/safe_device.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:slide_digital_clock/slide_digital_clock.dart';
import 'package:trust_location/trust_location.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // UsersModel usersList = UsersModel();
  // UserBloc _userBloc = UserBloc();

  LatLongPosition _latLongPosition = LatLongPosition();
  bool _isMockLocation = false;

  String date = "";
  String day = "";
  String time = "";

  bool checkin = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _userBloc = BlocProvider.of<UserBloc>(context);
    // _userBloc.add(GetUsersList(page: pageNumber));
    requestLocationPermission();
    _getDateNow();

    requestLocationPermission();
    // input seconds into parameter for getting location with repeating by timer.
    // this example set to 5 seconds.
    TrustLocation.start(1);
    getLocation();

    _refreshData();
    getCheckin();
  }

  Future<void> getLocation() async {
    try {
      TrustLocation.onChange.listen((values) => setState(() {
            _latLongPosition = values;
            _isMockLocation = values.isMockLocation ?? false;
          }));
    } on Exception catch (e) {
      print('PlatformException $e');
    }
  }

  Future<void> getCheckin() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    checkin = sharedPreferences.getBool("check_in") ?? false;
    print(checkin);
  }

  /// request location permission at runtime.
  void requestLocationPermission() async {
    // PermissionStatus permission =
    //     await LocationPermissions().requestPermissions();
    // You can request multiple permissions at once.
    Map<Permission, PermissionStatus> statuses = await [
      Permission.location,
      Permission.camera,
      Permission.microphone,
    ].request();
    print(statuses[Permission.location]);
    // print('permissions: $permission');
  }

  List<Map<String, dynamic>> absensiData = [];

  void _refreshData() async {
    final data = await DBHelper.getAbsensi();
    setState(() {
      absensiData = data;
      print(absensiData);
    });
  }

  _getDateNow() {
    var now = new DateTime.now();
    var formatter = DateFormat('dd MMM yyyy');
    var formatterDay = DateFormat('EEEE');
    var formatterTime = DateFormat('hh:mm');

    date = formatter.format(now);
    day = formatterDay.format(now);
    time = formatterTime.format(now);
    print(time);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double width1 = (width * (70 / 100)) - 10;
    double width2 = (width * (15 / 100)) - 30;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: LightColors.mainColor,
        elevation: 0,
        actions: [
          InkWell(
            onTap: () => Get.offAndToNamed("/splashScreen"),
            child: Icon(Icons.logout),
          ),
          Text("    "),
        ],
        iconTheme: IconThemeData(
          color: LightColors.white, //change your color here
        ),
      ),
      body:

          // MultiBlocListener(
          //   listeners: [
          //     BlocListener<UserBloc, UserState>(
          //       listener: (context, state) {
          //         if (state is UsersListError) {}
          //         if (state is UsersListWaiting) {
          //           print("Loading data");
          //         }
          //         if (state is UsersListSuccess) {
          //           if (state.usersList.data == null) {
          //             // _lastDataFlashsaleBanner = true;
          //             print("Tidak ada data");
          //           } else {
          //             // usersList = state.usersList;

          //             if (pageNumber <= 1) {
          //               usersList = state.usersList;
          //             } else {
          //               for (var i = 0; i < usersList.data!.length; i++) {
          //                 usersList.data?.add(state.usersList.data!.elementAt(i));
          //               }
          //             }

          //             print("masuk datanya beres" +
          //                 usersList.data!.length.toString());
          //             // print("Code" + usersList.data!.elementAt(0).firstName);
          //           }
          //         }
          //       },
          //     ),
          //   ],
          //   child:

          SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: LightColors.mainColor,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40)),
                ),
                padding: EdgeInsets.fromLTRB(10, 10, 20, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Text("09:00",
                    //     style: TextStyle(
                    //         fontSize: 48, fontWeight: FontWeight.w700)),
                    DigitalClock(
                      areaWidth: 200,
                      areaDecoration: BoxDecoration(color: Colors.transparent),
                      hourMinuteDigitDecoration:
                          BoxDecoration(color: Colors.transparent),
                      showSecondsDigit: false,
                      hourMinuteDigitTextStyle: TextStyle(
                          color: LightColors.white,
                          fontSize: 48,
                          fontWeight: FontWeight.w700),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(day,
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: LightColors.white)),
                        Text(date,
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: LightColors.white)),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                height: 235,
                child: Stack(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                      height: 135,
                      // decoration: BoxDecoration(
                      //   color: LightColors.mainColor,
                      //   borderRadius: BorderRadius.only(
                      //       bottomLeft: Radius.circular(40),
                      //       bottomRight: Radius.circular(40)),
                      // ),
                    ),
                    Positioned(
                      top: 10,
                      left: 20,
                      right: 20,
                      child: CardUserWidget(),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                            onTap: () {
                              if (!checkin) {
                                Get.to(AbsensiPage(),
                                    arguments: ["Check In", _latLongPosition]);
                              } else {
                                AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.WARNING,
                                  animType: AnimType.TOPSLIDE,
                                  title: 'Please check out first.',
                                  // desc: 'Dialog description here.............',
                                  // btnCancelOnPress: () {},
                                  btnOkOnPress: () {},
                                )..show();
                              }
                            },
                            child: BtnWidget(
                                title: "Check In",
                                color: LightColors.mainColor,
                                width: width / 2.30)),
                        InkWell(
                          onTap: () {
                            if (checkin) {
                              Get.to(AbsensiPage(),
                                  arguments: ["Check Out", _latLongPosition]);
                            } else {
                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.WARNING,
                                animType: AnimType.TOPSLIDE,
                                title: 'Please check in first.',
                                // desc: 'Dialog description here.............',
                                // btnCancelOnPress: () {},
                                btnOkOnPress: () {},
                              )..show();
                            }
                          },
                          child: BtnWidget(
                              title: "Check Out",
                              color: LightColors.red,
                              width: width / 2.30),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Divider(
                thickness: 10,
                color: LightColors.gray,
              ),
              SizedBox(height: 15),
              BtnWidget(
                  title: "History",
                  color: LightColors.mainColor,
                  width: width - 40),
              SizedBox(height: 20),
              ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: absensiData.length,
                  itemBuilder: (context, index) =>
                      CardAbsensiWidget(absensiData: absensiData[index]))
            ],
          ),
        ),
      ),
      // ),
    );
  }
}
