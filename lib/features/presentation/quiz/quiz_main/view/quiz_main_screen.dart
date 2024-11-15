import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:school_of_future/core/translations/local_keys.dart';
import 'package:school_of_future/core/utils/asset_image.dart';
import 'package:school_of_future/core/utils/colors.dart';
import 'package:school_of_future/core/utils/text_styles.dart';
import 'package:school_of_future/core/widgets/app_bar.dart';
import 'package:school_of_future/core/widgets/body.dart';
import 'package:school_of_future/core/widgets/button.dart';
import 'package:school_of_future/core/widgets/text.dart';
import 'package:school_of_future/features/presentation/quiz/quiz_main/bloc/quiz_main_bloc.dart';
import 'package:school_of_future/features/presentation/quiz/quiz_main/widgets/timer_radius.dart';

class QuizMainScreen extends StatelessWidget {
  const QuizMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read<QuizMainBloc>().add(StopTimer());
        return true;
      },
      child: BlocBuilder<QuizMainBloc, QuizMainState>(
        builder: (context, state) {
          final bloc = context.read<QuizMainBloc>();

          return Body(
            isFullScreen: true,
            appBar: FutureAppBar(
              actions: const [SizedBox()],
              title: LocaleKeys.onlineQuiz.tr(),
            ),
            child: state.details.data != null
                ? Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.topCenter,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Gap(80),
                          Expanded(
                            child: Container(
                              width: double.infinity,
                              color: bWhite,
                              child: ListView(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.fromLTRB(
                                        15, 15, 15, 40),
                                    decoration: BoxDecoration(
                                      gradient: const LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Color(0XFF37BFD7),
                                          Color(0XFF17799C),
                                        ],
                                      ),
                                      borderRadius: BorderRadius.circular(7),
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            TextB(
                                              text:
                                                  "${state.qstIndex + 1} of ${state.details.data!.totalQuestion}",
                                              textStyle: bBase2,
                                              fontColor: bWhite,
                                            ),
                                            TextB(
                                              text:
                                                  "Mark: ${state.details.data!.questions![state.qstIndex].pivot!.mark}",
                                              textStyle: bBase2,
                                              fontColor: bWhite,
                                            ),
                                          ],
                                        ),
                                        const Gap(80),
                                        TextB(
                                          text:
                                              "${state.details.data!.questions![state.qstIndex].title}",
                                          textStyle: bHead6B,
                                          fontColor: bWhite,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            color: bWhite,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            child: Row(
                              children: [
                                Expanded(
                                  child: ButtonB(
                                    heigh: 48,
                                    text: "Previous",
                                    press: () {
                                      bloc.add(PressToPrev());
                                    },
                                    bgColor: bGray4,
                                    textColor: bGray32,
                                    svgIcon: prevArrowSvg,
                                    iconPosition: "left",
                                  ),
                                ),
                                const Gap(20),
                                Expanded(
                                  child: ButtonB(
                                    heigh: 48,
                                    text: "Next",
                                    press: () {
                                      bloc.add(PressToNext());
                                    },
                                    bgColor: bGray4,
                                    textColor: bGray52,
                                    svgIcon: nextArrowSvg,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      Positioned(
                        top: 10,
                        child: TimerRadius(
                          minutes: state.min,
                          seconds: state.sec,
                          parsentage: state.percentage,
                        ),
                      ),
                    ],
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  ),
          );
        },
      ),
    );
  }
}
