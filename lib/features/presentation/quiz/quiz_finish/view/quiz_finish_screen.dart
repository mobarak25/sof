import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:school_of_future/core/router/route_constents.dart';
import 'package:school_of_future/core/translations/local_keys.dart';
import 'package:school_of_future/core/utils/asset_image.dart';
import 'package:school_of_future/core/utils/colors.dart';
import 'package:school_of_future/core/utils/text_styles.dart';
import 'package:school_of_future/core/widgets/app_bar.dart';
import 'package:school_of_future/core/widgets/body.dart';
import 'package:school_of_future/core/widgets/button.dart';
import 'package:school_of_future/core/widgets/text.dart';
import 'package:school_of_future/features/presentation/quiz/quiz_finish/bloc/quiz_finish_bloc.dart';

class QuizFinishScreen extends StatelessWidget {
  const QuizFinishScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocBuilder<QuizFinishBloc, QuizFinishState>(
      builder: (context, state) {
        final bloc = context.read<QuizFinishBloc>();
        final data = state.details.data;

        return Body(
          isFullScreen: true,
          appBar: FutureAppBar(
            actions: const [SizedBox()],
            title: LocaleKeys.onlineQuiz.tr(),
          ),
          child: data != null
              ? Expanded(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: data.pass! > data.studentTime!.obtainedMark!
                            ? [const Color(0XFFFF4848), const Color(0XFFFF8787)]
                            : [
                                const Color(0XFF37BFD7),
                                const Color(0XFF17799C)
                              ],
                      ),
                      image: const DecorationImage(
                        image: AssetImage("assets/images/red_union.png"),
                        fit: BoxFit.fitWidth,
                        alignment: Alignment.topCenter,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Gap(size.height * 0.08),
                        Container(
                          width: 170,
                          height: 180,
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: bWhite,
                            border: Border.all(width: 2, color: bWhite),
                            shape: BoxShape.circle,
                            image: const DecorationImage(
                              image: AssetImage(
                                  "assets/images/profile_image_sample.png"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Gap(size.height * 0.07),
                        if (state.haveAnyShortQst)
                          Expanded(
                            child: Column(
                              children: [
                                const TextB(
                                  text: "Pending",
                                  textStyle: bHead5B,
                                  fontColor: bWhite,
                                ),
                                const Gap(10),
                                const TextB(
                                  text:
                                      "After the review, the results will be published!",
                                  fontColor: bWhite,
                                ),
                                const Spacer(),
                                ButtonB(
                                  heigh: 48,
                                  bgColor: bWhite,
                                  textColor: bGray,
                                  text: "Back",
                                  iconPosition: "left",
                                  svgIcon: prevArrowSvg,
                                  press: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                const Gap(15),
                              ],
                            ),
                          )
                        else
                          Expanded(
                            child: Column(
                              children: [
                                TextB(
                                  text:
                                      "${data.pass! > data.studentTime!.obtainedMark! ? 'Sorry' : 'Congrats'} ${state.profile.data!.fullname}! Your Mark is",
                                  textStyle: bBody1,
                                  fontColor: bWhite,
                                ),
                                TextB(
                                  text: data.studentTime!.obtainedMark!
                                      .toString(),
                                  textStyle: bHead3B,
                                  fontColor: bWhite,
                                ),
                                const Spacer(),
                                TextB(
                                  text: data.title!,
                                  textStyle: bBase,
                                  fontColor: bWhite,
                                ),
                                TextB(
                                  text: data.subject!.name!,
                                  textStyle: bBase,
                                  fontColor: bWhite,
                                ),
                                Gap(size.height * 0.05),
                                if (data.pass! >
                                    data.studentTime!.obtainedMark!)
                                  ButtonB(
                                    heigh: 48,
                                    bgColor: bWhite,
                                    textColor: bRed,
                                    text: "Retake",
                                    press: () {
                                      Navigator.of(context, rootNavigator: true)
                                          .pushNamed(
                                        studentQuizDetailsScreen,
                                        arguments: data.id,
                                      );
                                    },
                                  ),
                                const Gap(15),
                                ButtonB(
                                  heigh: 48,
                                  bgColor: bWhite,
                                  textColor: bGray100,
                                  text: LocaleKeys.viewDetails.tr(),
                                  press: () {
                                    Navigator.of(context, rootNavigator: true)
                                        .pushNamed(resultSummeryScreen,
                                            arguments: data.id);
                                  },
                                ),
                                const Gap(15),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                )
              : const Center(
                  child: CircularProgressIndicator(),
                ),
        );
      },
    );
  }
}
