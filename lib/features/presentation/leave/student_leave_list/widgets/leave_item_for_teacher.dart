import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_of_future/core/translations/local_keys.dart';
import 'package:school_of_future/core/utils/colors.dart';
import 'package:school_of_future/core/utils/text_styles.dart';
import 'package:school_of_future/core/utils/utilities.dart';
import 'package:school_of_future/core/widgets/button.dart';
import 'package:school_of_future/core/widgets/network_image.dart';
import 'package:school_of_future/core/widgets/text.dart';
import 'package:school_of_future/features/domain/entities/student_leave_list_response.dart';
import 'package:school_of_future/features/presentation/notice/notice_list/widgets/green_box.dart';

class LeaveItemForTeacher extends StatelessWidget {
  const LeaveItemForTeacher({
    super.key,
    required this.data,
    required this.press,
    required this.updateStatus,
  });
  final LeaveItem data;
  final VoidCallback press;
  final Function updateStatus;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: bWhite,
      clipBehavior: Clip.antiAlias,
      borderRadius: BorderRadius.circular(5),
      child: InkWell(
        onTap: () {
          press();
        },
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      border: Border.all(color: bGray12),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: NetworkImageB(imageUrl: data.student!.imageUrl!),
                  ),
                  const Gap(10),
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
                                text: "${LocaleKeys.name.tr()} : ",
                                style: const TextStyle(color: bGray),
                              ),
                              TextSpan(
                                text: data.student!.fullName ?? '',
                                style: const TextStyle(color: kPrimaryColor),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 5),
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
                                text: " ${LocaleKeys.duration.tr()} : ",
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
              const Gap(30),
              if (data.status == 1)
                Row(
                  children: [
                    Expanded(
                      child: ButtonB(
                        heigh: 45,
                        text: LocaleKeys.accept.tr(),
                        press: () {
                          updateStatus("accept");
                        },
                      ),
                    ),
                    const Gap(15),
                    Expanded(
                      child: ButtonB(
                        heigh: 45,
                        bgColor: bRed.withOpacity(0.2),
                        textColor: bRed,
                        text: LocaleKeys.reject.tr(),
                        press: () {
                          updateStatus("reject");
                        },
                      ),
                    ),
                  ],
                ),
              if (data.status != 1)
                Column(
                  children: [
                    const Divider(
                      thickness: 1,
                      height: 1,
                      color: bGray12,
                    ),
                    const Gap(10),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "${LocaleKeys.requestHasBeen.tr()} ",
                            style: const TextStyle(color: bGray, fontSize: 16),
                          ),
                          TextSpan(
                            text: data.status == 2
                                ? LocaleKeys.accepted.tr()
                                : LocaleKeys.rejected.tr(),
                            style: TextStyle(
                                color: data.status == 2 ? kPrimaryColor : bRed,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    const Gap(8),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
