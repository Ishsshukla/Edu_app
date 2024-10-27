import 'package:edu_app/students_screens/counsellor_screen/booked.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BookAppointmentPage extends StatefulWidget {
  @override
  _BookAppointmentPageState createState() => _BookAppointmentPageState();
}

class _BookAppointmentPageState extends State<BookAppointmentPage> {
  final _purposeController = TextEditingController();
  final _notesController = TextEditingController();

  DateTime? _selectedDate;
  String? _selectedMode;
  String? _selectedTimeSlot; 

  @override
  void dispose() {
    _purposeController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _bookAppointment() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Appointment booked successfully')),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Color(0xFF0066CC), // Header background color
              onPrimary: Colors.white, // Header text color
              onSurface: Colors.black, // Body text color
            ),
            dialogBackgroundColor: Colors.white, // Background color of the calendar dialog
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Widget _buildSection({required String title, required Widget child}) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black87),
          ),
          SizedBox(height: 10),
          child,
        ],
      ),
    );
  }
  
  Widget _buildSectionTime({required String title, required Widget child}) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black87),
          ),
          SizedBox(height: 10),
          child,
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300], // Light grey background with 30% opacity
      appBar: AppBar(
        title: Text(
          'Counseling Appointment',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF0066CC), // Blue primary color
        iconTheme: IconThemeData(color: Colors.white), // Back icon color
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Profile Section
                  Container(
                    width: double.infinity, // Cover horizontal completely
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    padding: EdgeInsets.all(16),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: AssetImage('assets/director.jpg'), // Replace with actual image path
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Mr Pradeep Rajoriya',
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Director & Founder, SCF Academy',
                          style: TextStyle(color: Colors.grey[600], fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),

                 // Date Picker Section
                  _buildSection(
                    title: 'Select Date',
                    child: InkWell(
                      onTap: () => _selectDate(context),
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 2,
                              blurRadius: 5,
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(Icons.calendar_month, color: Color(0xFF0066CC)),
                            Text(
                              _selectedDate == null
                                  ? 'Choose Date'
                                  : DateFormat('dd MMM yyyy').format(_selectedDate!),
                              style: TextStyle(fontSize: 16, color: Color(0xFF0066CC)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                 
                    SizedBox(height: 20),
                    // Time Slot Dropdown
                  _buildSectionTime(
                    title: 'Select Time Slot',
                    child: DropdownButtonFormField<String>(
                      value: _selectedTimeSlot, // Use the new variable here
                      hint: Text('Select Time Slot'),
                      items: <String>['10 AM - 12 PM', '2 PM - 5 PM', '7 PM - 9 PM']
                          .map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedTimeSlot = newValue; // Update the new variable
                        });
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      dropdownColor: Colors.white, // Set dropdown background color to white
                    ),
                  ),
                  SizedBox(height: 20),

                  // Call Mode Dropdown
                  _buildSection(
                    title: 'Mode of Call',
                    child: DropdownButtonFormField<String>(
                      value: _selectedMode,
                      hint: Text('Select Mode'),
                      items: <String>['Video Call', 'Voice Call', 'Chat Only']
                          .map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Row(
                            children: [
                              Icon(
                                value == 'Video Call'
                                    ? Icons.video_call
                                    : value == 'Voice Call'
                                        ? Icons.call
                                        : Icons.chat,
                                color: Color(0xFF0066CC),
                              ),
                              SizedBox(width: 8),
                              Text(value),
                            ],
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedMode = newValue;
                        });
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      dropdownColor: Colors.white, // Set dropdown background color to white
                    ),
                  ),
                  SizedBox(height: 20),

                  // Purpose of Counseling
                  _buildSection(
                    title: "Student's Purpose of Counseling",
                    child: TextField(
                      controller: _purposeController,
                      decoration: InputDecoration(
                        hintText: 'e.g., Assistance with exam strategy for SAT preparation.',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      maxLines: 3,
                    ),
                  ),
                  SizedBox(height: 20),

                  // Additional Notes
                  _buildSection(
                    title: 'Additional Notes for Counselor',
                    child: TextField(
                      controller: _notesController,
                      decoration: InputDecoration(
                        hintText: 'Any special requests or additional details.',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      maxLines: 3,
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
          // Fixed Cancel and Confirm Buttons at the Bottom
          Container(
            padding: const EdgeInsets.all(14.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 10,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Cancel Button
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(color: Color(0xFF0066CC), width: 2),
                    ),
                  ),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                      color: Color(0xFF0066CC),
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),
                // Confirm Button
                ElevatedButton(
                  onPressed: () {
                    if (_selectedDate == null || _selectedMode == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Please select date and session mode.')),
                      );
                      return; // Exit early if values are not selected
                    }

                    _bookAppointment();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                      builder: (context) => AppointmentConfirmationPage(
                        counselorName: 'Mr Pradeep Rajoriya',
                        counselorRole: 'Director & Founder, SCF Academy',
                        profileImagePath: 'assets/director.jpg',
                        appointmentDate: _selectedDate!,
                        sessionMode: _selectedMode!,
                        timeSlot: _selectedTimeSlot!, // Added time slot
                        purposeOfCounseling: _purposeController.text,
                        additionalNotes: _notesController.text,
                      ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0066CC),
                    elevation: 5,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Confirm',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
