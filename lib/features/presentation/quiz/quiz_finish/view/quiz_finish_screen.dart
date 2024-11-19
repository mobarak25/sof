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
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Color(0XFFFF4848), Color(0XFFFF8787)],
                      ),
                      image: DecorationImage(
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
                        const TextB(
                          text: "Sorry Robin! Your Mark is",
                          textStyle: bBody1,
                          fontColor: bWhite,
                        ),
                        const TextB(
                          text: "03",
                          textStyle: bHead3B,
                          fontColor: bWhite,
                        ),
                        const Spacer(),
                        const TextB(
                          text: "Quiz 1",
                          textStyle: bBase,
                          fontColor: bWhite,
                        ),
                        const TextB(
                          text: "Mathematics",
                          textStyle: bBase,
                          fontColor: bWhite,
                        ),
                        Gap(size.height * 0.05),
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
                          press: () {},
                        ),
                        const Gap(15),
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
