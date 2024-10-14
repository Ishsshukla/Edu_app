
import 'package:edu_app/components/const.dart';
import 'package:edu_app/components/review_componemt.dart';
import 'package:edu_app/students_screens/screens/transaction_sucess.dart';
import 'package:flutter/material.dart';

class Finalpaypage extends StatefulWidget {
  final String docIdUser;

  const Finalpaypage({super.key, required this.docIdUser});
  @override
  State<Finalpaypage> createState() => _FinalpayState();
}

class _FinalpayState extends State<Finalpaypage> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final paddingHorizontal = screenWidth * 0.08;
    final paddingVertical = screenHeight * 0.01;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(paddingHorizontal, paddingVertical, paddingHorizontal, 0),
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
                        'assets/Group287.png',
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
                        'assets/payblue.png',
                        'Payment',
                        context,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(paddingHorizontal, 0, paddingHorizontal, 0),
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
                    child: Text('Payment  Details',
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
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, screenWidth * 0.2, 0),
                            child: txt('Order ID', context),
                          ),
                          const Text('INV-P6FDC7WMs',
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
                    height: screenHeight * 0.02,
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                      SizedBox(
                        width: screenWidth * 0.2,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          txt('Email', context),
                          const Text('ishii2048@gmail.com',
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
                    height: screenHeight * 0.3,
                  ),
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
                              builder: (context) =>  transactionpage(userIdDoc: widget.docIdUser,),
                            ),
                          );
                        },
                        child: const Text(
                          ' Continue ',
                          style: TextStyle(color: Colors.white, fontSize: 23),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF4A90E2),
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
