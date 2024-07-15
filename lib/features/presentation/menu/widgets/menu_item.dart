import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_of_future/core/utils/colors.dart';
import 'package:school_of_future/core/utils/text_styles.dart';
import 'package:school_of_future/core/widgets/text.dart';

class MenuItem extends StatelessWidget {
  const MenuItem(
      {super.key,
      required this.name,
      required this.press,
      required this.icon,
      this.color});

  final String name;
  final IconData icon;
  final VoidCallback press;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        press();
      },
      child: Container(
        width: size.width,
        padding: const EdgeInsets.symmetric(vertical: 15),
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: bGray12)),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: color ?? bJungleGreen,
            ),
            const Gap(15),
            TextB(
              text: name,
              textStyle: bSub1,
            ),
          ],
        ),
      ),
    );
  }
}
