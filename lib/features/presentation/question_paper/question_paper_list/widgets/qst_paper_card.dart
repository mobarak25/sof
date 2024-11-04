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
import 'package:school_of_future/features/domain/entities/question_paper_list_response.dart';

class QstItemCard extends StatelessWidget {
  const QstItemCard({
    super.key,
    required this.item,
    required this.pressTo,
  });

  final PaperItem item;
  final Function pressTo;

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
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: SizedBox(
                        height: 60,
                        width: 60,
                        child: appGenerateSvgWidgetFromId(
                          id: item.subject!.id ?? 0,
                        ),
                      ),
                    ),
                    const Gap(8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextB(
                            text: item.name ?? '',
                            textStyle: bBody2M,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextB(
                                text: item.subject!.name ?? '',
                                fontColor: bPrimaryColor,
                              ),
                              Container(
                                height: 20,
                                width: 1,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                color: bGray12,
                              ),
                              Flexible(
                                child: TextB(
                                  text: "${item.type}",
                                  fontColor: kLabelColor,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextB(
                                text: '${LocaleKeys.date.tr()}: ',
                                fontColor: bPrimaryColor,
                              ),
                              Flexible(
                                child: TextB(
                                  text: getDate(
                                      value: item.datetime!,
                                      formate: "dd MMM, yyyy"),
                                  fontColor: kLabelColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(
                height: 1,
                thickness: 1,
                color: bGray12,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Row(
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextB(
                            text: "${item.totalQuestion!}",
                            textStyle: bHead6B,
                            fontColor: bPrimaryColor,
                          ),
                          const Gap(5),
                          TextB(
                            text: LocaleKeys.question.tr(),
                            fontColor: kTextDefaultColor,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 1,
                      height: 25,
                      color: bGray12,
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextB(
                            text: "${item.fullMark!}",
                            textStyle: bHead6B,
                            fontColor: bPrimaryColor,
                          ),
                          const Gap(5),
                          TextB(
                            text: LocaleKeys.marks.tr(),
                            fontColor: kTextDefaultColor,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
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
              pressTo(value, item.id);
            },
          ),
        )
      ],
    );
  }
}
