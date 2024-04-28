import 'package:flutter/material.dart';

Widget clstxt(
  text,
  // Container1,
  BuildContext context,
) {
  return Padding(
    padding: EdgeInsets.only(left: 0, right: 0, top: 10, bottom: 10),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        padding: EdgeInsets.fromLTRB(60, 10, 60, 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.black,
            width: 2,
          ),
        ),
        child: Text(
          text,
          style: TextStyle(fontSize: 20, color: Colors.black),
        ),
      ),
    ),
  );
}
