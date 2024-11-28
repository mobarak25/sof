import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_of_future/core/utils/colors.dart';
import 'package:school_of_future/core/utils/text_styles.dart';
import 'package:school_of_future/core/widgets/button.dart';
import 'package:school_of_future/core/widgets/network_image.dart';
import 'package:school_of_future/core/widgets/text.dart';
import 'package:school_of_future/features/domain/entities/question_paper_details_response.dart';

class QuestionCard extends StatelessWidget {
  const QuestionCard({
    super.key,
    this.questionPaperContents,
  });

  final List<QuestionPaperContent>? questionPaperContents;

  @override
  Widget build(BuildContext context) {
    return questionPaperContents != null
        ? Column(
            children: [
              ...List.generate(
                questionPaperContents!.length,
                (index) {
                  final attachment =
                      questionPaperContents![index].questions!.attachment;

                  return Container(
                    margin: const EdgeInsets.only(bottom: 15),
                    decoration: const BoxDecoration(
                      color: bWhite,
                    ),
                    child: Theme(
                      data: Theme.of(context)
                          .copyWith(dividerColor: Colors.transparent),
                      child: ExpansionTile(
                        expandedAlignment: Alignment.centerLeft,
                        tilePadding: const EdgeInsets.symmetric(horizontal: 5),
                        childrenPadding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        collapsedBackgroundColor: Colors.transparent,
                        backgroundColor: Colors.transparent,
                        title: Row(
                          children: [
                            Container(
                              clipBehavior: Clip.antiAlias,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              width: 50,
                              height: 50,
                              child: attachment != null
                                  ? NetworkImageB(
                                      imageUrl: attachment.file ?? '',
                                    )
                                  : const NetworkImageB(
                                      imageUrl: '',
                                    ),
                            ),
                            const Gap(10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextB(
                                    text: questionPaperContents![index]
                                        .questions!
                                        .title!,
                                    textStyle: bBody1,
                                  ),
                                  Row(
                                    children: [
                                      TextB(
                                        text: "Qns: ${index + 1}",
                                        fontSize: 12,
                                      ),
                                      const Gap(10),
                                      TextB(
                                        text:
                                            " Marks: ${questionPaperContents![index].questions!.mark!}",
                                        fontSize: 12,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        children: [
                          const Divider(
                            thickness: 1,
                            height: 1,
                            color: bGray12,
                          ),
                          const Gap(10),
                          const Row(
                            children: [
                              TextB(text: "Ans:", alignMent: TextAlign.left),
                            ],
                          ),
                          const Gap(10),
                          if (questionPaperContents![index].questions!.type !=
                              3)
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
                              itemCount: questionPaperContents![index]
                                  .questions!
                                  .questionOptions!
                                  .length,
                              itemBuilder: (context, position) {
                                final option = questionPaperContents![index]
                                    .questions!
                                    .questionOptions!;

                                return Align(
                                  alignment: (position % 2 == 0)
                                      ? Alignment.centerLeft
                                      : Alignment.centerRight,
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: bWhite,
                                    ),
                                    child: ButtonB(
                                      heigh: 40,
                                      bgColor: option[position].isCorrect == 1
                                          ? kPrimaryColor
                                          : bWhite,
                                      borderColor:
                                          option[position].isCorrect == 1
                                              ? kPrimaryColor
                                              : bGray12,
                                      textColor: option[position].isCorrect == 1
                                          ? bWhite
                                          : bGray,
                                      press: () {},
                                      text: option[position].options!,
                                    ),
                                  ),
                                );
                              },
                            ),
                          if (questionPaperContents![index]
                              .questions!
                              .correctAnswer!
                              .isNotEmpty)
                            Row(
                              children: [
                                TextB(
                                  text: questionPaperContents![index]
                                      .questions!
                                      .correctAnswer!,
                                  textStyle: bBody1,
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
          )
        : const TextB(text: "loading...");
  }
}
