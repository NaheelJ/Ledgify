import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

callNext(var className, var context) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => className));
}

callNextReplacement(var className, var context) {
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => className));
}

back(var context) {
  Navigator.pop(context);
}

void finish(context) {
  Navigator.pop(context);
}

void hideKeyboard(context) {
  FocusScope.of(context).requestFocus(FocusNode());
}

Color hexStringToHexInt(String hex) {
  hex = hex.replaceFirst('#', '');
  hex = hex.length == 6 ? 'ff$hex' : hex;
  int val = int.parse(hex, radix: 16);
  return Color(val);
}

Color colorFromHex(String hexColor) {
  final hexCode = hexColor.replaceAll('#', '');
  return Color(int.parse('FF$hexCode', radix: 16));
}

Widget textWid(String text, Color colors, double textsize, String fontFamily, FontWeight fontWeight) {
  return Text(
    text,
    style: TextStyle(
      fontFamily: fontFamily,
      fontSize: textsize, // Ensure textsize is a double
      color: colors,
      fontWeight: fontWeight,
    ),
  );
}


List<String> generateSearchKeywords(String name, String phone, [String? role]) {
  List<String> keywords = [];

  String nameLower = name.toLowerCase();
  for (int i = 1; i <= nameLower.length; i++) {
    keywords.add(nameLower.substring(0, i));
  }

  for (int i = 1; i <= phone.length; i++) {
    keywords.add(phone.substring(0, i));
  }

  if (role != null && role.trim().isNotEmpty) {
    String roleLower = role.toLowerCase();
    for (int i = 1; i <= roleLower.length; i++) {
      keywords.add(roleLower.substring(0, i));
    }
  }

  return keywords;
}