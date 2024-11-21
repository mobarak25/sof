import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:school_of_future/core/utils/colors.dart';
import 'package:school_of_future/core/utils/text_styles.dart';

import 'text.dart';

class ButtonB extends StatelessWidget {
  final String? text;
  final Color? textColor;
  final Color borderColor;
  final Color? bgColor;
  final double? heigh;
  final bool? shadow;
  final double? fontSize;
  final VoidCallback press;
  final bool loading;
  final FontWeight fontWeight;
  final double? horizontalPadding;
  final double? verticalPadding;
  final String svgIcon;
  final double? svgIconSize;

  final String iconPosition;

  const ButtonB({
    super.key,
    required this.text,
    this.textColor = bWhite,
    this.bgColor = bPrimaryColor,
    this.svgIcon = '',
    this.svgIconSize,
    this.borderColor = Colors.transparent,
    this.heigh = 20,
    this.shadow = false,
    required this.press,
    this.fontSize = 17,
    this.fontWeight = FontWeight.w500,
    this.loading = false,
    this.horizontalPadding,
    this.verticalPadding,
    this.iconPosition = "right",
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(7),
      child: InkWell(
        onTap: press,
        child: Ink(
          height: heigh,
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding ?? 0),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(7),
            border: Border.all(color: borderColor),
            boxShadow: shadow!
                ? const [
                    BoxShadow(
                      color: bWhite,
                      offset: Offset(-3.62, -2.41), //(x,y)
                      blurRadius: 4.83,
                    ),
                    BoxShadow(
                      color: Color(0xFFB9BCCB),
                      offset: Offset(2.41, 3.62), //(x,y)
                      blurRadius: 4.83,
                    ),
                  ]
                : [],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (iconPosition == 'left')
                if (loading)
                  SizedBox(
                    height: 16,
                    width: 16,
                    child: CircularProgressIndicator(
                      color: textColor,
                      strokeWidth: 1.5,
                    ),
                  )
                else
                  SvgPicture.asset(
                    svgIcon,
                    width: svgIconSize,
                    colorFilter: ColorFilter.mode(textColor!, BlendMode.srcIn),
                  ),
              SizedBox(width: horizontalPadding ?? 20),
              TextB(
                text: text!,
                fontColor: textColor,
                textStyle: bBody1M,
                fontSize: fontSize,
              ),
              SizedBox(width: horizontalPadding ?? 20),
              if (iconPosition == 'right')
                if (loading)
                  SizedBox(
                    height: 16,
                    width: 16,
                    child: CircularProgressIndicator(
                      color: textColor,
                      strokeWidth: 1.5,
                    ),
                  )
                else
                  SvgPicture.asset(
                    svgIcon,
                    width: svgIconSize,
                    colorFilter: ColorFilter.mode(textColor!, BlendMode.srcIn),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
