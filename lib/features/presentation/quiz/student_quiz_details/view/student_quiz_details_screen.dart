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
          child: ListView(
            children: [
              const QuizCard(),
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
                      child: const Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                QuizDtlsTardTopInfo(
                                  title: "Question",
                                  value: '20',
                                ),
                                Gap(10),
                                QuizDtlsTardTopInfo(
                                  title: "Time(min)",
                                  value: '30',
                                  valueColor: bRed,
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                QuizDtlsTardTopInfo(
                                  title: "Marks",
                                  value: '20',
                                  valueColor: kSecondaryColor,
                                ),
                                Gap(10),
                                QuizDtlsTardTopInfo(
                                  title: "Retake",
                                  value: 'Allowed',
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

                        // InkWell(
                        //   onTap: () {},
                        //   child: Container(
                        //     width: 144,
                        //     height: 144,
                        //     alignment: Alignment.center,
                        //     decoration: BoxDecoration(
                        //       shape: BoxShape.circle,
                        //       gradient: const LinearGradient(
                        //         begin: Alignment.topCenter,
                        //         end: Alignment.bottomCenter,
                        //         colors: [Color(0XFFFFB423), Color(0XFFF38300)],
                        //       ),
                        //       boxShadow: [
                        //         BoxShadow(
                        //           offset: const Offset(0, 0),
                        //           blurRadius: 20,
                        //           color:
                        //               const Color(0XFFF38300).withOpacity(0.4),
                        //         )
                        //       ],
                        //     ),
                        //     child: const TextB(
                        //       text: "Start Quiz",
                        //       textStyle: bHead6B,
                        //       fontColor: bWhite,
                        //     ),
                        //   ),
                        // ),

                        const TextB(
                          text: "You Obtained",
                          textStyle: bBase,
                          fontColor: bBlack,
                        ),
                        const Gap(10),
                        const TextB(
                          text: "16",
                          textStyle: bHead1B,
                          fontColor: bJungleGreen,
                          fontHeight: 1.1,
                        ),
                        const TextB(
                          text: "16 out of 20 questions are correct",
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
                              Navigator.of(context, rootNavigator: true)
                                  .pushNamed(
                                resultSummeryScreen,
                                arguments: 1, //state.quizList.data![index].id,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
