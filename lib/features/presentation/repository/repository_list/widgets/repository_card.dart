import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:school_of_future/core/utils/colors.dart';
import 'package:school_of_future/core/utils/text_styles.dart';
import 'package:school_of_future/core/utils/utilities.dart';
import 'package:school_of_future/core/widgets/text.dart';
import 'package:school_of_future/features/domain/entities/respsitory_list_response.dart';

class RepositoryCard extends StatelessWidget {
  const RepositoryCard({super.key, required this.item});

  final RepositoryItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: bWhite,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    color: kPrimaryColor.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: SvgPicture.asset(
                    "assets/images/feature_icons_svg/icon_digital_rep_inner.svg",
                    colorFilter:
                        const ColorFilter.mode(kPrimaryColor, BlendMode.srcIn),
                  ),
                ),
                const Gap(10),
                Expanded(
                  child: TextB(
                    text: item.title ?? '',
                    textStyle: bBody1,
                    fontColor: kTextAnotherColor,
                  ),
                ),
              ],
            ),
          ),
          const Gap(10),
          const Divider(height: 1, thickness: 1, color: bGray4),
          const Gap(10),
          TextB(
            text: "${item.totalAttachments!.plural('Attachment')} ",
            textStyle: bBody2M,
            fontColor: kPrimaryColor,
          ),
          const Gap(15),
        ],
      ),
    );
  }
}
