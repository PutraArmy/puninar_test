import 'package:shared_preferences/shared_preferences.dart';

Future<void> setCheckin(bool check_in) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.setBool("check_in", check_in);
}

