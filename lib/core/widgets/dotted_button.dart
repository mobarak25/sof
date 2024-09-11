import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:school_of_future/core/utils/asset_image.dart';
import 'package:school_of_future/core/utils/colors.dart';
import 'package:school_of_future/core/utils/text_styles.dart';
import 'package:school_of_future/core/widgets/text.dart';

class DottedButtonB extends StatelessWidget {
  const DottedButtonB({
    super.key,
    required this.title,
    required this.press,
    this.bgColor = bWhite,
    this.borderColor = bGray32,
    this.svgIcon = fileUploadSvg,
    this.textColor = bGray32,
    this.svgColor = bRed,
    this.svgHeight = 40,
    this.verticalPadding = 5,
  });
  final double svgHeight, verticalPadding;
  final String title, svgIcon;
  final VoidCallback press;
  final Color bgColor, borderColor, textColor, svgColor;

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      color: borderColor,
      strokeWidth: 1.5,
      dashPattern: const [10, 6],
      borderType: BorderType.RRect,
      radius: const Radius.circular(10),
      padding: const EdgeInsets.all(1),
      child: Material(
        color: bgColor,
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          onTap: () {
            press();
          },
          child: Container(
            padding:
                EdgeInsets.symmetric(horizontal: verticalPadding, vertical: 10),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              // color: bWhite,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      svgIcon,
                      height: svgHeight,
                      colorFilter: ColorFilter.mode(svgColor, BlendMode.srcIn),
                    ),
                    const SizedBox(width: 10),
                    TextB(
                      text: title,
                      textStyle: bSub2,
                      fontColor: textColor,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
