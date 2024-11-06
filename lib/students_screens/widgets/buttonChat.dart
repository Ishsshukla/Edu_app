import 'package:flutter/material.dart';

Widget buttonchat(String image, BuildContext context, page) {
  final screenHeight = MediaQuery.of(context).size.height;
  final screenWidth = MediaQuery.of(context).size.width;

  return GestureDetector(
    onTap: () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => page));
    },
    // onTapFunction();

    child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(0.00, -1.00),
            end: Alignment(0, 1),
            colors: [Color(0xFF4E82EA), Color(0xFF245BC9)],
          ),
          borderRadius: BorderRadius.all(Radius.circular(50)),
          boxShadow: [
            BoxShadow(),
          ],
        ),
        height: screenHeight * 0.1,
        width: screenWidth * 0.2,
        child: Padding(
          padding: const EdgeInsets.all(7.0),
          child: Image.asset(
            image,
            // height: screenHeight * 0.01,
            // fit: BoxFit.cover,
            scale: 5,
          ),
        )),
  );
}