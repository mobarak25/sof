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
import 'package:school_of_future/features/presentation/quiz/explanation/bloc/explanation_bloc.dart';

class ExplanationScreen extends StatelessWidget {
  const ExplanationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExplanationBloc, ExplanationState>(
      builder: (context, state) {
        final bloc = context.read<ExplanationBloc>();

        return Body(
          isFullScreen: true,
          appBar: FutureAppBar(
            actions: const [SizedBox()],
            title: LocaleKeys.explanation.tr(),
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
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 5),
                            child: TextB(
                              text: "01. ",
                              textStyle: bSub1M,
                              fontColor: bGray32,
                            ),
                          ),
                          Expanded(
                            child: TextB(
                              text:
                                  "The length of the bridge, which a train 130 metres long and travelling at 45km/hr can cross in 30 seconds, is:",
                              textStyle: bSub1M,
                              fontColor: bGray100,
                            ),
                          ),
                        ],
                      ),
                      const Gap(30),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Answer: ',
                              style: bBody2M.copyWith(color: bGray52),
                            ),
                            TextSpan(
                              text: "B. 250 m",
                              style: bBody1B.copyWith(color: kPrimaryColor),
                            ),
                          ],
                        ),
                      ),
                      const Gap(30),
                      const Divider(height: 1, thickness: 1, color: bGray12),
                      const Gap(20),
                      ButtonB(
                        heigh: 50,
                        bgColor: kSecondaryColor.withOpacity(0.15),
                        textColor: kSecondaryColor,
                        fontSize: 16,
                        text: "Explanation:",
                        press: () {
                          Navigator.of(context, rootNavigator: true)
                              .pushNamed(quizFinishScreen);
                        },
                      ),
                      const Gap(30),
                      const TextB(
                          text:
                              "Proin ac quam et lectus vestibulum blandit. Nunc maximus nibh at placerat tincidunt. Nam sem lacus, ornare non ante sed, ultricies fringilla massa. Ut congue, elit non tempus elementum, sem risus tincidunt diam, vitae sodales diam ipsum vitae purus. Fusce tristique erat nulla, vel viverra mi."),
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
