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
      
      body: SingleChildScrollView(
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

            // Appointment Details
            _buildDetailTile(Icons.calendar_today, 'Date', DateFormat('yyyy-MM-dd').format(appointmentDate)),
            _buildDetailTile(Icons.access_time, 'Time Slot', timeSlot),
            _buildDetailTile(Icons.video_call, 'Session Mode', sessionMode),
            _buildDetailTile(Icons.description, 'Purpose of Counseling', purposeOfCounseling),
            _buildDetailTile(Icons.note, 'Additional Notes', additionalNotes),
            SizedBox(height: 30),

            // Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[300],
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Home',
                    style: TextStyle(color: Colors.black87, fontSize: 16),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Navigate to Details or another page if needed
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF0066CC),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Details',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
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
