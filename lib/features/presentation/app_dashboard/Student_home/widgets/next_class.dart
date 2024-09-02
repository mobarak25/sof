import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:school_of_future/core/translations/local_keys.dart';
import 'package:school_of_future/core/utils/colors.dart';
import 'package:school_of_future/core/utils/subject_image_generator.dart';
import 'package:school_of_future/core/utils/text_styles.dart';
import 'package:school_of_future/core/widgets/text.dart';

class NextClassBody extends StatelessWidget {
  final bool isLoading;
  final int subjectGroupID;
  final String subjectName;
  final String startTime;
  final String roomNo;
  final bool isError;

  const NextClassBody(
      {super.key,
      required this.isLoading,
      required this.subjectName,
      required this.subjectGroupID,
      required this.roomNo,
      required this.startTime,
      required this.isError});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 20),
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 17, bottom: 17, left: 14),
            decoration: BoxDecoration(
              color: kNextClassBGColor,
              borderRadius: BorderRadius.circular(10),
            ),
            width: double.infinity,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: SizedBox(
                      height: 48,
                      width: 48,
                      child: appGenerateSvgWidgetFromId(id: subjectGroupID)),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextB(
                        text: LocaleKeys.nextClass.tr(),
                        fontColor: kTextThirdColor,
                        textStyle: bCaption2,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      TextB(
                        text: subjectName,
                        textStyle: bBody1,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                                text: LocaleKeys.startingAt.tr(),
                                style: TextStyle(
                                    color: kTextDefaultColor.withOpacity(0.52),
                                    fontSize: 12)),
                            TextSpan(
                                text: ' $startTime',
                                style: const TextStyle(
                                    color: kSecondaryColor, fontSize: 12)),
                            TextSpan(
                              text: ' - ${LocaleKeys.room.tr()} $roomNo',
                              style: TextStyle(
                                color: kTextDefaultColor.withOpacity(0.52),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Positioned(
              right: 10,
              top: 20,
              child: SvgPicture.asset(
                'assets/images/routine.svg',
                height: 70,
              ))
        ],
      ),
    );
  }
}
