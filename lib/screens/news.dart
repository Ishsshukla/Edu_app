// ignore_for_file: sort_child_properties_last

import 'package:edu_app/components/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Newspage extends StatefulWidget {
  const Newspage({super.key});

  @override
  State<Newspage> createState() => _NewspageState();
}

class _NewspageState extends State<Newspage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Latest News'),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
          child: Container(
            child: Column(
              children: [
                Row(
                  children: [Image.asset('assets/Group287.png'), const Text('dgfdg')],
                )
              ],
              // crossAxisAlignment: CrossAxisAlignment.stretch,
            ),
          ),
        ),
      ),
    );
  }
}
