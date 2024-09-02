import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:school_of_future/core/utils/colors.dart';
import 'package:school_of_future/core/utils/text_styles.dart';

class GuardianView extends StatelessWidget {
  final String serial;
  final String name;
  final String phone;
  final String relation;
  const GuardianView(
      {super.key,
      required this.name,
      required this.phone,
      required this.relation,
      required this.serial});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              serial,
              style: bHead1.copyWith(color: kGuardianTextColor, fontSize: 25),
            ),
            const SizedBox(
              width: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(phone),
                  const SizedBox(
                    height: 5,
                  ),
                  Text('${"Relation".tr()}: $relation')
                ],
              ),
            )
          ],
        ),
        const SizedBox(
          height: 5,
        )
      ],
    );
  }
}
