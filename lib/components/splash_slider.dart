import 'package:edu_app/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intro_slider/intro_slider.dart';


class IntroScreenDefaultState extends StatefulWidget {
  const IntroScreenDefaultState({super.key});

  @override
  State<IntroScreenDefaultState> createState() =>
      _IntroScreenDefaultStateState();
}

class _IntroScreenDefaultStateState extends State<IntroScreenDefaultState> {
  List<ContentConfig> listContentConfig = [];

  @override
  void initState() {
    super.initState();

    listContentConfig.add(
      ContentConfig(
        
        description: "Hello whaterver",
        widgetDescription: SizedBox(
          width: double.infinity,
          child: Center(
            child: Text(
              "Better way to learning is calling you!",
              style: headingH2,
              textAlign: TextAlign.center,
            ),
          ),
        ),
        pathImage: "lib/assets/splashscreen1.png",
      ),
    );
    listContentConfig.add(
      ContentConfig(
        widgetDescription: SizedBox(
          width: double.infinity,
          child: Center(
            child: Text(
              "Find yourself  by doing whatever you do !",
              style: headingH2,
              textAlign: TextAlign.center,
            ),
          ),
        ),
        pathImage: "lib/assets/splashscreen2.png",
      ),
    );
    listContentConfig.add(
      ContentConfig(
        heightImage: 200,
        widgetDescription: SizedBox(
          width: double.infinity,
          child: Center(
            child: Text(
              "Its not just learning, Its a promise!",
              style: headingH2,
              textAlign: TextAlign.center,
            ),
          ),
        ),
        pathImage: "lib/assets/splashscreen3.png",
      ),
    );
  }

  void onDonePress() {}

  @override
  Widget build(BuildContext context) {
    return IntroSlider(
      // isScrollable: false,
      curveScroll: Curves.easeInOut,
      isShowDoneBtn: false,
      isShowNextBtn: false,
      isShowSkipBtn: false,
      isShowPrevBtn: false,
      key: UniqueKey(),
      listContentConfig: listContentConfig,
      onDonePress: onDonePress,
    );
  }
}
