import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ViewChapterStudent extends StatefulWidget {
  final Map<String, dynamic> courseData; // Data for the selected course

  const ViewChapterStudent({super.key, required this.courseData});

  @override
  State<ViewChapterStudent> createState() => _ViewChapterStudentState();
}

class _ViewChapterStudentState extends State<ViewChapterStudent> {
  // Variables to store fetched data
  String courseName = '';
  String lessonName = '';
  String youtubeLink = '';
  List<String> pdfUrls = [];
  List<String> imageUrls = [];

  @override
  void initState() {
    super.initState();
    fetchCourses();
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> fetchCourses() async {
    try {
      String selectedCourseName = widget.courseData['courseName'];
      String selectedLessonName = widget.courseData['lessonName'];

      QuerySnapshot snapshot = await _firestore
          .collection('course_content')
          .where('courseName', isEqualTo: selectedCourseName)
          .where('lessonName', isEqualTo: selectedLessonName)
          .get();

      if (snapshot.docs.isNotEmpty) {
        var data = snapshot.docs.first.data() as Map<String, dynamic>;

        setState(() {
          courseName = data.containsKey('courseName') ? data['courseName'] : 'Unknown Course';
          lessonName = data.containsKey('lessonName') ? data['lessonName'] : 'Unknown Lesson';
          youtubeLink = data.containsKey('youtubeLink') ? data['youtubeLink'] : 'No YouTube Link';
          
          pdfUrls = data.containsKey('pdfUrls') ? List<String>.from(data['pdfUrls']) : [];
          imageUrls = data.containsKey('imageUrls') ? List<String>.from(data['imageUrls']) : [];
        });
      } else {
        print("No matching course content found.");
      }
    } catch (e) {
      print("Error fetching courses: $e");
    }
  }

/// Function to open the YouTube link
Future<void> _launchYoutubeLink() async {
  // Ensure the YouTube link is not empty
  if (youtubeLink.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('No YouTube link available')),
    );
    return;
  }

  // Trim any extra spaces
  final trimmedLink = youtubeLink.trim();

  // Ensure the link is properly formatted with http/https
  if (!trimmedLink.startsWith('http://') && !trimmedLink.startsWith('https://')) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Invalid YouTube URL format')),
    );
    return;
  }

  // Try parsing the trimmed URL
  final Uri? youtubeUri = Uri.tryParse(trimmedLink);

  // Check if the URL is valid and can be launched
  if (youtubeUri != null && await canLaunchUrl(youtubeUri)) {
    await launchUrl(
      youtubeUri,
      mode: LaunchMode.externalApplication, // Opens in the YouTube app or browser
    );
  } else {
    // Show error if the URL cannot be launched
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Could not launch YouTube URL')),
    );
  }
}




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'View Chapter',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Section (without percentage card)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Card(
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                shadowColor: Colors.blueAccent.withOpacity(0.4),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.blueAccent.shade100, Colors.blue.shade400],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          courseName.isNotEmpty ? courseName : 'Course Name',
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          lessonName.isNotEmpty ? lessonName : 'Lesson Name',
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Interactive Sections
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Video Card
                  _buildInteractiveCard(
                    icon: Icons.play_circle_fill,
                    title: 'Watch Lecture',
                    subtitle: 'Click to watch the lecture video',
                    onTap: _launchYoutubeLink,
                  ),
                  const SizedBox(height: 20),

                  // Study Materials Section
                  const Text(
                    'Study Materials',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),

                
// PDFs Section with only the file name (excluding the URL and file extension)
if (pdfUrls.isNotEmpty)
  ...pdfUrls.map(
    (pdfUrl) {
      // Extract the file name from the PDF URL
      String pdfNameWithExtension = pdfUrl.split('/').last;

      // Decode any URL-encoded components (e.g., %2F to /, %20 to space)
      String decodedPdfNameWithExtension = Uri.decodeComponent(pdfNameWithExtension);

      // Remove the file extension (.pdf) to just show the name
      String pdfName = decodedPdfNameWithExtension.split('.').first;

      return Card(
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: ListTile(
          leading: const Icon(Icons.picture_as_pdf, color: Colors.blueAccent),
          title: Text(pdfName), // Show the extracted file name (without extension)
          onTap: () async {
            await launchUrl(Uri.parse(pdfUrl));
          },
        ),
      );
    },
  ).toList(),



                  const SizedBox(height: 20),

                  // Images Grid
                  if (imageUrls.isNotEmpty)
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: imageUrls.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () async {
                            await launchUrl(Uri.parse(imageUrls[index]));
                          },
                          child: Image.network(
                            imageUrls[index],
                            fit: BoxFit.cover,
                          ),
                        );
                      },
                    ),
                ],
              ),
            ),

            // Bottom Action Button (Start Course)
            // const SizedBox(height: 30),
            // Padding(
            //   padding: const EdgeInsets.all(20.0),
            //   child: Center(
            //     child: ElevatedButton(
            //       onPressed: () {},
            //       style: ElevatedButton.styleFrom(
            //         padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 100), backgroundColor: Colors.blue,
            //         shape: RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(10),
            //         ),
            //       ),
            //       child: const Text(
            //         'Start Course',
            //         style: TextStyle(fontSize: 18, color: Colors.white),
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),

      // Floating Action Button
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Action for quiz or next step
        },
        icon: const Icon(Icons.quiz),
        label: const Text("Take Quiz"),
        backgroundColor: Colors.blueAccent,
      ),
    );
  }

  // Custom Interactive Card Builder
  Widget _buildInteractiveCard({
    required IconData icon,
    required String title,
    required String subtitle,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: ListTile(
          leading: Icon(icon, size: 40, color: Colors.blueAccent),
          title: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          subtitle: Text(subtitle, style: const TextStyle(fontSize: 16, color: Colors.black54)),
        ),
      ),
    );
  }
}
