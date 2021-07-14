import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Text Styles

// To make it clear which weight we are using, we'll define the weight even for regular
// fonts
const Color Color_Text = Colors.black;

const TextStyle normalTextStyle = TextStyle(
  fontSize: 15,
  fontWeight: FontWeight.w400,
);

const TextStyle heading1Style = TextStyle(
  color: Color_Text,
  fontSize: 34,
  fontWeight: FontWeight.w400,
);

const TextStyle heading2Style = TextStyle(
  color: Color_Text,
  fontSize: 28,
  fontWeight: FontWeight.w600,
);

const TextStyle heading3Style = TextStyle(
  color: Color_Text,
  fontSize: 24,
  fontWeight: FontWeight.w600,
);

const TextStyle headlineStyle = TextStyle(
  color: Color_Text,
  fontSize: 30,
  fontWeight: FontWeight.w700,
);

const TextStyle bodyStyle = TextStyle(
  color: Color_Text,
  fontSize: 16,
  fontWeight: FontWeight.w400,
);

const TextStyle subheadingStyle = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.w400,
  height: 3,
);

const TextStyle captionStyle = TextStyle(
  color: Color_Text,
  fontSize: 12,
  fontWeight: FontWeight.w400,
);