import 'package:edu_app/screens/course_description.dart';
import 'package:flutter/material.dart';

Widget coursetxt(
  String img,
  String text,
  String routeName, // Add a parameter for the route name
  BuildContext context,
) {
  return SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.only(left: 0, right: 0, top: 10, bottom: 0),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(28.0, 38, 24, 0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            children: [
              Column(
                children: [
                  Image.asset(img, scale: 12),
                ],
              ),
              const SizedBox(width: 40),
              Column(
                children: [
                  Column(
                    children: [
                      Text(
                        text,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context,
                              routeName); // Use the route name to navigate
                        },
                        style: ElevatedButton.styleFrom(),
                        child: const Text('Buy Now'),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}


Widget coursetxtforteacher(
  String img,
  String text,
  String routeName, // Add a parameter for the route name
  BuildContext context,
) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(20, 20, 20, 15), // Consistent padding
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15), // Increased border radius for a smoother look
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3), // Softer shadow for a modern look
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 4), // Adds more depth
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 7), // Padding inside the container for a clean layout
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center, // Center the items vertically
          children: [
            // Image Section
            Image.asset(img, scale: 12),
            const SizedBox(width: 15), // Space between image and text

            // Text and Button Section
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, // Align text to the left
                children: [
                  Text(
                    text,
                    style: const TextStyle(
                      fontSize: 18, // Larger font for course title
                      color: Colors.black,
                      fontWeight: FontWeight.w500, // Medium weight for emphasis
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, routeName); // Navigate using routeName
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 3,
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                      backgroundColor: const Color(0xFF4A90E2), // Custom button color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8), // Rounded corners for the button
                      ),
                    ),
                    child: const Text(
                      'Edit Course',
                      style: TextStyle(fontSize: 16, color: Colors.white), // White text color
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

Widget chaptertxtforteacher(
  String img,
  String text,
  String routeName, // Add a parameter for the route name
  BuildContext context,
  // String text2,
) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(20, 20, 20, 15), // Consistent padding
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15), // Increased border radius for a smoother look
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3), // Softer shadow for a modern look
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 4), // Adds more depth
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 7), // Padding inside the container for a clean layout
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center, // Center the items vertically
          children: [
            // Image Section
            Image.asset(img, scale: 12),
            const SizedBox(width: 15), // Space between image and text

            // Text and Button Section
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, // Align text to the left
                children: [
                  Text(
                    text,
                    style: const TextStyle(
                      fontSize: 18, // Larger font for course title
                      color: Colors.black,
                      fontWeight: FontWeight.w500, // Medium weight for emphasis
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, routeName); // Navigate using routeName
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 3,
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                      backgroundColor: const Color(0xFF4A90E2), // Custom button color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8), // Rounded corners for the button
                      ),
                    ),
                    child: const Text(
                      'Edit Chapter',
                      style: TextStyle(fontSize: 16, color: Colors.white), // White text color
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

Widget chaptertxtforstudent(
  String img,
  String text,
  String routeName, // Add a parameter for the route name
  BuildContext context,
  // String text2,
) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(20, 20, 20, 15), // Consistent padding
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15), // Increased border radius for a smoother look
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3), // Softer shadow for a modern look
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 4), // Adds more depth
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 7), // Padding inside the container for a clean layout
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center, // Center the items vertically
          children: [
            // Image Section
            Image.asset(img, scale: 12),
            const SizedBox(width: 15), // Space between image and text

            // Text and Button Section
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, // Align text to the left
                children: [
                  Text(
                    text,
                    style: const TextStyle(
                      fontSize: 18, // Larger font for course title
                      color: Colors.black,
                      fontWeight: FontWeight.w500, // Medium weight for emphasis
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, 'viewchapterstudent'); // Navigate using routeName
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 3,
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                      backgroundColor: const Color(0xFF4A90E2), // Custom button color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8), // Rounded corners for the button
                      ),
                    ),
                    child: const Text(
                      'View Chapter',
                      style: TextStyle(fontSize: 16, color: Colors.white), // White text color
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

Widget crstxtforstudent(
  String img,
  String text,
  String routeName, // Add a parameter for the route name
  BuildContext context, {
  VoidCallback? onTap, // Add an optional parameter for onTap
}) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(20, 20, 20, 15), // Consistent padding
    child: GestureDetector( // Wrap with GestureDetector for tap functionality
      onTap: onTap ?? () {
        // Default action, can be empty if not provided
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15), // Increased border radius for a smoother look
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3), // Softer shadow for a modern look
              spreadRadius: 2,
              blurRadius: 8,
              offset: const Offset(0, 4), // Adds more depth
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 7), // Padding inside the container for a clean layout
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center, // Center the items vertically
            children: [
              // Image Section
              Image.asset(img, scale: 12),
              const SizedBox(width: 15), // Space between image and text

              // Text and Button Section
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start, // Align text to the left
                  children: [
                    Text(
                      text,
                      style: const TextStyle(
                        fontSize: 18, // Larger font for course title
                        color: Colors.black,
                        fontWeight: FontWeight.w500, // Medium weight for emphasis
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, routeName); // Navigate using routeName
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 3,
                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                        backgroundColor: const Color(0xFF4A90E2), // Custom button color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8), // Rounded corners for the button
                        ),
                      ),
                      child: const Text(
                        'View Course',
                        style: TextStyle(fontSize: 16, color: Colors.white), // White text color
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}



// Widget crstxtforstudentData(
//   String img,
//   String text,
//   BuildContext context,
//   Map<String, dynamic> courseData, // Passing the course data to the widget
// ) {
//   return Padding(
//     padding: const EdgeInsets.fromLTRB(20, 20, 20, 15), // Consistent padding
//     child: Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(15), // Increased border radius for a smoother look
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.3), // Softer shadow for a modern look
//             spreadRadius: 2,
//             blurRadius: 8,
//             offset: const Offset(0, 4), // Adds more depth
//           ),
//         ],
//       ),
//       child: Padding(
//         padding: const EdgeInsets.fromLTRB(10, 10, 10, 7), // Padding inside the container for a clean layout
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.center, // Center the items vertically
//           children: [
//             // Image Section
//             Image.asset(img, scale: 12),
//             const SizedBox(width: 15), // Space between image and text

//             // Text and Button Section
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start, // Align text to the left
//                 children: [
//                   Text(
//                     text,
//                     style: const TextStyle(
//                       fontSize: 18, // Larger font for course title
//                       color: Colors.black,
//                       fontWeight: FontWeight.w500, // Medium weight for emphasis
//                     ),
//                   ),
//                   const SizedBox(height: 10),
//                    ElevatedButton(
//                     onPressed: () {
//                       // Ensure `courseData` is being passed properly
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => CourseDescriptionpage(courseData: courseData), // Passing courseData
//                         ),
//                       );
//                     },
//                     style: ElevatedButton.styleFrom(
//                       elevation: 3,
//                       padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
//                       backgroundColor: const Color(0xFF4A90E2), // Custom button color
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8), // Rounded corners for the button
//                       ),
//                     ),
//                     child: const Text(
//                       'View Course',
//                       style: TextStyle(fontSize: 16, color: Colors.white), // White text color
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     ),
//   );
// }

