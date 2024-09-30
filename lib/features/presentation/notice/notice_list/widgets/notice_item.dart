import 'package:flutter/material.dart';
import 'package:school_of_future/core/utils/colors.dart';
import 'package:school_of_future/core/utils/text_styles.dart';
import 'package:school_of_future/core/widgets/text.dart';
import 'package:school_of_future/features/presentation/notice/notice_list/widgets/green_box.dart';

class ItemNotice extends StatelessWidget {
  const ItemNotice({
    super.key,
    required this.day,
    required this.month,
    required this.title,
    required this.secondLineValue,
    required this.thirdLineValue,
    required this.time,
    this.secondLineLabel = 'For',
    this.thirdLineLabel = 'By',
    required this.press,
  });
  final String day,
      month,
      title,
      secondLineValue,
      thirdLineValue,
      time,
      secondLineLabel,
      thirdLineLabel;
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
                padding: const EdgeInsets.fromLTRB(8, 10, 12, 10),
                child: GreenBox(
                  day: day,
                  month: month,
                ),
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextB(
                      text: title,
                      maxLines: 1,
                      textStyle: bBody2M,
                    ),
                    const SizedBox(height: 8),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "$secondLineLabel: ",
                            style: const TextStyle(color: bGray),
                          ),
                          TextSpan(
                            text: secondLineValue,
                            style: const TextStyle(color: kPrimaryColor),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: RichText(
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "$thirdLineLabel: ",
                                  style: const TextStyle(color: bGray),
                                ),
                                TextSpan(
                                  text: thirdLineValue,
                                  style: const TextStyle(color: kPrimaryColor),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: TextB(
                            text: time,
                            fontSize: 10,
                            fontColor: kTextDefaultColor.withOpacity(0.52),
                          ),
                        )
                      ],
                    )
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
