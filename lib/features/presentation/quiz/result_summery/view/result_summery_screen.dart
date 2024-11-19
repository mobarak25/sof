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
import 'package:school_of_future/features/presentation/quiz/result_summery/bloc/result_summery_bloc.dart';

class ResultSummeryScreen extends StatelessWidget {
  const ResultSummeryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ResultSummeryBloc, ResultSummeryState>(
      builder: (context, state) {
        final bloc = context.read<ResultSummeryBloc>();
        final data = state.details.data;

        return Body(
          isFullScreen: true,
          appBar: FutureAppBar(
            actions: const [SizedBox()],
            title: LocaleKeys.resultSummary.tr(),
          ),
          child: data != null
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Gap(10),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 25),
                        color: bWhite,
                        child: ListView(
                          children: [
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: LocaleKeys.resSumOfTheQuiz.tr(),
                                    style: const TextStyle(
                                        fontSize: 16, color: bGray100),
                                  ),
                                  TextSpan(
                                    text: " ${data.title} ",
                                    style: const TextStyle(
                                        fontSize: 16,
                                        color: kPrimaryColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(
                                    text: LocaleKeys.givenBelow.tr(),
                                    style: const TextStyle(
                                        fontSize: 16, color: bGray100),
                                  ),
                                ],
                              ),
                            ),
                            const Gap(50),
                            ButtonB(
                              heigh: 50,
                              bgColor: bGray4,
                              textColor: bGray52,
                              fontSize: 16,
                              text: LocaleKeys.totalTimeTaken.tr(),
                              press: () {},
                            ),
                            const Gap(20),
                            TextB(
                              text: minSec(data.studentTime!.takenTime!),
                              textStyle: bHead3M,
                              fontColor: kSecondaryColor,
                              alignMent: TextAlign.center,
                            ),
                            const Gap(70),
                            ButtonB(
                              heigh: 50,
                              bgColor: bGray4,
                              textColor: bGray52,
                              fontSize: 16,
                              text:
                                  "${LocaleKeys.correct.tr()} / ${LocaleKeys.wrong.tr()}",
                              press: () {},
                            ),
                            const Gap(30),
                            GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 5,
                                mainAxisSpacing: 15,
                                crossAxisSpacing: 20,
                              ),
                              itemCount: data.questions!.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.of(context, rootNavigator: true)
                                        .pushNamed(
                                      quizExplanationScreen,
                                      arguments: {
                                        "qIndex": index + 1,
                                        "question": data.questions![index]
                                      },
                                    );
                                  },
                                  child: Container(
                                    width: 48,
                                    height: 48,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: data.questions![index].answer!
                                                    .isCorrect ==
                                                0
                                            ? [
                                                const Color(0XFFF96F6F),
                                                const Color(0XFFB13418)
                                              ]
                                            : [
                                                const Color(0XFF48DB94),
                                                const Color(0XFF069550)
                                              ],
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: TextB(
                                      text: "${index + 1}",
                                      textStyle: bSub1SB,
                                      fontColor: bWhite,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
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

  String minSec(int totalSecond) {
    final minutes = (totalSecond ~/ 60).toString().padLeft(2, '0');
    final seconds = (totalSecond % 60).toString().padLeft(2, '0');
    final formattedTime = "${minutes}m:${seconds}s";
    return formattedTime;
  }
}
