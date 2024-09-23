import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_of_future/core/translations/local_keys.dart';
import 'package:school_of_future/core/utils/colors.dart';
import 'package:school_of_future/core/utils/subject_image_generator.dart';
import 'package:school_of_future/core/utils/text_styles.dart';
import 'package:school_of_future/core/utils/utilities.dart';
import 'package:school_of_future/core/widgets/text.dart';
import 'package:school_of_future/features/domain/entities/classwork_list_response.dart';

class ClassworkCard extends StatelessWidget {
  const ClassworkCard({
    super.key,
    required this.item,
  });

  final ClassworkItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: bWhite,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: SizedBox(
                        height: 60,
                        width: 60,
                        child: appGenerateSvgWidgetFromId(
                          id: item.subject!.subjectGroupId!,
                        ),
                      ),
                    ),
                    const Gap(15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextB(
                            text: item.title ?? '',
                            textStyle: bBody2M,
                          ),
                          const Gap(10),
                          TextB(
                            text: item.subject!.name ?? '',
                            fontColor: bPrimaryColor,
                          ),
                          Row(
                            children: [
                              TextB(
                                text: "${LocaleKeys.date.tr()} : ",
                                fontColor: kLabelColor,
                              ),
                              TextB(
                                text: getDate(
                                    value: item.publishedAt!,
                                    formate: "dd MMM, yyyy"),
                                fontColor: bPrimaryColor,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              TextB(
                                text: "${LocaleKeys.attachment.tr()} : ",
                                fontColor: kLabelColor,
                              ),
                              TextB(
                                text: item.attachments.toString(),
                                fontColor: bPrimaryColor,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
