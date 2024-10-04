import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Widget lrngboxtxt(
  imagecls,
  text,
  // Container1,
  BuildContext context,
) {
  return Padding(
    padding: const EdgeInsets.only(left: 0, right: 0, top: 10, bottom: 10),
    child: Row(
      children: [
        Container(
          child: Image.asset(
            imagecls,
            scale: 4.5,
          ),
        ),
        Text(
          text,
          style: const TextStyle(
            backgroundColor: Colors.white,
          ),
        )
      ],
    ),
  );
}
