
import 'package:flutter/cupertino.dart';

extension AssetImageExt on AssetImage {
  static AssetImage imageFrom(String name) {
    return AssetImage('assets/images/' + name);
  }
}