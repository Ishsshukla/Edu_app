

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ViewChapterStudent extends StatefulWidget {
  final Map<String, dynamic> courseData; // Data for the selected course

  const ViewChapterStudent({super.key, required this.courseData});
  // const ViewChapterStudent({super.key});

  @override
  State<ViewChapterStudent> createState() => _ViewChapterStudentState();
}

class _ViewChapterStudentState extends State<ViewChapterStudent> {
  // Variables to store fetched data
  String courseName = '';
  String lessonName = '';
  String youtubeLink = '';
  String notes = ''; // New variable for teacher's notes
  List<String> pdfUrls = [];
  List<String> imageUrls = [];

  @override
  void initState() {
    super.initState();
    fetchChapterData();
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> chapters = [];

 
  Future<void> fetchChapterData() async {
    try {
      String courseId =
          widget.courseData['courseId']; // Get the course document ID
      String chapterId =
          widget.courseData['chapterId']; // Get the chapter document ID

      // Access the 'chapters' subcollection of the specific course using courseId and chapterId
      DocumentSnapshot chapterSnapshot = await _firestore
          .collection('course_content')
          .doc(courseId)
          .collection('chapters')
          .doc(chapterId) // Fetch a specific chapter using chapterId
          .get();

      if (chapterSnapshot.exists) {
        var data = chapterSnapshot.data() as Map<String, dynamic>;
        print(data);

        // Extracting the relevant data and setting state
        setState(() {
          courseName = data.containsKey('courseName')
              ? data['courseName']
              : 'Unknown Course';
          lessonName = data.containsKey('lessonName')
              ? data['lessonName']
              : 'Unknown Lesson';
          youtubeLink = data.containsKey('youtubeLink')
              ? data['youtubeLink']
              : 'No YouTube Link';
          pdfUrls = data.containsKey('pdfUrls')
              ? List<String>.from(data['pdfUrls'])
              : [];
          imageUrls = data.containsKey('imageUrls')
              ? List<String>.from(data['imageUrls'])
              : [];
          notes = data.containsKey('notes')
              ? data['notes']
              : 'No Notes'; // Assuming 'notes' field exists
        });

        print(
            "Fetched Chapter Data: $courseName, $lessonName, $youtubeLink, $pdfUrls, $imageUrls, $notes");
      } else {
        print(
            "No chapter data found for courseId: $courseId and chapterId: $chapterId");
      }
    } catch (e) {
      print("Error fetching chapter data: $e");
    }
  }

  // Function to open the YouTube link
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
        title: const Text(
          "View Chapter",
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Display Chapter Name
              const Text('Course Name',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text(
                courseName,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),

              // Display Lesson Name
              const Text('Chapter Name',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text(
                lessonName,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),

              // Display YouTube Link
              const Text('Class Link (YouTube)',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: _launchYoutubeLink,
                child: Text(
                  youtubeLink.isNotEmpty ? youtubeLink : 'No YouTube Link',
                  style: const TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // Display Notes Section
              const Text('Notes',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text(
                notes.isNotEmpty ? notes : 'No Notes Provided',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 30),

              // Display Uploaded PDFs
              if (pdfUrls.isNotEmpty) ...[
                const Text(
                  "Uploaded PDFs:",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: pdfUrls.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        leading: const Icon(Icons.picture_as_pdf),
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
              const SizedBox(height: 20),

              // Display Uploaded Images
              if (imageUrls.isNotEmpty) ...[
                const Text(
                  "Uploaded Images:",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.0,
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
            ],
          ),
        ),
      ),
    );
  }
}
