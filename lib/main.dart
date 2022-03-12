// @dart=2.9
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:puninar_absen_test/colors/light_colors.dart';
import 'package:puninar_absen_test/screens/home_page.dart';
import 'package:puninar_absen_test/screens/login_page.dart';
import 'package:puninar_absen_test/screens/splash_screen.dart';

List<CameraDescription> cameras = [];

Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: LightColors.mainColor, // navigation bar color
    statusBarColor: Colors.transparent, // status bar color
  ));

  WidgetsFlutterBinding.ensureInitialized();

  cameras = await availableCameras();

  return runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return 
    // MultiBlocProvider(
    //   providers: [
    //     BlocProvider<UserBloc>(create: (BuildContext context) => UserBloc()),
    //   ],
      // child: 
      GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: Theme.of(context).textTheme.apply(
              bodyColor: LightColors.mainColor,
              displayColor: LightColors.mainColor,
              fontFamily: 'Poppins'),
        ),
        initialRoute: '/splashScreen',
        getPages: [
          GetPage(name: '/', page: () => LoginPage()),
          GetPage(name: '/splashScreen', page: () => SplashScreen()),
          GetPage(name: '/homePage', page: () => HomePage()),
        ],
      // ),
    );
  }

  
}
