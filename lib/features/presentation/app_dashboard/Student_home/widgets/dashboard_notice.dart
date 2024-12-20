import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_of_future/core/translations/local_keys.dart';
import 'package:school_of_future/core/utils/colors.dart';
import 'package:school_of_future/core/utils/text_styles.dart';
import 'package:school_of_future/core/widgets/text.dart';
import 'package:school_of_future/features/domain/entities/dashborard_notice_response.dart';

import 'package:school_of_future/features/presentation/app_dashboard/Student_home/widgets/section_title.dart';

class DashboardNotice extends StatelessWidget {
  const DashboardNotice(
      {super.key,
      required this.notice,
      required this.pressToViewAll,
      required this.pressToDetails});

  final DashboardNoticeRes notice;
  final VoidCallback pressToViewAll;
  final Function pressToDetails;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      decoration: const BoxDecoration(
        color: bWhite,
      ),
      child: Column(
        children: [
          SectionTitle(
            icon: "assets/images/ic_notice.svg",
            title: LocaleKeys.notice.tr(),
            press: () {
              pressToViewAll();
            },
          ),
          const Gap(30),
          ...List.generate(
            notice.data!.length <= 3 ? notice.data!.length : 3,
            (index) => Container(
              padding: const EdgeInsets.only(bottom: 20),
              child: Material(
                color: bTransparentColor,
                child: InkWell(
                  onTap: () {
                    pressToDetails(notice.data![index].id!);
                  },
                  child: Row(
                    children: [
                      TextB(
                        text: "${index + 1}".padLeft(2, '0'),
                        textStyle: bHead6B.copyWith(fontSize: 22),
                        fontColor: kTextDefaultColor.withOpacity(0.12),
                      ),
                      const Gap(10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextB(
                              text: notice.data![index].title ?? '',
                              maxLines: 1,
                              fontColor: bBlack,
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
        ],
      ),
    );
  }
}
