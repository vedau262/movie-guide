
import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';


/// 用来做shared_preferences的存储
class SpUtil {
  static SpUtil? mInstance;
  static Future<SpUtil> get instance async {
    return await getInstance();
  }


  static SharedPreferences? mSharedPreferences;

  SpUtil._();

  Future _init() async {
    print(mInstance);
    mSharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<SpUtil> getInstance() async  {
    if (mInstance == null) {
      mInstance = new SpUtil._();
      await mInstance!._init();
    }
    return mInstance!;
  }

  static bool _beforCheck() {
    if (mSharedPreferences == null) {
      return true;
    }
    return false;
  }
  // 判断是否存在数据
  bool hasKey(String key) {
    Set? keys = getKeys();
    if (keys == null) {
      return false;
    } else {
      return keys.contains(key);
    }

  }

  Set<String>? getKeys() {
    if (_beforCheck()) return null;
    return mSharedPreferences?.getKeys();
  }

  get(String key) {
    if (_beforCheck()) return null;
    return mSharedPreferences?.get(key);
  }

  String? getString(String key) {
    if (_beforCheck()) return null;
    return mSharedPreferences?.getString(key);
  }

  Future<bool>? putString(String key, String value) {
    if (_beforCheck()) return null;
    return mSharedPreferences?.setString(key, value);
  }

  bool? getBool(String key) {
    if (_beforCheck()) return null;
    return mSharedPreferences?.getBool(key);
  }

  Future<bool>? putBool(String key, bool value) {
    if (_beforCheck()) return null;
    return mSharedPreferences?.setBool(key, value);
  }

  int? getInt(String key) {
    if (_beforCheck()) return null;
    return mSharedPreferences?.getInt(key);
  }

  Future<bool>? putInt(String key, int value) {
    if (_beforCheck()) return null;
    return mSharedPreferences?.setInt(key, value);
  }

  double? getDouble(String key) {
    if (_beforCheck()) return null;
    return mSharedPreferences?.getDouble(key);
  }

  Future<bool>? putDouble(String key, double value) {
    if (_beforCheck()) return null;
    return mSharedPreferences?.setDouble(key, value);
  }

  List<String> getStringList(String key) {
    if (mSharedPreferences != null) {
      return [];
    } else {
      return mSharedPreferences?.getStringList(key) ?? [];
    }
  }

  Future<bool>? putStringList(String key, List<String> value) {
    if (_beforCheck()) return null;
    return mSharedPreferences?.setStringList(key, value);
  }

  dynamic getDynamic(String key) {
    if (_beforCheck()) return null;
    return mSharedPreferences?.get(key);
  }



  Future<bool>? remove(String key) {
    if (_beforCheck()) return null;
    return mSharedPreferences?.remove(key);
  }

  Future<bool>? clear() {
    if (_beforCheck()) return null;
    return mSharedPreferences?.clear();
  }
}