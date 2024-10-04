// import 'package:cyber_secure/modules/categories_new_model.dart';
// import 'package:cyber_secure/screens/utilities.dart';
// import 'package:cyber_secure/view/view_model/news_view_model.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
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

  // NewsViewModel newsViewModel = NewsViewModel();

  String selectedValue = 'Select option';
  List<String> politicsList = [
    // 'Account Takeover',
    // 'Investment Scams',
    // 'Loan Scams',
    // 'Tax Scams',
    // 'Malicious Phishing',
    // 'Ransomeware',
    // 'Dark Web Marketplaces',
    // 'Data Leaks',
    // 'Blackmail and Extortion',
    // 'Fake Initial Coin Offerings (ICOs)',
    // 'Catfishing',
    // 'Deepfakes',
    // 'Tech Support Scams',
    'Military School Exams',
    'Sainik Schools',
    // 'Keywords',
    'Education',
  ];

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    // final screenWidth = MediaQuery.of(context).size.width;
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
                                              .copyWith(fontSize: 16))),
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
                                                color: selectedValue == e
                                                    ? Colors.black
                                                    : const Color.fromARGB(
                                                        110, 0, 0, 0)),
                                      ))),
                                ))
                            .toList(),
                      ),
                  ],
                ),
              ),
            ),
          ),
          //    uncomment this
          // Expanded(
          //   child: FutureBuilder<CategoriesNewsModel>(
          //       future: newsViewModel.fetchCategoriesNewsApi(selectedValue),
          //       builder: (BuildContext context, snapshot) {
          //         if (snapshot.connectionState == ConnectionState.waiting) {
          //           return Center(
          //             child: SpinKitCircle(
          //               size: 50,
          //               color: Colors.blue,
          //             ),
          //           );
          //         } else {
          //           return ListView.builder(
          //               itemCount: snapshot.data!.articles!.length,
          //               itemBuilder: (context, index) {
          //                 DateTime dateTime = DateTime.parse(snapshot
          //                     .data!.articles![index].publishedAt
          //                     .toString());
          //                 return newsBox2(
          //                   snapshot,
          //                   index,
          //                   '',
          //                   0.329,
          //                   0.9,
          //                   context,
          //                 );
          //               });
          //         }
          //       }),
          // )
        ],
      ),
    );
  }
}