import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:school_of_future/core/translations/local_keys.dart';
import 'package:school_of_future/core/utils/colors.dart';
import 'package:school_of_future/core/utils/text_styles.dart';
import 'package:school_of_future/core/utils/utilities.dart';
import 'package:school_of_future/core/widgets/text.dart';
import 'package:school_of_future/features/domain/entities/quiz_list_response.dart';

class QuizCard extends StatelessWidget {
  const QuizCard({
    super.key,
    required this.data,
    required this.press,
    required this.prssToEditDel,
  });
  final QuizItem data;
  final VoidCallback press;
  final Function prssToEditDel;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Material(
            color: bWhite,
            clipBehavior: Clip.antiAlias,
            borderRadius: BorderRadius.circular(5),
            child: InkWell(
              onTap: () {
                press();
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 7),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 10),
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: kPrimaryColor.withOpacity(0.1),
                      ),
                      child: Column(
                        children: [
                          TextB(
                            text: "${data.totalMark}",
                            textStyle: bHead6B,
                            fontColor: kPrimaryColor,
                          ),
                          TextB(
                            text: getDate(
                                value: data.startDateTime!, formate: "MMMM"),
                            textStyle: bBase2,
                            fontColor: bGray52,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextB(
                            text: data.title ?? '',
                            maxLines: 1,
                            textStyle: bSub1M,
                          ),
                          const SizedBox(height: 8),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: data.subject!.name ?? '',
                                  style: const TextStyle(color: kPrimaryColor),
                                ),
                                const TextSpan(
                                  text: ' | ',
                                  style: TextStyle(color: bGray),
                                ),
                                TextSpan(
                                  text: data.subject!.subjectClass!.name!,
                                  style: const TextStyle(color: bGray),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 5),
                          RichText(
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "${LocaleKeys.time.tr()} : ",
                                  style: const TextStyle(color: bGray),
                                ),
                                TextSpan(
                                  text: getDate(
                                      value: data.startDateTime!,
                                      formate: "hh:mma"),
                                  style: const TextStyle(color: kPrimaryColor),
                                ),
                                const TextSpan(
                                  text: " - ",
                                  style: TextStyle(color: kPrimaryColor),
                                ),
                                TextSpan(
                                  text: getDate(
                                      value: data.endDateTime!,
                                      formate: "hh:mma"),
                                  style: const TextStyle(color: kPrimaryColor),
                                ),
                              ],
                            ),
                          ),
                          const Gap(3),
                          RichText(
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "${LocaleKeys.marks.tr()} : ",
                                  style: const TextStyle(color: bGray),
                                ),
                                TextSpan(
                                  text: "${data.totalMark}",
                                  style: const TextStyle(color: bGray),
                                ),
                                const TextSpan(
                                  text: " | ",
                                  style: TextStyle(color: bGray),
                                ),
                                TextSpan(
                                  text: "${LocaleKeys.question.tr()} : ",
                                  style: const TextStyle(color: bGray),
                                ),
                                TextSpan(
                                  text: "${data.totalQuestion}",
                                  style: const TextStyle(color: bGray),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        Positioned(
          right: 0,
          child: PopupMenuButton(
            icon: SvgPicture.asset('assets/images/three_dots.svg'),
            itemBuilder: (context) {
              return ["Edit", "Delete"].map((action) {
                return PopupMenuItem(
                  value: action,
                  child: Text(action),
                );
              }).toList();
            },
            onSelected: (String value) {
              prssToEditDel(value, data.id);
            },
          ),
        )
      ],
    );
  }
}
