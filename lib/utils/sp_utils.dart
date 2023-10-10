//
//
//
// import 'package:shared_preferences/shared_preferences.dart';
//
// saveData(String key, value) async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   if (value is String) {
//     prefs.setString(key, value);
//   } else if (value is num) {
//     prefs.setInt(key, value as int);
//   } else if (value is double) {
//     prefs.setDouble(key, value);
//   } else if (value is bool) {
//     prefs.setBool(key, value);
//   } else if (value is List) {
//     prefs.setStringList(key, value.cast<String>());
//   }
// }
//
// dynamic getData(String key, [replace]) async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   dynamic data = prefs.get(key);
//   if (data != null) {
//     return data;
//   } else {
//     return replace;
//   }
// }
//
// removeData(String key) async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   prefs.remove(key);
// }
//
// removeDataAll() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   prefs.clear();
// }
