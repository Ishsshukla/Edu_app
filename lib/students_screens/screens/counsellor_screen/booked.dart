import 'package:edu_app/students_screens/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Add this import for date formatting

class AppointmentConfirmationPage extends StatelessWidget {
  final String counselorName;
  final String counselorRole;
  final String profileImagePath;
  final DateTime appointmentDate;
  final String sessionMode;
  final String timeSlot;
  final String purposeOfCounseling;
  final String additionalNotes;

  AppointmentConfirmationPage({
    required this.counselorName,
    required this.counselorRole,
    required this.profileImagePath,
    required this.appointmentDate,
    required this.sessionMode,
    required this.timeSlot,
    required this.purposeOfCounseling,
    required this.additionalNotes,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Changed to white for better contrast
      
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 40),
            // Title
            Text(
              'Appointment Booked Successfully!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),

            // Profile Picture and Name
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage(profileImagePath), // Replace with the actual image path
            ),
            SizedBox(height: 10),
            Text(
              counselorName,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            Text(
              counselorRole,
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            SizedBox(height: 30),

            // Scrollable Appointment Details
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildDetailTile(Icons.calendar_today, 'Date', DateFormat('yyyy-MM-dd').format(appointmentDate)),
                    _buildDetailTile(Icons.access_time, 'Time Slot', timeSlot),
                    _buildDetailTile(Icons.video_call, 'Session Mode', sessionMode),
                    _buildDetailTile(Icons.description, 'Purpose of Counseling', purposeOfCounseling),
                    _buildDetailTile(Icons.note, 'Additional Notes', additionalNotes),
                    SizedBox(height: 30),
                  ],
                ),
              ),
            ),

            // Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              Expanded(
                child: ElevatedButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => Homepage(docIdUser: 'yourDocIdUserValue')),
                  (route) => false,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 16), // Increased padding for larger button
                  shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Go back to Home',
                  style: TextStyle(color: Colors.white, fontSize: 18), // Increased font size
                ),
                ),
              ),
              ],
            ),
            // SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailTile(IconData icon, String title, String subtitle) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 8,
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: Color(0xFF0066CC), size: 28),
          SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
                ),
                SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
