import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
// import 'package:untitled1/ui/auth/login_screen.dart';
// import 'package:untitled1/ui/firebase_firestore/fire_store_list.dart';
// import 'package:untitled1/ui/firebase_firestore/inser_fire_store.dart';
// import 'package:untitled1/utils/utils.dart';

import '../students_screens/auth/login.dart';
import '../students_screens/utils/utils.dart';
import 'inser_fire_store.dart';



class ShowFireStorePostScreen extends StatefulWidget {
  const ShowFireStorePostScreen({super.key});

  @override
  State<ShowFireStorePostScreen> createState() => _ShowFireStorePostScreenState();
}

class _ShowFireStorePostScreenState extends State<ShowFireStorePostScreen> {

  final auth = FirebaseAuth.instance ;
  final ref = FirebaseDatabase.instance.ref('Post');

  final  fireStore = FirebaseFirestore.instance.collection('users').snapshots();

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post'),
        actions: [
          IconButton(onPressed: (){
            auth.signOut().then((value){
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()));
            }).onError((error, stackTrace){
              Utils().toastMessage(error.toString());
            });
          }, icon: const Icon(Icons.logout_outlined),),
          const SizedBox(width: 10,)
        ],
      ),
      body: Column(
        children: [
          StreamBuilder<QuerySnapshot>(
            stream: fireStore,
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Text("Loading");
              }

              return Expanded(
                child: ListView(
                  children: snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                    return ListTile(
                      title: Text(data['full_name'].toString()),
                      subtitle: Text(data['company']),
                      onTap: (){

                        users
                            .doc(data['id'].toString())
                            .delete()
                            .then((value) => print("User Updated"))
                            .catchError((error) => print("Failed to update user: $error"));
                        users
                            .doc(data['id'].toString())
                            .update(
                            {
                              'full_name': 'Asif Taj'
                            })
                            .then((value) => print("User Updated"))
                            .catchError((error) => print("Failed to update user: $error"));
                      },
                    );
                  }).toList(),
                ),
              );
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => const InsertFireStoreScreen()));
        } ,
        child: const Icon(Icons.add),
      ),
    );
  }
}