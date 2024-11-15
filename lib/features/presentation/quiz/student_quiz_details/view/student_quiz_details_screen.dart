import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:school_of_future/core/router/route_constents.dart';
import 'package:school_of_future/core/translations/local_keys.dart';
import 'package:school_of_future/core/utils/colors.dart';
import 'package:school_of_future/core/utils/text_styles.dart';
import 'package:school_of_future/core/widgets/app_bar.dart';
import 'package:school_of_future/core/widgets/body.dart';
import 'package:school_of_future/core/widgets/button.dart';
import 'package:school_of_future/core/widgets/text.dart';
import 'package:school_of_future/features/presentation/quiz/student_quiz_details/bloc/student_quiz_details_bloc.dart';
import 'package:school_of_future/features/presentation/quiz/student_quiz_details/widgets/quiz_card.dart';
import 'package:school_of_future/features/presentation/quiz/student_quiz_details/widgets/quiz_dtls_card_top_info.dart';

class StudentQuizDtlsScreen extends StatelessWidget {
  const StudentQuizDtlsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StudentQuizDetailsBloc, StudentQuizDetailsState>(
      builder: (context, state) {
        final bloc = context.read<StudentQuizDetailsBloc>();

        return Body(
          isFullScreen: true,
          appBar: FutureAppBar(
            actions: const [SizedBox()],
            title: LocaleKeys.onlineQuiz.tr(),
          ),
          child: state.details.data != null
              ? ListView(
                  children: [
                    QuizCard(
                      title: state.details.data!.title!,
                      subject: state.details.data!.subject!,
                      startTime: state.details.data!.startDateTime!,
                      endTime: state.details.data!.endDateTime!,
                    ),
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Positioned(
                          top: -150,
                          left: 20,
                          right: 20,
                          child: Container(
                            padding: const EdgeInsets.all(25),
                            decoration: BoxDecoration(
                              color: bWhite,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  offset: const Offset(0, 0),
                                  blurRadius: 50,
                                  color: bBlack.withOpacity(0.1),
                                )
                              ],
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      QuizDtlsTardTopInfo(
                                        title: LocaleKeys.questions.tr(),
                                        value:
                                            '${state.details.data!.totalQuestion}',
                                      ),
                                      const Gap(10),
                                      QuizDtlsTardTopInfo(
                                        title:
                                            "${LocaleKeys.time.tr()}(${LocaleKeys.min.tr()})",
                                        value:
                                            '${state.details.data!.duration}',
                                        valueColor: bRed,
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      QuizDtlsTardTopInfo(
                                        title: LocaleKeys.marks.tr(),
                                        value:
                                            '${state.details.data!.totalMark}',
                                        valueColor: kSecondaryColor,
                                      ),
                                      const Gap(10),
                                      QuizDtlsTardTopInfo(
                                        title: "Retake",
                                        value:
                                            state.details.data!.allowRetake == 1
                                                ? 'Allowed'
                                                : 'Not Allowed',
                                        valueColor: bJungleGreen,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Gap(35),
                              const Gap(40),
                              if (state.details.data!.studentTime == null)
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context, rootNavigator: true)
                                        .pushNamed(
                                      quizMainScreen,
                                      arguments: state.details.data!.id,
                                    );
                                  },
                                  child: Container(
                                    width: 144,
                                    height: 144,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      gradient: const LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Color(0XFFFFB423),
                                          Color(0XFFF38300)
                                        ],
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          offset: const Offset(0, 0),
                                          blurRadius: 20,
                                          color: const Color(0XFFF38300)
                                              .withOpacity(0.4),
                                        )
                                      ],
                                    ),
                                    child: const TextB(
                                      text: "Start Quiz",
                                      textStyle: bHead6B,
                                      fontColor: bWhite,
                                    ),
                                  ),
                                )
                              else
                                Column(
                                  children: [
                                    TextB(
                                      text: LocaleKeys.youObtained.tr(),
                                      textStyle: bBase,
                                      fontColor: bBlack,
                                    ),
                                    const Gap(10),
                                    TextB(
                                      text:
                                          "${state.details.data!.studentTime!.obtainedMark!}",
                                      textStyle: bHead1B,
                                      fontColor: bJungleGreen,
                                      fontHeight: 1.1,
                                    ),
                                    TextB(
                                      text:
                                          "${state.details.data!.totalCorrectAnswer} out of ${state.details.data!.totalQuestion} questions are correct",
                                      textStyle: bBase2,
                                      fontColor: bGray52,
                                    ),
                                    const Gap(10),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 20),
                                      child: ButtonB(
                                        heigh: 50,
                                        text: "View Details",
                                        press: () {
                                          Navigator.of(context,
                                                  rootNavigator: true)
                                              .pushNamed(
                                            resultSummeryScreen,
                                            arguments: state.details.data!.id,
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                )
              : const Center(
                  child: CircularProgressIndicator(),
                ),
        );
      },
    );
  }
}
