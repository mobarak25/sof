import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:school_of_future/core/utils/colors.dart';
import 'package:school_of_future/core/utils/text_styles.dart';
import 'package:school_of_future/core/widgets/text.dart';

class ProfileContactItem extends StatelessWidget {
  final String svgIconLocation;
  final String title;
  final String bodyText;
  const ProfileContactItem(
      {super.key,
      required this.svgIconLocation,
      required this.title,
      required this.bodyText});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: bGray12.withOpacity(0.5),
          ),
        ),
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            svgIconLocation,
          ),
          const SizedBox(
            width: 11,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextB(
                text: title,
                textStyle: bBody1B,
              ),
              const SizedBox(
                height: 4,
              ),
              TextB(
                text: bodyText,
                textStyle: bSub2M,
                fontColor: kTextDefaultColor.withOpacity(0.5),
              )
            ],
          )
        ],
      ),
    );
  }
}
