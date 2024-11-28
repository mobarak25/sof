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
import 'package:school_of_future/features/presentation/exam/teacher_exam_details/bloc/teacher_exam_details_bloc.dart';
import 'package:school_of_future/features/presentation/exam/teacher_exam_details/widgets/exam_details_top_card.dart';
import 'package:school_of_future/features/presentation/quiz/teacher_quiz_details/widgets/quiz_dtls_card_top_info.dart';

class TeacherExamDtlsScreen extends StatelessWidget {
  const TeacherExamDtlsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TeacherExamDetailsBloc, TeacherExamDetailsState>(
      builder: (context, state) {
        final bloc = context.read<TeacherExamDetailsBloc>();
        final data = state.examDtls.data;

        return Body(
          isFullScreen: true,
          appBar: FutureAppBar(
            actions: const [SizedBox()],
            title: LocaleKeys.examDetails.tr(),
          ),
          child: data != null
              ? ListView(
                  children: [
                    ExamDetailsTopCard(
                      details: state.examDtls,
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
                                        CrossAxisAlignment.center,
                                    children: [
                                      QuizDtlsTardTopInfo(
                                        title: LocaleKeys.totalStudent.tr(),
                                        value: "${data.totalAttended}",
                                      ),
                                      const Gap(20),
                                      QuizDtlsTardTopInfo(
                                        title: LocaleKeys.absent.tr(),
                                        value: "${data.totalAbsent}",
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
                                        title: LocaleKeys.passMark.tr(),
                                        value: "${data.passMark}",
                                        valueColor: kSecondaryColor,
                                      ),
                                      const Gap(20),
                                      QuizDtlsTardTopInfo(
                                        title: LocaleKeys.highestMark.tr(),
                                        value: "${data.maxMark}",
                                        valueColor: bGreen,
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
                                      .pushNamed(teacherMarkEntryScreen,
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
