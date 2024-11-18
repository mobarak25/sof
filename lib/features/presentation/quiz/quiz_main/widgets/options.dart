import 'package:flutter/material.dart';

import 'package:gap/gap.dart';
import 'package:school_of_future/core/utils/colors.dart';
import 'package:school_of_future/core/utils/text_styles.dart';
import 'package:school_of_future/core/widgets/text.dart';
import 'package:school_of_future/features/domain/entities/quiz_details_for_student_response.dart';

class QuestionOptions extends StatelessWidget {
  const QuestionOptions({
    super.key,
    required this.questionOptions,
    required this.givenAns,
    required this.press,
  });

  final List<QuestionOption> questionOptions;
  final String givenAns;
  final Function press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          ...List.generate(
            questionOptions.length,
            (position) {
              final options = questionOptions[position];
              return Column(
                children: [
                  Material(
                    clipBehavior: Clip.antiAlias,
                    color: givenAns == options.id.toString()
                        ? kSecondaryColor
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(5),
                    child: InkWell(
                      onTap: () {
                        press(options.id.toString());
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 15),
                        decoration: BoxDecoration(
                          border: Border.all(color: bGray12),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Row(
                          children: [
                            TextB(
                              text: "A.",
                              textStyle: bBody1B,
                              fontColor: givenAns == options.id.toString()
                                  ? bWhite
                                  : bGray32,
                            ),
                            const Gap(15),
                            Expanded(
                              child: TextB(
                                text: options.options!,
                                textStyle: bBody1,
                                fontColor: givenAns == options.id.toString()
                                    ? bWhite
                                    : kQuizTextAnswerColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Gap(25),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
