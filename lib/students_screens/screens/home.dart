// import 'package:edu_app/models/new_page_model.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'user_notifier.dart';
// import 'navbar.dart';
// // import 'user_notifier.dart';

// class Homepage extends StatefulWidget {
//   final String docIdUser;
//   const Homepage({super.key, required this.docIdUser});

//   @override
//   _HomepageState createState() => _HomepageState();
// }

// TextEditingController _controller = TextEditingController();

// class _HomepageState extends State<Homepage> {
//   @override
//   Widget build(BuildContext context) {
//     final screenHeight = MediaQuery.of(context).size.height;
//     final screenWidth = MediaQuery.of(context).size.width;
//     // final userNotifier = Provider.of<UserNotifier>(context);
//     NewsViewModel newsViewModel = NewsViewModel();

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           // 'Hiii  ${userNotifier.firstName}  ${userNotifier.lastName}',
//           "Hi ${widget.docIdUser}",
//           style: const TextStyle(color: Colors.black),
//         ),
//         backgroundColor: Colors.white,
//         // elevation: 0.0,
//         actions: [
//           Padding(
//             padding: const EdgeInsets.fromLTRB(0, 0, 30, 0),
//             child: IconButton(
//               icon: const Icon(Icons.notifications),
//               onPressed: () {
//                 // Add your desired functionality here
//               },
//             ),
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
//           child: Column(
//             children: [
//               Row(
//                 children: [
//                   txt2(' What do you want to learn today ?', context),
//                 ],
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               Row(
//                 children: [
//                   Expanded(
//                     child: TextField(
//                       controller: _controller,
//                       decoration: InputDecoration(
//                         hintText: 'Search...',
//                         prefixIcon: const Icon(Icons.search),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),

//               const SizedBox(
//                 height: 10,
//               ),
//               // txt('what you want to learn today', context),
//               SingleChildScrollView(
//                 scrollDirection: Axis.horizontal,
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: <Widget>[
//                     // txt('what you want to learn today', context),
//                     Container(
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(10),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.grey.shade300.withOpacity(1),
//                             spreadRadius: 1.5,
//                             blurRadius: 7,
//                             offset: const Offset(0, 0),
//                             blurStyle: BlurStyle.inner,
//                           ),
//                         ],
//                       ),
//                       child: Column(
//                         children: [
//                           Image.asset('assets/Mask Group.png', scale: 3.5),
//                           txt2('General Science', context),
//                         ],
//                       ),
//                     ),
//                     const SizedBox(
//                       width: 20,
//                     ),
//                     Container(
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(10),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.grey.shade300.withOpacity(1),
//                             spreadRadius: 1.5,
//                             blurRadius: 7,
//                             offset: const Offset(0, 0),
//                             blurStyle: BlurStyle.inner,
//                           ),
//                         ],
//                       ),
//                       child: Column(
//                         children: [
//                           Image.asset('assets/Mask Group2.png', scale: 3.5),
//                           txt2('Current Affairs ', context),
//                         ],
//                       ),
//                     ),
//                     const SizedBox(
//                       width: 20,
//                     ),
//                     Container(
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(10),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.grey.shade300.withOpacity(1),
//                             spreadRadius: 1.5,
//                             blurRadius: 7,
//                             offset: const Offset(0, 0),
//                             blurStyle: BlurStyle.inner,
//                           ),
//                         ],
//                       ),
//                       child: Column(
//                         children: [
//                           Image.asset('assets/Mask Group2.png', scale: 3.5),
//                           txt2('Current Affairs ', context),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   txt('  Latest Current Affairs', context),
//                   GestureDetector(
//                     onTap: () {
//                       // Navigator.push(
//                       //   context,
//                       //   MaterialPageRoute(builder: (context) => (())),
//                       // );
//                     },
//                     // Add your desired functionality here

//                     child: txt('  ', context),
//                   ),
//                 ],
//               ),
//               // SizedBox(
//               //     height: screenHeight * 0.4,
//               //     width: screenWidth,
//               //     child: FutureBuilder<NewsChannelsHeadlineModels>(
//               //         future: newsViewModel.fetchNewsChannelHeadlineApi(),
//               //         builder: (BuildContext context, snapshot) {
//               //           if (snapshot.connectionState ==
//               //               ConnectionState.waiting) {
//               //             return Center(
//               //               child: SpinKitCircle(
//               //                 color: Colors.blue,
//               //                 size: 50,
//               //               ),
//               //             );
//               //           } else {
//               //             return ListView.builder(
//               //                 scrollDirection: Axis.vertical,
//               //                 itemCount: snapshot.data!.articles!.length,
//               //                 itemBuilder: (context, index) {
//               //                   return newsBox(snapshot, index, '', 0.28, 0.7,
//               //                       0.18, context, null);
//               //                 });
//               //           }
//               //         })),
//             ],
//           ),
//         ),
//       ),
//       bottomNavigationBar: Nav(
//         initialIndex: 0,
//         docIdUser: widget.docIdUser,
//       ),
//     );
//   }
// }

// Widget txt2(String text, BuildContext context, {Color color = Colors.black}) {
//   return Text(
//     text,
//     style: TextStyle(color: color),
//   );
// }

// Widget txt(String text, BuildContext context, {Color color = Colors.black}) {
//   return Text(
//     text,
//     style: TextStyle(color: color),
//   );
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'navbar.dart';

class Homepage extends StatefulWidget {
  final String docIdUser;
  const Homepage({super.key, required this.docIdUser});

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  TextEditingController _controller = TextEditingController();
  String? userName; // To store the user's name
  bool isLoading = true; // To show loading state while fetching data

  @override
  void initState() {
    super.initState();
    _fetchUserData(); // Fetch user data when the page is initialized
  }

  // Function to fetch user data from Firestore
  Future<void> _fetchUserData() async {
    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.docIdUser)
          .get();
      print(userDoc);
      // Check if the document exists and get the 'name' field
      if (userDoc.exists) {
        setState(() {
          userName = userDoc['name'];
          print("username==${userName}"); // Get the name from the document
          isLoading = false;
        });
      } else {
        setState(() {
          userName = 'User not found';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        userName = 'Error fetching user';
        isLoading = false;
      });
      print('Error fetching user data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: isLoading
            ? const CircularProgressIndicator() // Show loading indicator while fetching data
            : Text(
                userName != null ? "Hi $userName" : "Hi",
                style: const TextStyle(color: Colors.black),
              ),
        backgroundColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 30, 0),
            child: IconButton(
              icon: const Icon(Icons.notifications),
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
                        prefixIcon: const Icon(Icons.search),
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
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    _buildCategoryCard(
                        context, 'General Science', 'assets/Mask Group.png'),
                    const SizedBox(width: 20),
                    _buildCategoryCard(
                        context, 'Current Affairs', 'assets/Mask Group2.png'),
                    const SizedBox(width: 20),
                    _buildCategoryCard(
                        context, 'Current Affairs', 'assets/Mask Group2.png'),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  txt('  Latest Current Affairs', context),
                  GestureDetector(
                    onTap: () {
                      // Add your desired functionality here
                    },
                    child: txt('  ', context),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Nav(
        initialIndex: 0,
        docIdUser: widget.docIdUser,
      ),
    );
  }

  Widget _buildCategoryCard(
      BuildContext context, String title, String imagePath) {
    return Container(
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
          Image.asset(imagePath, scale: 3.5),
          txt2(title, context),
        ],
      ),
    );
  }
}

Widget txt2(String text, BuildContext context, {Color color = Colors.black}) {
  return Text(
    text,
    style: TextStyle(color: color),
  );
}

Widget txt(String text, BuildContext context, {Color color = Colors.black}) {
  return Text(
    text,
    style: TextStyle(color: color),
  );
}
