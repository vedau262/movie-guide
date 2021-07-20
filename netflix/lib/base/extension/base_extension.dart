extension StringExtension on String? {
  int parseInt(){
    return int.parse(this ?? "0");
  }

  double parseDouble() {
    return double.parse(this ?? "0.0");
  }

  String getDefault(){
    return this ?? "";
  }
}

extension DynamicExtension on dynamic {
  String parseToString() {
    return (this as String).getDefault();
  }
  int parseToInt() {
    return (this as int).getDefault();
  }
  double parseToDouble() {
    return (this as double).getDefault();
  }
}

extension IntExtension on int?{
  int getDefault(){
    return this ?? 0;
  }
}

extension DoubleExtension on double? {
  double getDefault(){
    return this?? 0.0;
  }
}

extension BoolExtension on bool? {
  bool getDefault(){
    return this?? false;
  }
}