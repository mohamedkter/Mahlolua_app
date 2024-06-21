import 'package:shared_preferences/shared_preferences.dart';

class CacheData {
  static late SharedPreferences sharedPreferences;

  static cacheInitialization() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }
/////////////////////////// Set Value To Cache //////////////////////
  static setData({required String key, required dynamic value}) {
    if (value is String) {
      sharedPreferences.setString(key, value);
    } else if (value is bool) {
      sharedPreferences.setBool(key, value);
    } else if (value is double) {
      sharedPreferences.setDouble(key, value);
    } else if (value is int) {
      sharedPreferences.setInt(key, value);
    }
  }
////////////////////////// Get Value from Cache //////////////////////

static dynamic getData({required String key}){
dynamic value=sharedPreferences.get(key);
return value;
}
////////////////////////// Remove Value from Cache ////////////////////

static removeData({required String key}){
  sharedPreferences.remove(key);
}
///////////////////////// Clear All Data from cache /////////////

static clearCache(){
  sharedPreferences.clear();
}
}


///////////// Done //////////////////