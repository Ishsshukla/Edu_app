// ignore_for_file: sort_child_properties_last

import 'package:edu_app/components/review_componemt.dart';
import 'package:edu_app/students_screens/screens/final_pay.dart';
import 'package:flutter/material.dart';

class PayMethodPage extends StatefulWidget {
  const PayMethodPage({super.key});

  @override
  State<PayMethodPage> createState() => _PayMethodState();
}

class _PayMethodState extends State<PayMethodPage> {
  bool isSelected1 = false; // Selected state for payment mode 1
  bool isSelected2 = false; // Selected state for payment mode 2

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
          child: Column(
            children: [
              SizedBox(height: screenHeight * 0.03),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      SizedBox(height: screenHeight * 0.03),
                      reivewtxt(
                        'assets/review.png',
                        'Review',
                        context,
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: screenHeight * 0.07),
                    child: Image.asset(
                      'assets/Line 7.png',
                      scale: 1.3,
                    ),
                  ),
                  Column(
                    children: [
                      SizedBox(height: screenHeight * 0.03),
                      reivewtxt(
                        'assets/Group287.png',
                        'Method',
                        context,
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: screenHeight * 0.07),
                    child: Image.asset(
                      'assets/Line 7.png',
                      scale: 1.4,
                    ),
                  ),
                  Column(
                    children: [
                      SizedBox(height: screenHeight * 0.03),
                      reivewtxt(
                        'assets/payment2.png',
                        'Payment',
                        context,
                      ),
                    ],
                  ),
                ],
              ),
              const Divider(color: Colors.grey),
              SizedBox(height: screenHeight * 0.02),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Payment Method',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.015),
              GestureDetector(
                onTap: () {
                  setState(() {
                    isSelected1 = !isSelected1;
                    isSelected2 = false; // Deselect other option
                  });
                },
                child: Container(
                  width: double.infinity,
                  height: screenHeight * 0.08,
                  decoration: BoxDecoration(
                    color: isSelected1 ? const Color(0xFF4A90E2) : Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: isSelected1 ? const Color(0xFF4A90E2) : Colors.grey,
                      width: 2,
                    ),
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(screenWidth * 0.02),
                        child: CircleAvatar(
                          backgroundColor:
                              isSelected1 ? const Color(0xFF4A90E2) : Colors.grey,
                          child: isSelected1
                              ? const Icon(Icons.check, color: Colors.white)
                              : null,
                        ),
                      ),
                      const SizedBox(width: 0),
                      Text(
                        'PayPal', // Adjust this to your payment mode 1 name
                        style: TextStyle(
                          fontSize: 18,
                          color: isSelected1 ? Colors.white : Colors.black,
                        ),
                      ),
                      Spacer(),
                      Image.asset(
                        'assets/paypal.png', // Adjust this to your payment mode 1 image path
                        width: screenWidth * 0.1,
                        height: screenHeight * 0.05,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              GestureDetector(
                onTap: () {
                  setState(() {
                    isSelected2 = !isSelected2;
                    isSelected1 = false; // Deselect other option
                  });
                },
                child: Container(
                  width: double.infinity,
                  height: screenHeight * 0.08,
                  decoration: BoxDecoration(
                    color: isSelected2 ? const Color(0xFF4A90E2) : Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: isSelected2 ? const Color(0xFF4A90E2) : Colors.grey,
                      width: 2,
                    ),
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(screenWidth * 0.02),
                        child: CircleAvatar(
                          backgroundColor:
                              isSelected2 ? const Color(0xFF4A90E2) : Colors.grey,
                          child: isSelected2
                              ? const Icon(Icons.check, color: Colors.white)
                              : null,
                        ),
                      ),
                      const SizedBox(width: 0),
                      Text(
                        'Credit Card', // Adjust this to your payment mode 2 name
                        style: TextStyle(
                          fontSize: 18,
                          color: isSelected2 ? Colors.white : Colors.black,
                        ),
                      ),
                      Spacer(),
                      Image.asset(
                        'assets/mastercard.png', // Adjust this to your payment mode 2 image path
                        width: screenWidth * 0.1,
                        height: screenHeight * 0.05,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.4),
              const Divider(color: Colors.grey),
              SizedBox(height: screenHeight * 0.03),
              Row(
                children: [
                  const Column(
                    children: [
                      Text(
                        'Total Price :  ',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        '  RS 12000 only',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  ElevatedButton(
                    onPressed: () {
                      if (isSelected1 || isSelected2) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Finalpaypage(),
                          ),
                        );
                      } else {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Error'),
                              content: const Text('Please select a payment method.'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      }
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
      ),
    );
  }
}
