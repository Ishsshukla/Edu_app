import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomDropDownWidget extends StatefulWidget {
  const CustomDropDownWidget({super.key});

  @override
  State<CustomDropDownWidget> createState() => _CustomDropDownWidgetState();
}

class _CustomDropDownWidgetState extends State<CustomDropDownWidget> {
  late SharedPreferences prefs;
  @override
  void initState() {
    super.initState();
    initSharedPref();
  }

  void initSharedPref() async {
    prefs = await SharedPreferences.getInstance();
  }

  bool isExpanded = false;

  String selectedValue = 'Select option';
  List<String> politicsList = [
    'Military School Exams',
    'Sainik Schools',
    'Education',
  ];

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Container(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: screenHeight * 0.07,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(5),
                          topRight: const Radius.circular(5),
                          bottomLeft: Radius.circular(isExpanded ? 0 : 5),
                          bottomRight: Radius.circular(isExpanded ? 0 : 5),
                        ),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: InkWell(
                              onTap: () {
                                FocusScope.of(context).unfocus();
                                isExpanded = !isExpanded;
                                setState(() {});
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                      child: Text(selectedValue,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineSmall!
                                              .copyWith(
                                                  fontSize: 16,
                                                  color: const Color(0xFF4A90E2)))),
                                  Icon(
                                    isExpanded
                                        ? Icons.keyboard_arrow_up
                                        : Icons.keyboard_arrow_down,
                                    color: isExpanded
                                        ? const Color.fromARGB(255, 54, 73, 244)
                                        : Colors.blue,
                                  )
                                ],
                              )),
                        ),
                      ),
                    ),
                    if (isExpanded)
                      ListView(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        children: politicsList
                            .map((e) => InkWell(
                                  onTap: () {
                                    isExpanded = false;
                                    selectedValue = e;
                                    setState(() {});
                                  },
                                  child: Container(
                                      height: 40,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: selectedValue == e
                                            ? const Color.fromARGB(75, 114, 104, 108)
                                            : Colors.grey.shade300,
                                      ),
                                      child: Center(
                                          child: Text(
                                        e.toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .displayMedium!
                                            .copyWith(
                                                fontSize: 14,
                                                color: const Color(0xFF4A90E2)),
                                      ))),
                                ))
                            .toList(),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
