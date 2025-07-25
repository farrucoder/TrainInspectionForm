import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void customToast(String msg) {

  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: Colors.red,
    textColor: Colors.white,
    fontSize: 16.0,
  );

}
