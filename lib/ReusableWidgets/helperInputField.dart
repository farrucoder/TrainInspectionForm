import 'package:flutter/material.dart';

Widget helperInputField(String hintTxt, TextEditingController ctr){
  return  Container(
    height: 50,
    padding: EdgeInsets.symmetric(horizontal: 10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Colors.black87),
    ),
    child: TextField(
      controller: ctr,
      decoration: InputDecoration(
        hintText: hintTxt,
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
      ),
    ),
  );
}