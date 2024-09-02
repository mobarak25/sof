import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_of_future/core/translations/local_keys.dart';
import 'package:school_of_future/core/utils/colors.dart';
import 'package:school_of_future/core/utils/subject_image_generator.dart';
import 'package:school_of_future/core/utils/text_styles.dart';
import 'package:school_of_future/core/widgets/text.dart';

class StudentAssignmentItem extends StatelessWidget {
  final String topicName;
  final String subjectName;
  final String dueDate;
  final String totalMark;
  final String daysLeft;
  final int? submissionStatus;
  final bool draftStatus;
  final int submissionRequired;
  final int subjectGroupId;
  const StudentAssignmentItem({
    super.key,
    required this.topicName,
    required this.subjectName,
    required this.dueDate,
    required this.totalMark,
    required this.daysLeft,
    required this.submissionStatus,
    required this.draftStatus,
    required this.submissionRequired,
    required this.subjectGroupId,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: kWhiteColor,
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: kWhiteColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5),
                    bottomLeft: Radius.circular(5),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: SizedBox(
                            height: 60,
                            width: 60,
                            child:
                                appGenerateSvgWidgetFromId(id: subjectGroupId),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        if (submissionStatus == null)
                          Container(
                            width: 65,
                            color: bRed, //_createColorAccordingToDraftSub(),
                            alignment: Alignment.center,
                            child: TextB(
                              text: LocaleKeys.subReqAssignment.tr(),
                              fontSize: 9,
                              fontColor: bWhite,
                            ),
                          ),
                        if (submissionStatus == 0)
                          Container(
                            width: 65,
                            color: bRed, //_createColorAccordingToDraftSub(),
                            alignment: Alignment.center,
                            child: TextB(
                              text: LocaleKeys.submitted.tr(),
                              fontSize: 9,
                              fontColor: bWhite,
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(width: 16),
                    Flexible(
                        child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextB(
                          text: topicName,
                          textStyle: bBody1,
                          fontColor: kTextAnotherColor,
                          maxLines: 1,
                        ),
                        const Gap(10),
                        TextB(
                          text: subjectName,
                          textStyle: bBase,
                          fontColor: kPrimaryColor,
                        ),
                        const Gap(5),
                        Row(
                          children: [
                            TextB(
                              text: '${LocaleKeys.dueDateAssignment.tr()}: ',
                              textStyle: bSub1,
                              fontColor: kTextDefaultColor.withOpacity(0.5),
                            ),
                            Flexible(
                              child: TextB(
                                text: dueDate,
                                textStyle: bBase,
                                fontColor: kPrimaryColor,
                              ),
                            ),
                          ],
                        ),
                        const Gap(5),
                        Row(
                          children: [
                            TextB(
                              text: '${LocaleKeys.totalMark.tr()}: ',
                              textStyle: bBase,
                              fontColor: kTextDefaultColor.withOpacity(0.5),
                            ),
                            TextB(
                              text: totalMark,
                              textStyle: bBase,
                              fontColor: kPrimaryColor,
                            ),
                          ],
                        ),
                      ],
                    )),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(5),
                      bottomRight: Radius.circular(5)),
                  color: kHtmlBodyBGColor.withOpacity(0.045),
                ),
                alignment: Alignment.center,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextB(
                      text: daysLeft,
                      textStyle: bHead6,
                      fontColor: kPrimaryColor,
                    ),
                    const Gap(1),
                    TextB(
                      text: LocaleKeys.daysLeftAssignment.tr(),
                      textStyle: bBase,
                      fontColor: kTextDefaultColor.withOpacity(0.5),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  // Widget? _createTextAccordingToDraftSub() {
  //   if (draftStatus) {
  //     return Text(LocaleKeys.draft.tr(),
  //         style: bSub1.copyWith(color: kWhiteColor, fontSize: 13));
  //   } else {
  //     if (submissionStatus != null) {
  //       if ((submissionStatus == 0 || submissionStatus == 1)) {
  //         return Text(LocaleKeys.submitted.tr(),
  //             style: bSub1.copyWith(color: kWhiteColor, fontSize: 13));
  //       } else if (submissionStatus == 2) {
  //         return Text(LocaleKeys.resubmit.tr(),
  //             style: bSub1.copyWith(color: kWhiteColor, fontSize: 13));
  //       } else {
  //         return Text(LocaleKeys.deny.tr(),
  //             style: bSub1.copyWith(color: kWhiteColor, fontSize: 13));
  //       }
  //     } else {
  //       return null;
  //     }
  //   }
  // }

  // Color? _createColorAccordingToDraftSub() {
  //   if (draftStatus) {
  //     return kSecondaryColor;
  //   } else {
  //     if (submissionStatus != null) {
  //       if ((submissionStatus == 0 ||
  //           submissionStatus == 1 ||
  //           submissionStatus == 2)) {
  //         return kPrimaryColor;
  //       } else {
  //         return kErrorColor;
  //       }
  //     } else {
  //       return null;
  //     }
  //   }
  // }
}
