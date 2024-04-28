import 'package:edu_app/components/editable_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Widget prflTxtEdit(
  // iconimg,
  icon,
  text,
  text2,
  
  // text3,
  // Container1,
  BuildContext context,
) {
  return Padding(
    padding: const EdgeInsets.only(left: 0, right: 0, top: 10, bottom: 10),
    child: Row(
      children: [
        // Icon(iconimg),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Align(
            //   alignment: Alignment.centerLeft,
            // ),

            // SizedBox(height: 10, width: 10),
            EditableButton(
              iconData: icon,
              text: text,
              initialText: text2,
              onTextChanged: (text) {
                print('Edited text: $text');
              },
            ),
          ],
        ),
      ],
    ),
  );
}

// Widget prfledittxt(
//   // iconimg,
//   // text,
//   // text2,
//   text3,
//   // container1,
//   BuildContext context,
// ) {
//   return Padding(
//     padding: const EdgeInsets.only(left: 0, right: 0, top: 10, bottom: 10),
//     child: Row(
//       children: [
      
//         ElevatedButton(
//           onPressed: () {},
//           child: Text(text3),
//         ),
//       ],
//     ),
//   );
// }

