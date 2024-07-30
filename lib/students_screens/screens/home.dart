import 'package:edu_app/models/headline.dart';
import 'package:edu_app/models/new_page_model.dart';
import 'package:edu_app/students_screens/screens/splash.dart';
import 'package:edu_app/students_screens/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import '../../components/review_componemt.dart';
import '../pages/user_notifier.dart';
import 'navbar.dart';
// import 'user_notifier.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

TextEditingController _controller = TextEditingController();

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final userNotifier = Provider.of<UserNotifier>(context);
    NewsViewModel newsViewModel = NewsViewModel();

    return Scaffold(
      appBar: AppBar(
        title:
            Text('Hiii  ${userNotifier.firstName}  ${userNotifier.lastName}'),
        backgroundColor: Colors.white,
        // elevation: 0.0,
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 30, 0),
            child: IconButton(
              icon: Icon(Icons.notifications),
              onPressed: () {
                // Add your desired functionality here
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Column(
            children: [
              Row(
                children: [
                  txt2(' What do you want to learn today ?', context),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: 'Search...',
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(
                height: 10,
              ),
              // txt('what you want to learn today', context),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    // txt('what you want to learn today', context),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade300.withOpacity(1),
                            spreadRadius: 1.5,
                            blurRadius: 7,
                            offset: const Offset(0, 0),
                            blurStyle: BlurStyle.inner,
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Image.asset('assets/Mask Group.png', scale: 3.5),
                          txt2('General Science', context),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade300.withOpacity(1),
                            spreadRadius: 1.5,
                            blurRadius: 7,
                            offset: const Offset(0, 0),
                            blurStyle: BlurStyle.inner,
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Image.asset('assets/Mask Group2.png', scale: 3.5),
                          txt2('Current Affairs ', context),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade300.withOpacity(1),
                            spreadRadius: 1.5,
                            blurRadius: 7,
                            offset: const Offset(0, 0),
                            blurStyle: BlurStyle.inner,
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Image.asset('assets/Mask Group2.png', scale: 3.5),
                          txt2('Current Affairs ', context),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  txt('  Latest Current Affairs', context),
                  GestureDetector(
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => (())),
                      // );
                    },
                    // Add your desired functionality here

                    child: txt('  ', context),
                  ),
                ],
              ),
              SizedBox(
                  height: screenHeight * 0.4,
                  width: screenWidth,
                  child: FutureBuilder<NewsChannelsHeadlineModels>(
                      future: newsViewModel.fetchNewsChannelHeadlineApi(),
                      builder: (BuildContext context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: SpinKitCircle(
                              color: Colors.blue,
                              size: 50,
                            ),
                          );
                        } else {
                          return ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: snapshot.data!.articles!.length,
                              itemBuilder: (context, index) {
                                return newsBox(snapshot, index, '', 0.28, 0.7,
                                    0.18, context, null);
                              });
                        }
                      })),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Nav(initialIndex: 0),
    );
  }
}
