import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:edu_app/teacher_side/navbar.dart';
import 'package:edu_app/teacher_side/screens/Edit_course.dart';

class CoursePageTeacher extends StatefulWidget {
  final String docidUser;
  const CoursePageTeacher({super.key, required this.docidUser});

  @override
  State<CoursePageTeacher> createState() => _CoursePageTeacherState();
}

class _CoursePageTeacherState extends State<CoursePageTeacher> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> courses = [];
  List<Map<String, dynamic>> filteredCourses = []; // Filtered list of courses
  bool _isLoading = false; // To manage loading state
  String searchQuery = ''; // Track search query

  @override
  void initState() {
    super.initState();
    fetchCourses(); // Directly call fetchCourses here
  }

  // Fetch courses from Firestore
  Future<void> fetchCourses() async {
    if (mounted) {
      if (!_isLoading) {
        setState(() {
          _isLoading = true;
        });
      }
    }

    try {
      QuerySnapshot snapshot = await _firestore.collection('course_content').get();
      List<Map<String, dynamic>> fetchedCourses = snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return {
          'docId': doc.id,
          'img': 'assets/CoursePreview.png',
          'name': data.containsKey('courseName') ? data['courseName'] : 'Unknown Course',
          'description': data.containsKey('description') ? data['description'] : 'No description available',
        };
      }).toList();

      if (mounted) {
        setState(() {
          courses = fetchedCourses;
          filteredCourses = fetchedCourses;
          _isLoading = false;
        });
      }
    } catch (e) {
      print("Error fetching courses: $e");
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  // Add a new course to Firestore
  Future<void> _addCourse(String courseName) async {
    setState(() {
      _isLoading = true; // Show loader when saving the course
    });

    try {
      await _firestore.collection('course_content').add({
        'courseName': courseName, // Adding courseName to Firestore
      });

      // Fetch the updated course list after adding the new course
      await fetchCourses();
    } catch (e) {
      print("Error adding course: $e");
      setState(() {
        _isLoading = false; // Hide loader in case of error
      });
    }
  }

  // Show dialog to add a new course
  void _showAddCourseDialog() {
    String newCourseName = '';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Add New Course',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) {
                  newCourseName = value;
                },
                decoration: InputDecoration(
                  labelText: 'Course Name',
                  hintText: 'Enter the name of the course',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 0),
            ],
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Cancel',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    if (newCourseName.isNotEmpty) {
                      _addCourse(newCourseName); // Save the course in Firestore
                      Navigator.pop(context); // Close the dialog
                    }
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Add '),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: const Color(0xFF4A90E2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  // Function to filter courses based on the search query
  void _filterCourses(String query) {
    // Use WidgetsBinding to ensure the setState is called after the current frame is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        List<Map<String, dynamic>> searchResults = courses.where((course) {
          final courseName = course['name']!.toLowerCase();
          final searchLower = query.toLowerCase();
          return courseName.contains(searchLower);
        }).toList();
        filteredCourses = searchResults;
        searchQuery = query;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Courses",
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
            child: IconButton(
              icon: const Icon(Icons.search_rounded, color: Colors.black),
              onPressed: () {
                // Open search input in the AppBar
                showSearch(
                  context: context,
                  delegate: CourseSearchDelegate(courses, _filterCourses),
                );
              },
            ),
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: const Color(0xFFF5F5F5),
      bottomNavigationBar: NavTeacher(initialIndex: 1, docidUser: widget.docidUser),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator()) // Show loading spinner when fetching or saving data
          : SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                child: Column(
                  children: courses.map((course) {
                    return crstxtforTeacherData(
                      course['img']!,
                      course['name']!,
                      context,
                      course,
                      screenWidth,
                    );
                  }).toList(),
                ),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddCourseDialog(); // Show the dialog to add a course
        },
        backgroundColor: const Color(0xFF4A90E2),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

// Custom Search Delegate
class CourseSearchDelegate extends SearchDelegate {
  final List<Map<String, dynamic>> courses;
  final Function(String) onSearch;

  CourseSearchDelegate(this.courses, this.onSearch);

  @override
  String get searchFieldLabel => 'Search courses';

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = ''; // Clear the search query
          onSearch(query); // Refresh the search
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null); // Close the search delegate
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    onSearch(query); // Perform the search with the query
    return _buildCourseList(); // Display the filtered courses
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    onSearch(query); // Update suggestions as the user types
    return _buildCourseList(); // Display the filtered courses
  }

  Widget _buildCourseList() {
    final filteredCourses = courses.where((course) {
      final courseName = course['name']!.toLowerCase();
      final searchLower = query.toLowerCase();
      return courseName.contains(searchLower);
    }).toList();

    if (filteredCourses.isEmpty) {
      return Center(
        child: Text(
          'No course found',
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      );
    }

    return ListView.builder(
      itemCount: filteredCourses.length,
      itemBuilder: (context, index) {
        final course = filteredCourses[index];
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: crstxtforTeacherData(
            course['img']!,
            course['name']!,
            context,
            course,
            MediaQuery.of(context).size.width,
          ),
        );
      },
    );
  }
}

// Widget to display course data
/// A widget that displays a course item for the teacher's data.
/// 
/// The widget includes an image, text, and additional course data, 
/// and it is styled with padding, a white background, rounded corners, 
/// and a shadow effect.

Widget crstxtforTeacherData(
  String img,
  String text,
  BuildContext context,
  Map<String, dynamic> courseData,
  double screenWidth,
) {
  return Padding(
    padding: EdgeInsets.fromLTRB(screenWidth * 0.05, screenWidth * 0.05, screenWidth * 0.05, screenWidth * 0.04),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        // Padding inside the container
        padding: EdgeInsets.fromLTRB(screenWidth * 0.03, screenWidth * 0.03, screenWidth * 0.03, screenWidth * 0.02),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(img, scale: screenWidth * 0.03),
            SizedBox(width: screenWidth * 0.04),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    // Padding around the course name text
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: Text(
                      text,
                      style: TextStyle(
                        fontSize: screenWidth * 0.05,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(height: screenWidth * 0.09),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditCourseDescriptionpage(courseData: courseData),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 3,
                      // Padding inside the button
                      padding: EdgeInsets.symmetric(vertical: screenWidth * 0.03, horizontal: screenWidth * 0.06),
                      backgroundColor: const Color(0xFF4A90E2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'View Course',
                      style: TextStyle(fontSize: screenWidth * 0.04, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
