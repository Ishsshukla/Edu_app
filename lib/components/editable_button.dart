import 'package:edu_app/components/const.dart';
import 'package:flutter/material.dart';
import 'package:edu_app/components/const.dart';

class EditableButton extends StatefulWidget {
  final String initialText;
  final Function(String) onTextChanged;
  final String text;
  final IconData iconData;

  const EditableButton({
    Key? key,
    this.initialText = 'Click to edit',
    required this.onTextChanged,
    required this.text,
    required this.iconData,
  }) : super(key: key);

  @override
  _EditableButtonState createState() => _EditableButtonState();
}

class _EditableButtonState extends State<EditableButton> {
  final TextEditingController _controller = TextEditingController();
  bool _editing = false;
  late String _displayText;
  // final String text = ;

  @override
  void initState() {
    super.initState();
    _displayText = widget.initialText;
  }

  void _toggleEditing() {
    setState(() {
      _editing = !_editing;
      if (!_editing) {
        _displayText =
            _controller.text.isEmpty ? widget.initialText : _controller.text;
        widget.onTextChanged(_displayText);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(
          widget.iconData,
          size: 40,
          color: txtColor,
        ),
        SizedBox(
          width: screenWidth * 0.06,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.text,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 17, 1, 1),
                    letterSpacing: 1.0,
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'poppins',
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                SizedBox(
                  width: screenWidth * 0.3,
                  child: _editing
                      ? TextFormField(
                          controller: _controller,
                          decoration: const InputDecoration(
                            // disabledBorder:
                            //     UnderlineInputBorder(borderSide: BorderSide.none),
                            // border: InputBorder.none,
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color:
                                      Colors.white), // Set default border color
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color:
                                      Colors.grey), // Set default border color
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color:
                                      Colors.grey), // Set focused border color
                            ),
                          ),
                          onFieldSubmitted: (_) => _toggleEditing(),
                        )
                      : GestureDetector(
                          onTap: () {},
                          child: Container(
                            // width: 10,
                            padding: const EdgeInsets.symmetric(
                                vertical: 4, horizontal: 10),
                            decoration: BoxDecoration(
                              border: Border.all(color: txtColor),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Text(
                              _displayText,
                              style: const TextStyle(fontSize: 14),
                            ),
                          ),
                        ),
                ),
              ],
            ),
            SizedBox(
              width: screenWidth * 0.09,
            ),
            ElevatedButton(
              onPressed: () {
                _toggleEditing();
              },
              child: Text(
                _editing ? 'Save' : 'Edit',
                style: TextStyle(
                  color: txtColor,
                ),
              ),
            ),
          ],
        ),
        // const SizedBox(
        //     width: 30), // Add some space between the text field and the button
      ],
    );
  }
}
