import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_of_future/core/router/route_constents.dart';
import 'package:school_of_future/core/translations/local_keys.dart';
import 'package:school_of_future/core/utils/colors.dart';
import 'package:school_of_future/core/utils/text_styles.dart';
import 'package:school_of_future/core/widgets/text.dart';
import 'package:school_of_future/features/domain/entities/full_syllabus_teacher_response.dart';

class FullSyllabusView extends StatelessWidget {
  const FullSyllabusView({
    super.key,
    required this.teacherFullSyllabus,
  });

  final FullSyllabusTeacher teacherFullSyllabus;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
        color: bWhite,
        child: teacherFullSyllabus.data != null
            ? ListView(
                children: [
                  Column(
                    children: [
                      TextB(
                        text: LocaleKeys.selectClass.tr(),
                        textStyle: bHead6B,
                      ),
                      const Gap(10),
                      Container(
                        height: 5,
                        width: 160,
                        decoration: BoxDecoration(
                          color: bJungleGreen,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      const Gap(30),
                      const TextB(
                        text: "Select class to see the syllabus.",
                        textStyle: bBase2,
                        fontColor: bGray32,
                      ),
                      const Gap(40),
                    ],
                  ),
                  ...List.generate(teacherFullSyllabus.data!.length,
                      (position) {
                    final dataItem = teacherFullSyllabus.data![position];
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Material(
                          color: bTransparentColor,
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context, rootNavigator: true)
                                  .pushNamed(
                                classworkDetailsScreen,
                                arguments: dataItem.id,
                              );
                            },
                            child: Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 20),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                border: Border.all(color: bJungleGreen),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: TextB(
                                text: dataItem.classData!.name!,
                                textStyle: bBody2,
                                fontColor: bGray100,
                              ),
                            ),
                          ),
                        ),
                        const Gap(15),
                      ],
                    );
                  }),
                  if (teacherFullSyllabus.data!.isEmpty)
                    TextB(
                      text: LocaleKeys.noResultFound.tr(),
                      textStyle: bBody1B,
                      fontColor: bRed,
                      alignMent: TextAlign.center,
                    ),
                ],
              )
            : const SizedBox(),
      ),
    );
  }
}
