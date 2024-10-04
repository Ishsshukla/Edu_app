import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DatabaseMethods {
  Future<void> updateUserDetails(
      Map<String, dynamic> userInfoMap, String userId) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(userId) // Use the user ID as the document ID
        .set(
            userInfoMap,
            SetOptions(
                merge: true)); // Use merge option to update existing data
  }

  Future<DocumentSnapshot> getthisUserInfo(String userId) async {
    // Implement your logic to fetch user data from Firestore based on userId
    // Example:
    var userData =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();

    return userData;
  }
}





  // Future<void> updateUserData( UserModel user) async {
       
  // }

  // Future<void> deleteUserData(String id) async {
  //   return await FirebaseFirestore.instance
  //       .collection("users")
  //       .doc(id)
  //       .delete();
  // }

