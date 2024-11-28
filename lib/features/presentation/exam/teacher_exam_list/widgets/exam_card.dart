import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:school_of_future/core/translations/local_keys.dart';
import 'package:school_of_future/core/utils/colors.dart';
import 'package:school_of_future/core/utils/text_styles.dart';
import 'package:school_of_future/core/utils/utilities.dart';
import 'package:school_of_future/core/widgets/text.dart';
import 'package:school_of_future/features/domain/entities/exam_list_response.dart';

class ExamCardCard extends StatelessWidget {
  const ExamCardCard({
    super.key,
    required this.data,
    required this.press,
    required this.isTeacher,
    required this.prssToEditDel,
  });
  final ExamItem data;
  final VoidCallback press;
  final Function prssToEditDel;
  final bool isTeacher;

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
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      margin: const EdgeInsets.only(left: 10, right: 10),
                      decoration: BoxDecoration(
                        color: kPrimaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Column(
                        children: [
                          TextB(
                            text: getDate(value: data.date!, formate: "dd"),
                            textStyle: bHead6B,
                            fontColor: kPrimaryColor,
                          ),
                          TextB(
                            text: getDate(value: data.date!, formate: "MMMM"),
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
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 3),
                            decoration: BoxDecoration(
                              color: kSecondaryColor,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: TextB(
                              text: data.examGroup!.examCategory!.name!
                                  .toLowerCase(),
                              maxLines: 1,
                              textStyle: bCaption2,
                              fontColor: bWhite,
                            ),
                          ),
                          TextB(
                            text: data.examGroup!.name ?? '',
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
                                  text:
                                      "${context.tr(LocaleKeys.section)}: ${data.batch!.section!.name}",
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
                                  text: "${context.tr(LocaleKeys.time)} : ",
                                  style: const TextStyle(color: bGray),
                                ),
                                TextSpan(
                                  text: data.startTime ?? '',
                                  style: const TextStyle(color: kPrimaryColor),
                                ),
                                const TextSpan(
                                  text: " - ",
                                  style: TextStyle(color: kPrimaryColor),
                                ),
                                TextSpan(
                                  text: data.endTime ?? '',
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
                                  text: "${context.tr(LocaleKeys.marks)} : ",
                                  style: const TextStyle(color: bGray),
                                ),
                                TextSpan(
                                  text: data.maxMark.toString(),
                                  style: const TextStyle(color: bGray),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Gap(35),
                  ],
                ),
              ),
            ),
          ),
        ),
        if (isTeacher)
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
