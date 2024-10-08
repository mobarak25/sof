import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:school_of_future/core/translations/local_keys.dart';
import 'package:school_of_future/core/utils/colors.dart';
import 'package:school_of_future/core/utils/text_styles.dart';
import 'package:school_of_future/core/utils/utilities.dart';
import 'package:school_of_future/core/widgets/text.dart';
import 'package:school_of_future/features/domain/entities/student_leave_list_response.dart';
import 'package:school_of_future/features/presentation/class_work/student_classwork_list/widgets/classwork_card.dart';
import 'package:school_of_future/features/presentation/notice/notice_list/widgets/green_box.dart';

class LeaveItemView extends StatelessWidget {
  const LeaveItemView({
    super.key,
    required this.data,
    required this.press,
  });
  final LeaveItem data;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 17),
                child: GreenBox(
                  day: getDate(value: data.startDate!, formate: "dd"),
                  month: getDate(value: data.startDate!, formate: "MMM"),
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
                            text: data.leaveType!.name ?? '',
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
                            text: "${data.startDate} - ${data.endDate}",
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
    );
  }
}
