import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:file_picker/file_picker.dart'; // Import file_picker package
import 'package:image_picker/image_picker.dart'; // For Images
import 'dart:io';

import '../../components/review_componemt.dart'; // For File operations

class EditCourseContentTeacher extends StatefulWidget {
  const EditCourseContentTeacher({Key? key}) : super(key: key);

  @override
  State<EditCourseContentTeacher> createState() =>
      _EditCourseContentTeacherState();
}

class _EditCourseContentTeacherState extends State<EditCourseContentTeacher> {
  // Controller to store the YouTube link
  final TextEditingController _youtubeLinkController = TextEditingController();

  // Variables to store picked file information
  File? _pickedPdfFile;
  List<File> _pickedImageFiles = [];

  // Function to open the YouTube link
  Future<void> _launchYoutubeLink() async {
    final url = _youtubeLinkController.text;
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid YouTube URL')),
      );
    }
  }

  // Function to pick PDF file
  Future<void> _pickPdfFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'], // Only allow PDF files
    );
    if (result != null && result.files.single.path != null) {
      setState(() {
        _pickedPdfFile = File(result.files.single.path!);
      });
    }
  }

  // Function to pick images
  Future<void> _pickImageFiles() async {
    final pickedFiles = await ImagePicker().pickMultiImage();
    if (pickedFiles != null) {
      setState(() {
        _pickedImageFiles =
            pickedFiles.map((pickedFile) => File(pickedFile.path)).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar: NavTeacher(initialIndex: 1),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 60, 20, 0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 180, 0),
                child: txt('Class/Course Name', context),
              ),
              editabletxtforteacher('Write Class/Course Name', context),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(right: 225),
                child: txt('Lesson Name', context),
              ),
              editabletxtforteacher('Write Lesson Name', context),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(right: 195),
                child: txt('Link of the Class', context),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: TextField(
                  controller: _youtubeLinkController,
                  decoration: InputDecoration(
                    hintText: 'Paste the Link Of Class Here',
                    suffixIcon: IconButton(
                      icon:
                          const Icon(Icons.play_circle_fill, color: Colors.red),
                      onPressed: _launchYoutubeLink,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.only(right: 240),
                child: txt('Upload Notes', context),
              ),
              const SizedBox(height: 10),
              // Button for picking PDFs
              ElevatedButton.icon(
                onPressed: _pickPdfFile,
                icon: const Icon(Icons.picture_as_pdf, color: Colors.white),
                label: const Text("Upload PDF"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 243, 191, 33),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              // Button for picking images
              ElevatedButton.icon(
                onPressed: _pickImageFiles,
                icon: const Icon(Icons.image, color: Colors.white),
                label: const Text("Upload Images"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Display the selected PDF file
              if (_pickedPdfFile != null) ...[
                const Text(
                  "Selected PDF:",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.picture_as_pdf, color: Colors.red),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          _pickedPdfFile!.path.split('/').last,
                          style: const TextStyle(
                              color: Colors.black, fontSize: 16),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          setState(() {
                            _pickedPdfFile = null;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
              const SizedBox(height: 10),
              // Display the selected image files
              if (_pickedImageFiles.isNotEmpty) ...[
                const Text(
                  "Selected Images:",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: _pickedImageFiles.length,
                  itemBuilder: (context, index) {
                    return Stack(
                      children: [
                        Image.file(
                          _pickedImageFiles[index],
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                        Positioned(
                          right: 0,
                          child: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              setState(() {
                                _pickedImageFiles.removeAt(index);
                              });
                            },
                          ),
                        ),
                      ],
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
