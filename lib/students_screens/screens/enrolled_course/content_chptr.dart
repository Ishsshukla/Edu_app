import 'package:flutter/material.dart';

class CoursePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Course Banner and Progress
              _buildCourseBanner(),

              const SizedBox(height: 20),

              // Description Section
              _buildSectionTitle('Description'),
              const Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Habitasse dolor etiam sed ante donec quis sapien.',
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
              const SizedBox(height: 5),
              TextButton(
                onPressed: () {},
                child: const Text('More', style: TextStyle(color: Colors.blue)),
              ),

              const SizedBox(height: 20),

              // Next Chapter Section
              _buildSectionTitle('Next Chapter'),
              _buildChapterSection(),

              const SizedBox(height: 20),

              // Quiz Section
              _buildQuizSection(),

              const SizedBox(height: 20),

              // Start Course Button
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4A73F6),
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text(
                    'Start Course',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCourseBanner() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                // Example of Image/Illustration
                Image.network(
                  'https://via.placeholder.com/100',
                  height: 80,
                  width: 80,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'High School Algebra I: Help and Review',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 5),
                      const Text('Mathematics', style: TextStyle(color: Colors.black54)),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Text('5/12', style: TextStyle(color: Colors.black54)),
                          const SizedBox(width: 10),
                          Expanded(
                            child: LinearProgressIndicator(
                              value: 5 / 12,
                              backgroundColor: Colors.grey[300],
                              color: const Color(0xFF4A73F6),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildChapterSection() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ExpansionTile(
        title: const Text('Solving Math Word Problems'),
        children: [
          ListTile(
            title: const Text('Lesson 1: Solving Word Problems: Steps & Examples'),
            trailing: const Icon(Icons.play_circle_fill, color: Color(0xFF4A73F6)),
            onTap: () {},
          ),
          ListTile(
            title: const Text('Lesson 2: Solving Word Problems with Multiple Steps'),
            trailing: const Icon(Icons.play_circle_fill, color: Color(0xFF4A73F6)),
            onTap: () {},
          ),
          ListTile(
            title: const Text('Lesson 3: Restating Word Problems Using Words or Images'),
            trailing: const Icon(Icons.play_circle_fill, color: Color(0xFF4A73F6)),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildQuizSection() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 2,
      child: ExpansionTile(
        title: const Text('Quiz'),
        children: [
          ListTile(
            title: const Text('Practicing Mixture Problems in Algebra'),
            trailing: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFB0D4FF),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () {},
              child: const Text('Take Quiz', style: TextStyle(color: Color(0xFF4A73F6))),
            ),
          ),
        ],
      ),
    );
  }
}
