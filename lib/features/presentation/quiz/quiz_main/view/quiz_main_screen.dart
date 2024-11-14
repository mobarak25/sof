import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:school_of_future/core/translations/local_keys.dart';
import 'package:school_of_future/core/utils/asset_image.dart';
import 'package:school_of_future/core/utils/colors.dart';
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
    return BlocBuilder<QuizMainBloc, QuizMainState>(
      builder: (context, state) {
        final bloc = context.read<QuizMainBloc>();

        return Body(
          isFullScreen: true,
          appBar: FutureAppBar(
            actions: const [SizedBox()],
            title: LocaleKeys.explanation.tr(),
          ),
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.topCenter,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Gap(70),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 25),
                      color: bWhite,
                      child: ListView(
                        children: const [
                          TextB(text: "text"),
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
                            press: () {},
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
                            press: () {},
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
              const Positioned(
                top: 10,
                child: TimerRadius(),
              ),
            ],
          ),
        );
      },
    );
  }
}
