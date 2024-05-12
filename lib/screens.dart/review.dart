// ignore_for_file: use_key_in_widget_constructors, unused_local_variable, sort_child_properties_last

import 'package:edu_app/components/button.dart';
import 'package:edu_app/components/profie_text_edit.dart';
import 'package:edu_app/components/review_componemt.dart';
import 'package:edu_app/screens.dart/navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Reviewpage extends StatefulWidget {
  @override
  State<Reviewpage> createState() => _ReviewState();
}

class _ReviewState extends State<Reviewpage> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      const SizedBox(
                        height: 25,
                      ),
                      reivewtxt(
                        'assets/review.png',
                        'Review',
                        context,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 60, 0, 0),
                    child: Image.asset(
                      'assets/Line 7.png',
                      scale: 1.3,
                    ),
                  ),

                  Column(
                    children: [
                      const SizedBox(
                        height: 25,
                      ),
                      reivewtxt(
                        'assets/payment.png',
                        'Method',
                        context,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 60, 0, 0),
                    child: Image.asset(
                      'assets/Line 7.png',
                      scale: 1.4,
                    ),
                  ),
                  Column(
                    children: [
                      const SizedBox(
                        height: 25,
                      ),
                      reivewtxt(
                        'assets/payment2.png',
                        'Payment',
                        context,
                      ),
                    ],
                  ),
                  //
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(25.0, 0, 18, 0),
              child: Column(
                children: [
                  const Divider(
                    color: Colors.black,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Purchase Review',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Column(
                        children: [
                          txt('Name', context),
                          const Text('ishii',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                              )),
                        ],
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            txt('Class', context),
                            const Text('10th',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal,
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          txt('Course', context),
                          const Text('sainik school preparation',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                              )),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      txt('Including', context),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.menu_book_outlined,
                                  size: 40, color: Colors.blue.shade700),
                              txt2('  Notes', context),
                              SizedBox(
                                width: screenWidth * 0.18,
                              ),
                              Icon(Icons.movie_creation_rounded,
                                  size: 40, color: Colors.blue.shade700),
                              txt2(' HD Videos', context),
                            ],
                          ),
                          SizedBox(
                            height: screenHeight * 0.02,
                          ),
                          Row(
                            children: [
                              Icon(Icons.celebration,
                                  size: 40, color: Colors.blue.shade700),
                              txt2('  Certificate', context),
                              SizedBox(
                                width: screenWidth * 0.09,
                              ),
                              Icon(Icons.bookmark_added,
                                  size: 40, color: Colors.blue.shade700),
                              txt2(' Exam', context),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  Row(
                    children: [
                      Column(
                        children: [
                          txt('Duration', context),
                          const Text('1 Month',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                              )),
                        ],
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            txt('Rating', context),
                            const Text('   ★★★★★',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal,
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  Row(
                    children: [
                      Column(
                        children: [
                          txt('Have a Coupon Code ?', context),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 6, 0, 16),
                              child: CustomButton(
                                  text: '   Enter coupon   ',
                                  color: Colors.grey.shade300,
                                  textColor: Colors.grey.shade800,
                                  function: () {}),
                            ),
                          )
                        ],
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 19,
                            ),
                            ElevatedButton(
                              onPressed: () {},
                              child: const Text(
                                'Apply',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue[700],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Divider(
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Column(
                        children: [
                          txt2('Total Price :  ', context),
                          txt('  RS 12000 only', context),
                        ],
                      ),
                      const SizedBox(
                        width: 40,
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text(
                          ' Continue ',
                          style: TextStyle(color: Colors.white, fontSize: 23),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue[700],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
