import 'package:basqary/presentation/ui/custom/constant/app_color.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MessageHint {

  static void showMessage(String message) => Fluttertoast.showToast(
    msg: message,
    gravity: ToastGravity.TOP,
    toastLength: Toast.LENGTH_LONG,
    timeInSecForIosWeb: 1,
    backgroundColor: AppColor.secondary,
    textColor: Colors.white,
    fontSize: 16.0,
  );

}