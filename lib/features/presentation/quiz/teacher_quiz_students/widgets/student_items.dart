import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_of_future/core/translations/local_keys.dart';
import 'package:school_of_future/core/utils/colors.dart';
import 'package:school_of_future/core/utils/text_styles.dart';
import 'package:school_of_future/core/widgets/button.dart';
import 'package:school_of_future/core/widgets/network_image.dart';
import 'package:school_of_future/core/widgets/text.dart';
import 'package:school_of_future/features/domain/entities/quiz_students_response.dart';

class StduntItem extends StatelessWidget {
  const StduntItem(
      {super.key, required this.data, required this.pressToReview});

  final List<QuizStudentItem> data;
  final Function(QuizStudentItem) pressToReview;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        data.length,
        (index) => Column(
          children: [
            Row(
              children: [
                Container(
                  width: 65,
                  height: 65,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: bGray12),
                  ),
                  child:
                      NetworkImageB(imageUrl: data[index].student!.imageUrl!),
                ),
                const Gap(10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextB(
                        text: data[index].student!.firstName!,
                        textStyle: bSub2M,
                        fontColor: bGray100,
                        maxLines: 1,
                      ),
                      const Gap(4),
                      TextB(
                        text: "Roll: ${data[index].student!.admissionNumber!}",
                      ),
                    ],
                  ),
                ),
                const Gap(5),
                SizedBox(
                  width: 100,
                  child: ButtonB(
                    heigh: 48,
                    horizontalPadding: 0,
                    text: data[index].quizTime != null &&
                            data[index].quizTime!.isReviewed == 1
                        ? data[index].quizTime!.obtainedMark!.toString()
                        : context.tr(LocaleKeys.review),
                    bgColor:
                        data[index].quizTime == null ? bGray4 : kPrimaryColor,
                    textColor: data[index].quizTime == null ? bGray : bWhite,
                    press: () {
                      pressToReview(data[index]);
                    },
                  ),
                )
              ],
            ),
            const Gap(14),
          ],
        ),
      ),
    );
  }
}
