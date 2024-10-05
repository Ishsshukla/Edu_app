import 'package:edu_app/components/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Widget coursetxt(
  String img,
  String text,
  String routeName, // Add a parameter for the route name
  BuildContext context,
) {
  return SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.only(left: 0, right: 0, top: 10, bottom: 0),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(28.0, 38, 24, 0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            children: [
              Column(
                children: [
                  Image.asset(img, scale: 12),
                ],
              ),
              const SizedBox(width: 40),
              Column(
                children: [
                  Column(
                    children: [
                      Text(
                        text,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context,
                              routeName); // Use the route name to navigate
                        },
                        child: const Text('Buy Now'),
                        style: ElevatedButton.styleFrom(),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget coursetxtforteacher(
  String img,
  String text,
  String routeName, // Add a parameter for the route name
  BuildContext context,
) {
  return SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.only(left: 0, right: 0, top: 20, bottom: 0),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(19, 20, 19, 0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            children: [
              Column(
                children: [
                  Image.asset(img, scale: 12),
                ],
              ),
              const SizedBox(width: 10),
              Column(
                children: [
                  Column(
                    children: [
                      Text(
                        text,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context,
                              routeName); // Use the route name to navigate
                        },
                        child: const Text('Edit Course'),
                        //  child: const Text('view'),
                        style: ElevatedButton.styleFrom(),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
