import 'package:flutter/material.dart';

Widget helperButton(String text){
  return  Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8),
    child: Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.green[500],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    ),
  );
}