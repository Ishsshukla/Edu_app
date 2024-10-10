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
  String courseName = '';
  String lessonName = '';
  String youtubeLink = '';
  String notes = '';
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
          courseName = data['courseName'] ?? 'Unknown Course';
          lessonName = data['lessonName'] ?? 'Unknown Lesson';
          youtubeLink = data['youtubeLink'] ?? 'No YouTube Link';
          pdfUrls = data.containsKey('pdfUrls') ? List<String>.from(data['pdfUrls']) : [];
          imageUrls = data.containsKey('imageUrls') ? List<String>.from(data['imageUrls']) : [];
          notes = data['notes'] ?? 'No Notes';
        });
      } else {
        print("No matching course content found");
      }
    } catch (e) {
      print("Error fetching courses: $e");
    }
  }

  Future<void> _launchYoutubeLink() async {
    if (await canLaunchUrl(Uri.parse(youtubeLink))) {
      await launchUrl(Uri.parse(youtubeLink));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid YouTube URL')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("View Chapter", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Chapter Name Section
            _buildSectionHeader('Chapter Name'),
            _buildSectionContent(courseName),

            _buildSectionHeader('Topic Name'),
            _buildSectionContent(lessonName),

            _buildSectionHeader('Class Link (YouTube)'),
            GestureDetector(
              onTap: _launchYoutubeLink,
              child: Text(
                youtubeLink.isNotEmpty ? youtubeLink : 'No YouTube Link',
                style: const TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
              ),
            ),

            _buildSectionHeader('Notes'),
            _buildSectionContent(notes.isNotEmpty ? notes : 'No Notes Provided'),

            if (pdfUrls.isNotEmpty) _buildPdfSection(),

            if (imageUrls.isNotEmpty) _buildImageSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
      ),
    );
  }

  Widget _buildSectionContent(String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Text(
        content,
        style: const TextStyle(fontSize: 16, color: Colors.black54),
      ),
    );
  }

  Widget _buildPdfSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('Uploaded PDFs'),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: pdfUrls.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                leading: const Icon(Icons.picture_as_pdf, color: Colors.red),
                title: Text('PDF File ${index + 1}'),
                trailing: IconButton(
                  icon: const Icon(Icons.download),
                  onPressed: () async {
                    await launchUrl(Uri.parse(pdfUrls[index]));
                  },
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildImageSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('Uploaded Images'),
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
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  imageUrls[index],
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
