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
import 'package:school_of_future/core/widgets/text.dart';
import 'package:school_of_future/features/presentation/quiz/result_summery/bloc/result_summery_bloc.dart';

class ResultSummeryScreen extends StatelessWidget {
  const ResultSummeryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ResultSummeryBloc, ResultSummeryState>(
      builder: (context, state) {
        final bloc = context.read<ResultSummeryBloc>();

        return Body(
          isFullScreen: true,
          appBar: FutureAppBar(
            actions: const [SizedBox()],
            title: LocaleKeys.resultSummary.tr(),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Gap(10),
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
                  color: bWhite,
                  child: ListView(
                    children: [
                      RichText(
                        text: const TextSpan(
                          children: [
                            TextSpan(
                              text: 'Result summary of the quiz ',
                              style: TextStyle(fontSize: 16, color: bGray100),
                            ),
                            TextSpan(
                              text: "New Quiz 1 ",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: kPrimaryColor,
                                  fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text: "given below",
                              style: TextStyle(fontSize: 16, color: bGray100),
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
                        text: "Total Time Taken",
                        press: () {},
                      ),
                      const Gap(20),
                      const TextB(
                        text: "12m : 21s",
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
                        text: "Correct / Wrong",
                        press: () {},
                      ),
                      const Gap(30),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 5, // 5 items per row
                          mainAxisSpacing: 15, // space between rows
                          crossAxisSpacing: 20, // space between columns
                          // makes each item square-shaped
                        ),
                        itemCount: 20, // 5x5 grid
                        itemBuilder: (context, index) {
                          return Container(
                            width: 48,
                            height: 48,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: index != 2
                                    ? [
                                        const Color(0XFF48DB94),
                                        const Color(0XFF069550)
                                      ]
                                    : [
                                        const Color(0XFFF96F6F),
                                        const Color(0XFFB13418)
                                      ],
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextB(
                              text: "${index + 1}",
                              textStyle: bSub1SB,
                              fontColor: bWhite,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
