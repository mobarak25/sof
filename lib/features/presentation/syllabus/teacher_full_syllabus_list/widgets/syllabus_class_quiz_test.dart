import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_of_future/core/translations/local_keys.dart';
import 'package:school_of_future/core/utils/colors.dart';
import 'package:school_of_future/core/utils/text_styles.dart';
import 'package:school_of_future/core/widgets/button.dart';
import 'package:school_of_future/core/widgets/text.dart';
import 'package:school_of_future/features/presentation/app_common/filter_sidebar/view/filter_sidebar.dart';

class ClassQuidSyllabusView extends StatelessWidget {
  const ClassQuidSyllabusView({
    super.key,
    required this.pressContinue,
    required this.pressAddNew,
    required this.pageTitle,
  });
  final String pageTitle;
  final VoidCallback pressContinue;
  final VoidCallback pressAddNew;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        color: bWhite,
        child: ListView(
          children: [
            const Gap(20),
            TextB(
              text: pageTitle,
              textStyle: bHead6B,
              fontColor: bJungleGreen,
              alignMent: TextAlign.center,
            ),
            const Gap(10),
            FilterSidebar(
              paddingTop: 0,
              showVersion: true,
              showClass: true,
              showSubject: true,
              showSection: true,
              canPop: false,
              pressFilterBtn: () {
                pressContinue();
              },
              btnText: LocaleKeys.continueStr.tr(),
            ),
            const Gap(25),
            ButtonB(
              heigh: 60,
              bgColor: kSecondaryColor,
              text: LocaleKeys.addNewSyllabus.tr(),
              press: () {
                pressAddNew();
              },
            ),
            const Gap(90),
          ],
        ),
      ),
    );
  }
}
