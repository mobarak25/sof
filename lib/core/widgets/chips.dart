import 'package:flutter/material.dart';
import 'package:school_of_future/core/utils/colors.dart';
import 'package:school_of_future/core/utils/enums.dart';
import 'package:school_of_future/core/utils/text_styles.dart';
import 'package:school_of_future/core/widgets/text.dart';

class ChipB extends StatelessWidget {
  const ChipB({
    super.key,
    required this.type,
    required this.title,
    this.isBg = false,
  });

  final String type, title;
  final bool isBg;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: isBg ? colorType(type)[0] : colorType(type)[1],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 5, 15, 7),
            child: TextB(
              text: title,
              textStyle: bBase2M,
              fontColor: isBg ? bWhite : colorType(type)[0],
            ),
          ),
        ),
      ),
    );
  }

  List<Color> colorType(String btnType) {
    if (btnType == ChipsType.Approved.name ||
        btnType == ChipsType.Approve.name) {
      return [bRed, bGreen];
    } else if (btnType == ChipsType.Processing.name) {
      return [bRed, bGreen];
    } else if (btnType == ChipsType.Cancel.name) {
      return [bRed, bGreen];
    } else {
      return [bRed, bGreen];
    }
  }
}
