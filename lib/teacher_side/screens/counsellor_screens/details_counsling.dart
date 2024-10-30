import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_app/teacher_side/screens/counsellor_screens/counsling_req.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppointmentDetailPage extends StatefulWidget {
  final String docid;

  AppointmentDetailPage({required this.docid});

  @override
  _AppointmentDetailPageState createState() => _AppointmentDetailPageState();
}

class _AppointmentDetailPageState extends State<AppointmentDetailPage> {
  late DocumentSnapshot appointmentData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchAppointmentData();
  }

  Future<void> _fetchAppointmentData() async {
    try {
      final docSnapshot = await FirebaseFirestore.instance
          .collection('counselors')
          .doc(widget.docid)
          .get();
      setState(() {
        appointmentData = docSnapshot;
        print("===============================$appointmentData");
        isLoading = false;
      });
    } catch (e) {
      print("Error fetching data: $e");
    }
  }

  void _modifyAppointment(BuildContext context) async {
    DateTime? newDate = (appointmentData['date'] as Timestamp).toDate();
    String newTimeSlot = appointmentData['slot'];
    String newSessionMode = appointmentData['mode'];

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Text(
            'Modify Appointment',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
          ),
          content: SingleChildScrollView(
            child: Column(
              children: [
                ListTile(
                  title: Text(
                    'Date: ${DateFormat('dd MMM yyyy').format(newDate!)}',
                    style: TextStyle(color: Colors.black87),
                  ),
                  trailing: Icon(Icons.calendar_today, color: Colors.blue),
                  onTap: () async {
                    final DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: newDate,
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2101),
                    );
                    if (pickedDate != null && pickedDate != newDate)
                      newDate = pickedDate;
                  },
                ),
                Divider(),
                ListTile(
                  title: Text(
                    'Time Slot: $newTimeSlot',
                    style: TextStyle(color: Colors.black87),
                  ),
                  trailing: Icon(Icons.access_time, color: Colors.blue),
                  onTap: () {
                    _showTimeSlotDialog(context, (selectedTimeSlot) {
                      newTimeSlot = selectedTimeSlot;
                    });
                  },
                ),
                Divider(),
                ListTile(
                  title: Text(
                    'Session Mode: $newSessionMode',
                    style: TextStyle(color: Colors.black87),
                  ),
                  trailing: Icon(Icons.video_call, color: Colors.blue),
                  onTap: () {
                    _showSessionModeDialog(context, (selectedMode) {
                      newSessionMode = selectedMode;
                    });
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                await FirebaseFirestore.instance
                    .collection('counselors')
                    .doc(widget.docid)
                    .update({
                  'date': newDate,
                  'slot': newTimeSlot,
                  'mode': newSessionMode,
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Appointment modified successfully.')),
                );
                Navigator.of(context).pop();
                setState(() {
                  _fetchAppointmentData(); // Refresh data after update
                });
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child:
                  Text('Save Changes', style: TextStyle(color: Colors.white)),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              style: TextButton.styleFrom(
                backgroundColor: Colors.grey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text('Cancel', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  void _showTimeSlotDialog(BuildContext context, Function(String) onSelected) {
    final List<String> timeSlots = [
      '10 AM - 12 PM',
      '1 PM - 3 PM',
      '4 PM - 6 PM'
    ];
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Text('Select Time Slot',
              style: TextStyle(fontWeight: FontWeight.bold)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: timeSlots.map((slot) {
              return ListTile(
                title: Text(slot),
                onTap: () {
                  onSelected(slot);
                  Navigator.of(context).pop(); // Close the dialog
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }

  void _showSessionModeDialog(
      BuildContext context, Function(String) onSelected) {
    final List<String> sessionModes = ['Video Call', 'In-Person', 'Phone Call'];
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Text('Select Session Mode',
              style: TextStyle(fontWeight: FontWeight.bold)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: sessionModes.map((mode) {
              return ListTile(
                title: Text(mode),
                onTap: () {
                  onSelected(mode);
                  Navigator.of(context).pop(); // Close the dialog
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      appBar: AppBar(
        title:
            Text('Appointment Details', style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xFF0066CC),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      image: AssetImage('assets/CoursePreview.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        appointmentData['name'],
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      // Text('Batch: ${appointmentData['batch'] ?? ''}'),
                      // Text('Class: ${appointmentData['studentClass'] ?? ''}'),
                      Text('Batch:  '),
                      Text('Class:  '),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            _buildDetailCard(
                Icons.calendar_today,
                'Date',
                DateFormat('dd MMM yyyy')
                    .format((appointmentData['date'] as Timestamp).toDate())),
            _buildDetailCard(
                Icons.access_time, 'Time Slot', appointmentData['slot']),
            _buildDetailCard(
                Icons.video_call, 'Session Mode', appointmentData['mode']),
            _buildDetailCard(
                Icons.description, 'Purpose', appointmentData['description']),
            _buildDetailCard(Icons.note, 'Additional Notes',
                appointmentData['additionalNotes']),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  child: Text('Accept',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                ),
                ElevatedButton(
                  onPressed: () => _modifyAppointment(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  child: Text('Modify', style: TextStyle(color: Colors.white)),
                ),
                ElevatedButton(
                  onPressed: () {},
                  //  _declineAppointment(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  child: Text('Decline',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailCard(IconData icon, String title, String subtitle) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      elevation: 4,
      child: ListTile(
        leading: Icon(icon, color: Colors.blue),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
      ),
    );
  }
}
