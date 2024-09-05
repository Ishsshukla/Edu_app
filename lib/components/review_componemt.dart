import 'package:edu_app/components/const.dart';
import 'package:flutter/material.dart';

Widget reivewtxt(
  img,
  text,

  // Container1,
  BuildContext context,
) {
  return SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.only(left: 0, right: 0, top: 10, bottom: 0),
      child: Column(
        children: [
          Image.asset(img, scale: 2),
          Text(text,
              style: TextStyle(
                fontSize: 16,
                color: Colors.blue[700],
                fontWeight: FontWeight.normal,
              )),
        ],
      ),
    ),
  );
}

Widget txt(
  String text,
  // Container1,
  BuildContext context,
) {
  return SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.only(left: 0, right: 0, top: 10, bottom: 0),
      child: Column(
        children: [
          Text(text,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              )),
        ],
      ),
    ),
  );
}

Widget txt2(
  text,
  // Container1,
  BuildContext context,
) {
  return SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.only(left: 0, right: 0, top: 10, bottom: 0),
      child: Column(
        children: [
          Text(text,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.normal,
              )),
        ],
      ),
    ),
  );
}

