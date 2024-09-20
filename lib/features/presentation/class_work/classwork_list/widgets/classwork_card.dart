import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
    required this.pressTo,
    required this.isTeacher,
  });

  final ClassworkItem item;
  final Function pressTo;
  final bool isTeacher;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: bWhite,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 18),
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
                              id: item.subjectGroupId!,
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
                                text: item.subject ?? '',
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
                                    text: item.attachment!.length.toString(),
                                    fontColor: bPrimaryColor,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    if (item.shortDescription!.isNotEmpty)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Gap(30),
                          TextB(
                            text: item.shortDescription ?? '',
                            maxLines: 2,
                          ),
                        ],
                      )
                  ],
                ),
              ),
            ],
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
                pressTo(value, item.id);
              },
            ),
          )
      ],
    );
  }
}
