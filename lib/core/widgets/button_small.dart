import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:school_of_future/core/utils/colors.dart';
import 'package:school_of_future/core/utils/text_styles.dart';
import 'package:school_of_future/core/widgets/text.dart';

class ButtonSB extends StatelessWidget {
  const ButtonSB({
    super.key,
    required this.press,
    required this.title,
    required this.iconUrl,
    this.iconHeight = 12,
  });
  final VoidCallback press;
  final String title;
  final String iconUrl;
  final double iconHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: bGreen,
          border: Border.all(color: bGray),
          borderRadius: BorderRadius.circular(5)),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: press,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(7, 5, 2, 5),
            child: Row(
              children: [
                TextB(
                  text: title,
                  textStyle: bBase2,
                  fontColor: bRed,
                ),
                SizedBox(
                  height: iconHeight,
                  child: SvgPicture.asset(
                    iconUrl,
                    colorFilter: const ColorFilter.mode(bRed, BlendMode.srcIn),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
