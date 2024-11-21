import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:school_of_future/core/router/route_constents.dart';
import 'package:school_of_future/core/translations/local_keys.dart';
import 'package:school_of_future/core/utils/colors.dart';
import 'package:school_of_future/core/widgets/app_bar.dart';
import 'package:school_of_future/core/widgets/body.dart';
import 'package:school_of_future/core/widgets/button.dart';
import 'package:school_of_future/features/presentation/quiz/teacher_quiz_details/bloc/teacher_quiz_details_bloc.dart';
import 'package:school_of_future/features/presentation/quiz/teacher_quiz_details/widgets/quiz_card.dart';
import 'package:school_of_future/features/presentation/quiz/teacher_quiz_details/widgets/quiz_dtls_card_top_info.dart';

class TeacherQuizDtlsScreen extends StatelessWidget {
  const TeacherQuizDtlsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TeacherQuizDetailsBloc, TeacherQuizDetailsState>(
      builder: (context, state) {
        final bloc = context.read<TeacherQuizDetailsBloc>();
        final data = state.quizDtls.data;

        return Body(
          isFullScreen: true,
          appBar: FutureAppBar(
            actions: const [SizedBox()],
            title: LocaleKeys.onlineQuiz.tr(),
          ),
          child: data != null
              ? ListView(
                  children: [
                    QuizCard(
                      title: data.title!,
                      subject: data.subject!,
                      startTime: data.startDateTime!,
                      endTime: data.endDateTime!,
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
                                        value: '${data.totalQuestion}',
                                      ),
                                      const Gap(20),
                                      QuizDtlsTardTopInfo(
                                        title: LocaleKeys.attended.tr(),
                                        value:
                                            '${data.totalAttended}/${data.assignStudents!.length}',
                                        valueColor: bBlueColor,
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      QuizDtlsTardTopInfo(
                                        title: LocaleKeys.marks.tr(),
                                        value: '${data.totalMark}',
                                        valueColor: kSecondaryColor,
                                      ),
                                      const Gap(20),
                                      QuizDtlsTardTopInfo(
                                        title: LocaleKeys.highestMark.tr(),
                                        value: '${data.highestMarks ?? 0}',
                                        valueColor: bGreen,
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      QuizDtlsTardTopInfo(
                                        title:
                                            "${LocaleKeys.time.tr()}(${LocaleKeys.min.tr()})",
                                        value: '${data.duration}',
                                        valueColor: bRed,
                                      ),
                                      const Gap(20),
                                      QuizDtlsTardTopInfo(
                                        title: LocaleKeys.pass.tr(),
                                        value: "${data.totalPassedAttended}"
                                            .padLeft(2, '0'),
                                        valueColor: kPassMarkColor,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Gap(35),
                              const Gap(50),
                              ButtonB(
                                heigh: 60,
                                bgColor: kSecondaryColor,
                                text: LocaleKeys.viewDetails.tr(),
                                press: () {
                                  Navigator.of(context, rootNavigator: true)
                                      .pushNamed(teacherQuizStudentsScreen,
                                          arguments: data.id!);
                                },
                              )
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
