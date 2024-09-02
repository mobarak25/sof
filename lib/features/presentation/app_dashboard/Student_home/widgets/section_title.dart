import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:school_of_future/core/translations/local_keys.dart';
import 'package:school_of_future/core/utils/colors.dart';
import 'package:school_of_future/core/utils/text_styles.dart';
import 'package:school_of_future/core/widgets/text.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    super.key,
    this.icon = '',
    required this.title,
    required this.press,
  });

  final String icon;
  final String title;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          icon,
          colorFilter: const ColorFilter.mode(kPrimaryColor, BlendMode.srcIn),
        ),
        const Gap(15),
        TextB(
          text: title,
          textStyle: bHead6B,
        ),
        const Spacer(),
        Material(
          clipBehavior: Clip.antiAlias,
          borderRadius: BorderRadius.circular(22),
          color: kPrimaryColor.withOpacity(0.08),
          child: InkWell(
            onTap: () {
              press();
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 10,
              ),
              child: TextB(
                text: LocaleKeys.viewAll.tr(),
                fontColor: kPrimaryColor,
                textStyle: bBody2M,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
