// ignore_for_file: use_key_in_widget_constructors, unused_local_variable, sort_child_properties_last

import 'package:edu_app/components/review_componemt.dart';
import 'package:edu_app/students_screens/screens/payment_method.dart';
import 'package:flutter/material.dart';

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
              padding: EdgeInsets.fromLTRB(screenWidth * 0.08, screenHeight * 0.01, screenWidth * 0.08, 0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: screenHeight * 0.03,
                      ),
                      reivewtxt(
                        'assets/review.png',
                        'Review',
                        context,
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, screenHeight * 0.07, 0, 0),
                    child: Image.asset(
                      'assets/Line 7.png',
                      scale: 1.3,
                    ),
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: screenHeight * 0.03,
                      ),
                      reivewtxt(
                        'assets/payment.png',
                        'Method',
                        context,
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, screenHeight * 0.07, 0, 0),
                    child: Image.asset(
                      'assets/Line 7.png',
                      scale: 1.4,
                    ),
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: screenHeight * 0.03,
                      ),
                      reivewtxt(
                        'assets/payment2.png',
                        'Payment',
                        context,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(screenWidth * 0.07, 0, screenWidth * 0.05, 0),
              child: Column(
                children: [
                  const Divider(
                    color: Colors.black,
                  ),
                  SizedBox(
                    height: screenHeight * 0.01,
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
                  SizedBox(
                    height: screenHeight * 0.01,
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
                  SizedBox(
                    height: screenHeight * 0.01,
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
                  SizedBox(
                    height: screenHeight * 0.01,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      txt('Including', context),
                    ],
                  ),
                  SizedBox(
                    height: screenHeight * 0.01,
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.menu_book_outlined,
                                  size: 37, color: Color(0xFF4A90E2)),
                              txt2('  Notes', context),
                              SizedBox(
                                width: screenWidth * 0.18,
                              ),
                              const Icon(Icons.movie_creation_rounded,
                                  size: 37, color: Color(0xFF4A90E2)),
                              txt2(' HD Videos', context),
                            ],
                          ),
                          SizedBox(
                            height: screenHeight * 0.02,
                          ),
                          Row(
                            children: [
                              const Icon(Icons.celebration,
                                  size: 37, color: Color(0xFF4A90E2)),
                              txt2('  Certificate', context),
                              SizedBox(
                                width: screenWidth * 0.09,
                              ),
                              const Icon(Icons.bookmark_added,
                                  size: 37, color: Color(0xFF4A90E2)),
                              txt2(' Exam', context),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: screenHeight * 0.02,
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
                      SizedBox(
                        width: screenWidth * 0.03,
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
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  Row(
                    children: [
                      Column(
                        children: [
                          SizedBox(height: screenHeight * 0.02),
                          txt('Have a Coupon Code ?', context),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(0, screenHeight * 0.01, 0, screenHeight * 0.03),
                              child: SizedBox(
                                height: screenHeight * 0.1,
                                width: screenWidth * 0.5, // Set the desired width here
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    hintText: 'Enter coupon',
                                    hintStyle: TextStyle(
                                      color: Colors.grey.shade800,
                                    ),
                                    filled: true,
                                    fillColor: Colors.grey.shade300,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                  style: TextStyle(
                                    color: Colors.grey.shade300,
                                  ),
                                  onChanged: (value) {
                                    // Handle coupon input
                                  },
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(width: screenWidth * 0.07),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: screenHeight * 0.02,
                            ),
                            ElevatedButton(
                              onPressed: () {},
                              child: const Text(
                                'Apply',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF4A90E2),
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
                  SizedBox(height: screenHeight * 0.01),
                  const Divider(
                    color: Colors.grey,
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Row(
                    children: [
                      Column(
                        children: [
                          txt2('Total Price :  ', context),
                          txt('  RS 12000 only', context),
                        ],
                      ),
                      SizedBox(
                        width: screenWidth * 0.1,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PayMethodPage(),
                            ),
                          );
                        },
                        child: const Text(
                          ' Continue ',
                          style: TextStyle(color: Colors.white, fontSize: 23),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF4A90E2),
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
