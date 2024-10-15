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
      padding: const EdgeInsets.only(left:0, right: 0, top: 10, bottom: 0),
      child: Column(
        children: [
          Image.asset(img, scale: 2.5),
          Text(text,
              style: TextStyle(
                fontSize: 16,
                color: txtColor,
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

Widget editabletxtforteacher(
  String text,
  // Container1,
  BuildContext context,
) {
  TextEditingController controller = TextEditingController(text: text);

  return SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.only(left: 0, right: 18, top: 10, bottom: 0),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(5),
            ),
            child: TextField(
              controller: controller,
              maxLines: null,
              keyboardType: TextInputType.multiline,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.normal,
              ),
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.all(10),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
