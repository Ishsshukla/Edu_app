import 'package:edu_app/teacher_side/navbar.dart';
import 'package:edu_app/teacher_side/screens/counsellor_screens/details_counsling.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// import 'package:edu_app/teacher_side/screens/counsellor_screens/appointment_request.dart';

class AppointmentRequest {
  final String docidUser;
  final String studentName;
  final DateTime appointmentDate;
  final String timeSlot;
  final String sessionMode;
  final String purposeOfCounseling;
  final String additionalNotes;
  final String batch;
  final String studentClass;
  final String profileImageUrl;

  AppointmentRequest({
    required this.docidUser,
    required this.studentName,
    required this.appointmentDate,
    required this.timeSlot,
    required this.sessionMode,
    required this.purposeOfCounseling,
    required this.additionalNotes,
    required this.batch,
    required this.studentClass,
    required this.profileImageUrl,
  });
}

class TeacherCounselingPage extends StatelessWidget {
  final List<AppointmentRequest> requests;

  TeacherCounselingPage({required this.requests});

  Widget _buildAppointmentCard(BuildContext context, AppointmentRequest request) {
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
                builder: (context) => AppointmentDetailPage(request: request),
              ),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
            child: Text('View Request', style: TextStyle(color: Colors.white)),
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
        title: Text('Counseling Requests', style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xFF0066CC),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
        color: Colors.grey[100],
        child: ListView.builder(
          itemCount: requests.length,
          itemBuilder: (context, index) {
            return _buildAppointmentCard(context, requests[index]);
          },
        ),
      ),
      bottomNavigationBar: NavTeacher(
        initialIndex: 3,
        docidUser: '123', // Replace with actual docidUser
      ),
    );
  }
}
