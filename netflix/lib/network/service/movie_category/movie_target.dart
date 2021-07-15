// import 'package:flutter/cupertino.dart';
// import 'package:netflix/Model/home_category.dart';
//
// import '../../APIRouteConfigurable.dart';
// class GetListMovie implements Target {
//   final HomeCategory category;
//   GetListMovie(this.category);
//
//   @override
//   Map<String, dynamic>? routeParams() {
//     return null;
//   }
//
//   @override
//   String path() {d
//     return category.path();
//   }
//
//   @override
//   APIMethod method() {
//     return APIMethod.get;
//   }
//
//   @override
//   bool isQueryParams() {
//     return method() == APIMethod.get;
//   }
// }
//
// class GetTrailerMovie implements Target {
//   final int id;
//   GetTrailerMovie(this.id);
//
//   @override
//   Map<String, dynamic>? routeParams() {
//     return null;
//   }
//
//   @override
//   String path() {
//     return category.path();
//   }
//
//   @override
//   APIMethod method() {
//     return APIMethod.get;
//   }
//
//   @override
//   bool isQueryParams() {
//     return method() == APIMethod.get;
//   }
// }