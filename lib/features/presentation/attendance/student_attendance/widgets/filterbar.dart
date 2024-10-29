import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_of_future/core/translations/local_keys.dart';
import 'package:school_of_future/core/utils/colors.dart';
import 'package:school_of_future/core/utils/text_styles.dart';
import 'package:school_of_future/core/widgets/text.dart';

class FilterBar extends StatelessWidget {
  const FilterBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextB(
            text: LocaleKeys.attendanceOverView.tr(),
            textStyle: bBody1,
          ),
          GestureDetector(
            onTap: () {
              Scaffold.of(context).openEndDrawer();
            },
            child: Container(
              padding: const EdgeInsets.only(left: 15, right: 15),
              height: 55,
              decoration: const BoxDecoration(
                border: Border(left: BorderSide(color: bGray32)),
              ),
              child: const Icon(
                Icons.filter_alt,
                color: bGray32,
                size: 25,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
