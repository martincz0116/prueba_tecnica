import 'package:flutter/material.dart';

InputDecoration textFieldDecoration() {
  return const InputDecoration(
    contentPadding: EdgeInsets.all(8),
    suffixIcon: Icon(Icons.edit, color: Colors.white),
    border: OutlineInputBorder(
      gapPadding: 0,
      borderSide: BorderSide(color: Colors.white, width: 2),
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
    focusedBorder: OutlineInputBorder(
      gapPadding: 0,
      borderSide: BorderSide(color: Colors.white, width: 2),
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
    enabledBorder: OutlineInputBorder(
      gapPadding: 0,
      borderSide: BorderSide(color: Colors.white, width: 2),
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
  );
}
