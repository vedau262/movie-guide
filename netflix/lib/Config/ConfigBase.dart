
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ConfigBase {
  static const String API_KEY = "4d0830d750f5ae621325e0907baa5d3b";
  static const String BASE_IMAGE_URL = "https://image.tmdb.org/t/p/w500";
  static const String BASE_URL = "http://api.themoviedb.org/3/";
  static final String posterPathDefault = "https://quantum-soft.net/images/75x50-1/http://s2.1pic.org/files/2019/04/16/d9c3dc1540830681331f.jpg";
  static final String backdropPathDefault = "https://i.dlpng.com/static/png/6563680_preview.png";

}

class Constant {
  static const double DEFAULT_PADDING = 20;
  static const DEFAULT_SHADOW = BoxShadow(
    offset: Offset(0, 4),
    blurRadius: 4,
    color: Colors.black26,
  );
}

extension NullSafeBlock<T> on T? {
  void let(Function(T it) runnable) {
    final instance = this;
    if (instance != null) {
      runnable(instance);
    }
  }
}