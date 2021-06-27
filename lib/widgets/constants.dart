import 'package:flutter/material.dart';

const kTextFieldDecoration = InputDecoration(
  hintText: 'Enter a value',
  labelStyle: TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
  ),
  hintStyle: TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
  ),
  contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(32.0),
    ),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.orange, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.orange, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);
