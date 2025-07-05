

import 'package:flutter/material.dart';

Future<DateTime?> pickDate(BuildContext context) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2025),
    lastDate: DateTime(2030),
  );

  if (picked != null) {
    return picked;
  }
  return null;
}