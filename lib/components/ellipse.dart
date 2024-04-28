import 'package:flutter/material.dart';

Widget crcl(
  text,
  BuildContext context,
) {
  return Padding(
    padding: const EdgeInsets.only(left: 0, right: 0, top: 10, bottom: 10),
    child: Container(
      width: double.infinity,
      height: 200,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(100),
          bottomRight: Radius.circular(100),
        ),
      ),
      child: Container(
        padding: EdgeInsets.fromLTRB(60, 10, 60, 10),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(400),
            bottomRight: Radius.circular(400),
          ),
          border: Border.all(
            color: Colors.transparent,
            width: 2,
          ),
        ),
        child: Center(
          child: Text(
            text,
            softWrap: true,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 30, color: Colors.white),
          ),
        ),
      ),
    ),
  );
}
