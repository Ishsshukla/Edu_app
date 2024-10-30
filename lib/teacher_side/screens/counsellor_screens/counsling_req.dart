import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_app/teacher_side/navbar.dart';
import 'package:edu_app/teacher_side/screens/counsellor_screens/details_counsling.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppointmentRequest {
  final String docid;
  final String studentName;
  // final DateTime appointmentDate;
  final String timeSlot;
  final String sessionMode;
  final String purposeOfCounseling;
  final String additionalNotes;
  final String batch;
  final String studentClass;
  final String profileImageUrl;

  AppointmentRequest({
    required this.docid,
    required this.studentName,
    // required this.appointmentDate,
    required this.timeSlot,
    required this.sessionMode,
    required this.purposeOfCounseling,
    required this.additionalNotes,
    required this.batch,
    required this.studentClass,
    required this.profileImageUrl,
  });

  // Factory method to create AppointmentRequest from Firestore document
  factory AppointmentRequest.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    print(
        "=============$data");
    return AppointmentRequest(
      docid: doc.id,
      studentName: data['name'] ?? '',
      // appointmentDate: (data['appointmentDate'] as Timestamp).toDate(),
      timeSlot: data['slot'],
      sessionMode: data['mode'] ?? '',
      purposeOfCounseling: data['description'] ?? '',
      additionalNotes: data['additionalNotes'] ?? '',
      batch: data['batch'] ?? '',
      studentClass: data['studentClass'] ?? '',
      profileImageUrl: data['profileImageUrl'] ?? '',
    );
  }
}

class TeacherCounselingPage extends StatelessWidget {
  Future<List<AppointmentRequest>> _fetchCounselingRequests() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('counselors').get();
    return snapshot.docs
        .map((doc) => AppointmentRequest.fromFirestore(doc))
        .toList();
  }

  Widget _buildAppointmentCard(
      BuildContext context, AppointmentRequest request) {
    return Card(
      color: Colors.white,
      shadowColor: Colors.grey,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 130,
              height: 140,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: AssetImage('assets/CoursePreview.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 26),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    request.studentName,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text('Batch: ${request.batch}'),
                  SizedBox(height: 4),
                  Text('Class: ${request.studentClass}'),
                  SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              AppointmentDetailPage(docid: request.docid),
                        ),
                      );
                    },
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                    child: Text('View Request',
                        style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Counseling Requests'),
        backgroundColor: Color(0xFF0066CC),
      ),
      body: FutureBuilder<List<AppointmentRequest>>(
        future: _fetchCounselingRequests(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No counseling requests found.'));
          }
          final requests = snapshot.data!;
          return ListView.builder(
            itemCount: requests.length,
            itemBuilder: (context, index) =>
                _buildAppointmentCard(context, requests[index]),
          );
        },
      ),
      bottomNavigationBar: NavTeacher(
        initialIndex: 3,
        docidUser: '123',
      ),
    );
  }
}
