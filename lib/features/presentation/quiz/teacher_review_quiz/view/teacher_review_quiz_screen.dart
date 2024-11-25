import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:school_of_future/core/translations/local_keys.dart';
import 'package:school_of_future/core/utils/colors.dart';
import 'package:school_of_future/core/utils/text_styles.dart';
import 'package:school_of_future/core/widgets/app_bar.dart';
import 'package:school_of_future/core/widgets/body.dart';
import 'package:school_of_future/core/widgets/button.dart';
import 'package:school_of_future/core/widgets/network_image.dart';
import 'package:school_of_future/core/widgets/text.dart';
import 'package:school_of_future/features/presentation/quiz/teacher_review_quiz/bloc/theacher_review_quiz_bloc.dart';
import 'package:school_of_future/features/presentation/quiz/teacher_review_quiz/widgets/qiestion_item_card.dart';

class TeacherReviewScreen extends StatelessWidget {
  const TeacherReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scroll = ScrollController();

    return BlocBuilder<TheacherReviewQuizBloc, TheacherReviewQuizState>(
      builder: (context, state) {
        final bloc = context.read<TheacherReviewQuizBloc>();
        final details = state.details.data;

        return Body(
          isFullScreen: true,
          appBar: FutureAppBar(
            actions: const [SizedBox()],
            title: LocaleKeys.reviewQuiz.tr(),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: details != null
                    ? ListView(
                        controller: scroll,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            decoration: const BoxDecoration(
                              color: bWhite,
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 65,
                                  height: 65,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(color: bGray12),
                                  ),
                                  child: NetworkImageB(
                                      imageUrl:
                                          state.studentInfo.student!.imageUrl!),
                                ),
                                const Gap(10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      TextB(
                                        text: state
                                            .studentInfo.student!.firstName!,
                                        textStyle: bSub2M,
                                        fontColor: bGray100,
                                        maxLines: 1,
                                      ),
                                      const Gap(4),
                                      TextB(
                                        text:
                                            "Roll: ${state.studentInfo.student!.admissionNumber!}",
                                      ),
                                    ],
                                  ),
                                ),
                                const Gap(5),
                                ButtonB(
                                  heigh: 50,
                                  text: "${state.totalMarks}",
                                  textColor: kPrimaryColor,
                                  borderColor: bGray12,
                                  bgColor: kPrimaryColor.withOpacity(0.03),
                                  press: () {},
                                )
                              ],
                            ),
                          ),
                          const Gap(20),
                          QuestionItemCard(
                            questions: details.questions!,
                            controllers: state.markController,
                            changeMark: (String mark, int questionId) {
                              bloc.add(ChangeMark(
                                  mark: mark, questionId: questionId));
                            },
                          ),
                        ],
                      )
                    : const Center(
                        child: CircularProgressIndicator(),
                      ),
              ),
              Container(
                color: bWhite,
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: ButtonB(
                        heigh: 45,
                        text: LocaleKeys.save.tr(),
                        press: () {
                          bloc.add(PressToSave());
                        },
                      ),
                    ),
                    const Gap(10),
                    Expanded(
                      child: ButtonB(
                        heigh: 45,
                        bgColor: bGray12,
                        textColor: bGray100,
                        text: LocaleKeys.reset.tr(),
                        press: () {
                          bloc.add(PressToReset());
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
