import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:school_of_future/core/utils/colors.dart';
import 'package:school_of_future/core/widgets/text.dart';

class FeatureItem extends StatelessWidget {
  const FeatureItem({
    super.key,
    required this.iconName,
    required this.title,
    required this.press,
    this.fontSize,
  });

  final String iconName;
  final String title;
  final VoidCallback press;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        press();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 60,
            height: 60,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: bWhite,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: kTextDefaultColor.withOpacity(0.12)),
            ),
            child: SvgPicture.asset(
              iconName,
              colorFilter: ColorFilter.mode(
                kTextDefaultColor.withOpacity(0.52),
                BlendMode.srcIn,
              ),
            ),
          ),
          const Gap(5),
          TextB(
            text: title,
            fontSize: fontSize ?? 10,
            fontColor: kMenuTextColor,
            alignMent: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
