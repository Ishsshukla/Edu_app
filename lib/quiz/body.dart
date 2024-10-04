import 'package:edu_app/components/quiz_const.dart';
import 'package:edu_app/controller/que_controller.dart';
import 'package:edu_app/quiz/progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'question_crad.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    QuestionController questionController = Get.find();

    PageController pageController = questionController.pageController;
    return Stack(
      fit: StackFit.expand,
      children: [
        SvgPicture.asset(
          "assets/bg.svg",
          fit: BoxFit.fitWidth,
        ),
        SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ProgressBar(),
              Obx(
                () => Text.rich(
                  TextSpan(
                      text:
                          "Question ${questionController.questionNumber.value}",
                      style:
                          Theme.of(context).textTheme.headlineMedium!.copyWith(
                                color: kScondaryColor,
                              ),
                      children: [
                        TextSpan(
                            text:
                                "/${questionController.filteredQuestion.length}",
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .copyWith(
                                  color: kScondaryColor,
                                ))
                      ]),
                ),
              ),
              const Divider(
                thickness: 1.5,
              ),
              Expanded(
                child: PageView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  onPageChanged: questionController.updateTheQnNum,
                  itemCount: questionController.filteredQuestion.length,
                  controller: pageController,
                  itemBuilder: (context, index) {
                    return QuestionCard(
                        question: questionController.filteredQuestion[index]);
                  },
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}