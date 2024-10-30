import 'package:edu_app/students_screens/screens/counsellor_screen/book_appointment.dart';
import 'package:flutter/material.dart';

class HomeStudentCounsellor extends StatefulWidget {
  final String docIdUser;
  const HomeStudentCounsellor({super.key, required this.docIdUser});
  @override
  _HomeStudentCounsellorState createState() => _HomeStudentCounsellorState();
}

class _HomeStudentCounsellorState extends State<HomeStudentCounsellor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50], // Set the background color to light grey
      appBar: AppBar(
        title: Text(
          'Academic & Career Counseling',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(16),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Search Bar
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search counselors or topics',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 10.0),
                ),
              ),
              const SizedBox(height: 20),

              // 1-on-1 Counseling Section
              Card(
                color: Colors.white, // Set the card color to white
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '1-on-1 Counseling',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 19,
                              ),
                            ),
                            const SizedBox(height: 4),
                            RichText(
                              text: TextSpan(
                                text: 'Personalized guidance for your',
                                style: TextStyle(color: Colors.grey[700]),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: ' career path.',
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => BookAppointmentPage(docIdUser: widget.docIdUser,)),
                                  );
                                },
                                child: Text(
                                  'Book Now',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 16),
                      Container(
                        width: 130,
                        height: 145,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.asset(
                            'assets/counseeling.png', // Corrected the path
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Schedule Your Session Tabs
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    FilterChip(
                      label: Text('Sainik School', style: TextStyle(color: Colors.black)),
                      onSelected: (_) {},
                      backgroundColor: Colors.white,
                    ),
                    SizedBox(width: 8),
                    FilterChip(
                      label: Text('RIMC', style: TextStyle(color: Colors.black)),
                      onSelected: (_) {},
                      backgroundColor: Colors.white,
                    ),
                    SizedBox(width: 8),
                    FilterChip(
                      label: Text('GURUKUL', style: TextStyle(color: Colors.black)),
                      onSelected: (_) {},
                      backgroundColor: Colors.white,
                    ),
                    SizedBox(width: 8),
                    FilterChip(
                      label: Text('RMS', style: TextStyle(color: Colors.black)),
                      onSelected: (_) {},
                      backgroundColor: Colors.white,
                    ),
                    SizedBox(width: 8),
                    FilterChip(
                      label: Text('RAI SPORTS', style: TextStyle(color: Colors.black)),
                      onSelected: (_) {},
                      backgroundColor: Colors.white,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Meet Our Counselors Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Meet Our Counselor',
                    style: TextStyle(
                      fontSize: 20, // Slightly larger font size for emphasis
                      fontWeight: FontWeight.bold,
                      color: Colors.black87, // Use a color that matches the theme
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                elevation: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(12.0)),
                      child: Image.asset(
                        'assets/director.jpg',
                        height: 180,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Director and Founder, SCF Academy',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Specialized in Sainik School, RIMC ,Military School, RMS & NDA Preparation',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
