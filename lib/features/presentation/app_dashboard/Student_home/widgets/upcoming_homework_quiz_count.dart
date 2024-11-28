import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_of_future/core/translations/local_keys.dart';
import 'package:school_of_future/core/utils/colors.dart';
import 'package:school_of_future/core/utils/text_styles.dart';
import 'package:school_of_future/core/widgets/text.dart';

class UpcomingHomeWorkQuizCount extends StatelessWidget {
  const UpcomingHomeWorkQuizCount({
    super.key,
    required this.homeWortCount,
    required this.quizCount,
  });

  final int homeWortCount, quizCount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              decoration: BoxDecoration(
                color: kHomeWorkDashboardBGColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.description,
                    size: 30,
                    color: kHomeWorkDashboardBGColor,
                  ),
                  const Gap(3),
                  const TextB(
                    text: "0",
                    textStyle: bHead6B,
                    fontColor: kHomeWorkDashboardBGColor,
                  ),
                  const Gap(5),
                  TextB(
                    text: context.tr(LocaleKeys.homeWork),
                  ),
                ],
              ),
            ),
          ),
          const Gap(10),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              decoration: BoxDecoration(
                color: bRed.withOpacity(0.18),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.description,
                    size: 30,
                    color: bRed,
                  ),
                  const Gap(3),
                  const TextB(
                    text: "0",
                    textStyle: bHead6B,
                    fontColor: bRed,
                  ),
                  const Gap(5),
                  TextB(
                    text: context.tr(LocaleKeys.onlineQuiz),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
