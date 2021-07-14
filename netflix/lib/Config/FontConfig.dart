import 'package:flutter/cupertino.dart';

class FontConfig {
  static const String FONT_FAMILY = "yoongothic";
}


extension TextExt on Text {
  static Text text(String text,double size, FontWeight fontWeight, Color color, {TextAlign textAlign = TextAlign.start}) {
    return Text(text, style: TextStyleExt.textStyle(size, fontWeight, color), textAlign: textAlign);
  }

  static Widget defaultText(String text, Color color, FontWeight fontWeight, double size, {TextAlign textAlign = TextAlign.start}) {
    return DefaultTextStyle.merge(
      style: TextStyle(
        color: color,
        fontWeight: fontWeight,
        fontSize: size,
      ),
      textAlign: textAlign,
      child: Text(text),
    );
  }
}

extension TextStyleExt on TextStyle {
  static TextStyle textStyle(double size, FontWeight fontWeight, Color color) {
    return TextStyle(fontFamily: FontConfig.FONT_FAMILY, fontWeight: fontWeight, fontSize: size, color: color);
  }
}

