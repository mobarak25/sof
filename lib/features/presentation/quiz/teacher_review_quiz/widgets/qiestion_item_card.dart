import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_of_future/core/translations/local_keys.dart';
import 'package:school_of_future/core/utils/colors.dart';
import 'package:school_of_future/core/utils/text_styles.dart';
import 'package:school_of_future/core/utils/utilities.dart';
import 'package:school_of_future/core/widgets/button.dart';
import 'package:school_of_future/core/widgets/text.dart';
import 'package:school_of_future/core/widgets/text_field.dart';

import 'package:school_of_future/features/domain/entities/quiz_details_for_student_response.dart';

class QuestionItemCard extends StatelessWidget {
  const QuestionItemCard({
    super.key,
    required this.questions,
    required this.controllers,
    required this.changeMark,
  });

  final List<Question> questions;
  final List<MCQOptions> controllers;
  final Function(String) changeMark;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...List.generate(
            questions.length,
            (index) {
              return Container(
                margin: const EdgeInsets.only(bottom: 15),
                decoration: BoxDecoration(
                  color: bWhite,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Theme(
                  data: Theme.of(context)
                      .copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    expandedAlignment: Alignment.centerLeft,
                    tilePadding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                    childrenPadding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    collapsedBackgroundColor: Colors.transparent,
                    backgroundColor: Colors.transparent,
                    trailing: SizedBox(
                      width: 50,
                      child: TextFieldB(
                        hintText: "--",
                        borderColor: bGray12,
                        textInputType: TextInputType.number,
                        onChanged: (String value) {
                          changeMark(value);
                        },
                        textAlign: TextAlign.center,
                        focusNode: controllers[index].focusnode,
                        controller: controllers[index].textEditingController,
                        isReadOnly: questions[index].type == 3 ? false : true,
                      ),
                    ),
                    initiallyExpanded: index == 0 ? true : false,
                    title: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Que ${index + 1}: ",
                            style: bBody1.copyWith(color: bGray32),
                          ),
                          TextSpan(
                            text: questions[index].title!,
                            style: bBody1.copyWith(color: bGray100),
                          ),
                        ],
                      ),
                    ),
                    children: [
                      const Divider(
                        thickness: 1,
                        height: 1,
                        color: bGray12,
                      ),
                      const Gap(10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const TextB(text: "Ans:"),
                          if (questions[index].type == 3)
                            TextB(
                              text:
                                  "${LocaleKeys.marks.tr()}: ${questions[index].pivot!.mark}",
                            ),
                        ],
                      ),
                      const Gap(10),
                      if (questions[index].type != 3)
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            childAspectRatio: 3.5,
                          ),
                          itemCount: questions[index].questionOptions!.length,
                          itemBuilder: (context, position) {
                            final option = questions[index].questionOptions!;

                            return Align(
                              alignment: (position % 2 == 0)
                                  ? Alignment.centerLeft
                                  : Alignment.centerRight,
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: bWhite,
                                ),
                                child: ButtonB(
                                  heigh: 46,
                                  bgColor: getColor(
                                      questions[index], option[position])[0],
                                  borderColor: getColor(
                                          questions[index], option[position])[1]
                                      .withOpacity(0.3),
                                  textColor: getColor(
                                      questions[index], option[position])[1],
                                  press: () {},
                                  text: option[position].options!,
                                ),
                              ),
                            );
                          },
                        ),
                      if (questions[index].type == 3)
                        Row(
                          children: [
                            Flexible(
                              child: TextB(
                                text:
                                    questions[index].answer!.questionsAns ?? '',
                                textStyle: bBody1M,
                                fontColor: kSecondaryColor,
                                alignMent: TextAlign.left,
                              ),
                            ),
                          ],
                        )
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  List<Color> getColor(Question question, QuestionOption option) {
    if (question.answer!.questionsOptionsId == option.id &&
        option.isCorrect == 1) {
      return [kPrimaryColor, bWhite];
    } else if (question.answer!.questionsOptionsId == option.id &&
        option.isCorrect != 1) {
      return [bRed, bWhite];
    } else if (option.isCorrect == 1) {
      return [kPrimaryColor, bWhite];
    } else {
      return [bWhite, bGray];
    }
  }
}
