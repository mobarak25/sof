import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:school_of_future/core/translations/local_keys.dart';
import 'package:school_of_future/core/utils/colors.dart';
import 'package:school_of_future/core/utils/text_styles.dart';
import 'package:school_of_future/core/utils/utilities.dart';
import 'package:school_of_future/core/widgets/app_bar.dart';
import 'package:school_of_future/core/widgets/body.dart';
import 'package:school_of_future/core/widgets/floating_button.dart';
import 'package:school_of_future/core/widgets/text.dart';
import 'package:school_of_future/features/presentation/question_paper/question_paper_details/bloc/question_paper_details_bloc.dart';
import 'package:school_of_future/features/presentation/question_paper/question_paper_details/widgets/question_card.dart';

class QuestionPaperDetailScreen extends StatelessWidget {
  const QuestionPaperDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuestionPaperDetailsBloc, QuestionPaperDetailsState>(
      builder: (context, state) {
        // final bloc = context.read<QuestionPaperDetailsBloc>();

        return Body(
          isFullScreen: true,
          appBar: FutureAppBar(
            actions: const [SizedBox()],
            title: LocaleKeys.questionPaperDetails.tr(),
          ),
          child: Stack(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 13),
                color: bInnerBg,
                child: state.details.data != null
                    ? ListView(
                        children: [
                          Container(
                            width: double.infinity,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 20),
                            decoration: const BoxDecoration(
                              color: bWhite,
                            ),
                            child: Column(
                              children: [
                                TextB(
                                  text: state.details.data!.name!,
                                  textStyle: bHead6B,
                                ),
                                const Gap(10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextB(
                                      text: state.details.data!.subject!.name!,
                                      fontColor: kPrimaryColor,
                                      fontSize: 13,
                                    ),
                                    const Gap(8),
                                    Container(
                                      height: 12,
                                      width: 1,
                                      color: bGray,
                                    ),
                                    const Gap(8),
                                    TextB(
                                      text: getDate(
                                          value: state.details.data!.datetime!,
                                          formate: "yyyy"),
                                      fontSize: 13,
                                    ),
                                  ],
                                ),
                                TextB(
                                  text:
                                      "Exam type: ${state.details.data!.type}",
                                  fontSize: 13,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextB(
                                      text:
                                          "Time: ${state.details.data!.duration!}",
                                      fontSize: 13,
                                    ),
                                    const Gap(8),
                                    Container(
                                      height: 15,
                                      width: 1,
                                      color: bGray,
                                    ),
                                    const Gap(8),
                                    TextB(
                                      text:
                                          "Total Marks: ${state.details.data!.fullMark!}",
                                      fontSize: 13,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const Gap(15),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: QuestionCard(
                              questionPaperContents:
                                  state.details.data!.questionPaperContents,
                            ),
                          ),
                        ],
                      )
                    : const Center(
                        child: CircularProgressIndicator(),
                      ),
              ),
              FloatingButton(
                bottom: 30,
                icon: const Icon(
                  Icons.download,
                  size: 30,
                  color: bWhite,
                ),
                press: () {
                  // Navigator.of(context, rootNavigator: true)
                  //     .pushNamed(teacherlessonPlanCreateScreen, arguments: -1);
                },
              )
            ],
          ),
        );
      },
    );
  }
}
