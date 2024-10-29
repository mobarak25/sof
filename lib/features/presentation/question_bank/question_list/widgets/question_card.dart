import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:school_of_future/core/translations/local_keys.dart';
import 'package:school_of_future/core/utils/colors.dart';
import 'package:school_of_future/core/utils/text_styles.dart';
import 'package:school_of_future/core/widgets/text.dart';
import 'package:school_of_future/features/domain/entities/question_bank_response.dart';
import 'package:school_of_future/features/presentation/notice/notice_list/widgets/green_box.dart';

class QuestionItemView extends StatelessWidget {
  const QuestionItemView({
    super.key,
    required this.data,
    required this.press,
    required this.prssToEditDel,
  });
  final QuestionItem data;
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
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: kPrimaryColor.withOpacity(0.1),
                    ),
                    child: Column(
                      children: [
                        TextB(
                          text: LocaleKeys.marks.tr(),
                          textStyle: bBase,
                          fontColor: bGray52,
                        ),
                        TextB(
                          text: "${data.mark!}",
                          textStyle: bHead6B,
                          fontColor: kPrimaryColor,
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
                                text: "${LocaleKeys.type.tr()} : ",
                                style: const TextStyle(color: bGray),
                              ),
                              TextSpan(
                                text: data.type == 1
                                    ? "MCQ"
                                    : data.type == 2
                                        ? "True False"
                                        : "Short Question",
                                style: const TextStyle(color: kPrimaryColor),
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
                                text: " ${LocaleKeys.date.tr()} : ",
                                style: const TextStyle(color: bGray),
                              ),
                              TextSpan(
                                text: data.subject!.name ?? '',
                                style: const TextStyle(color: kPrimaryColor),
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
