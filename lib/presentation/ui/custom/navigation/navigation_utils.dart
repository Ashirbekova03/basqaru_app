import 'package:flutter/material.dart';

class NavigationUtils {

  static void push(BuildContext context, Widget widget) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => widget),
    );
  }

  static void pushResult(BuildContext context, Widget widget, Function callBack) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => widget),
    ).then((value) => callBack.call());
  }

  static void put(BuildContext context, Widget widget) {
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context) {
      return widget;
    }), (route) => false);
  }

}