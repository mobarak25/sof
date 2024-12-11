import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_of_future/core/router/route_constents.dart';
import 'package:school_of_future/core/translations/local_keys.dart';
import 'package:school_of_future/core/utils/colors.dart';
import 'package:school_of_future/core/utils/text_styles.dart';
import 'package:school_of_future/core/widgets/text.dart';

import 'package:school_of_future/features/domain/entities/exam_list_response.dart';
import 'package:school_of_future/features/presentation/app_dashboard/Student_home/widgets/section_title.dart';
import 'package:school_of_future/features/presentation/exam/teacher_exam_list/widgets/exam_card.dart';

class DashboarExam extends StatelessWidget {
  const DashboarExam({
    super.key,
    required this.examList,
    required this.pressToViewAll,
    required this.pressToDetails,
  });

  final ExamList examList;
  final VoidCallback pressToViewAll;
  final VoidCallback pressToDetails;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      decoration: const BoxDecoration(
        color: bWhite,
      ),
      child: Column(
        children: [
          SectionTitle(
            icon: "assets/images/ic_exam.svg",
            title: LocaleKeys.exams.tr(),
            press: () {
              pressToViewAll();
            },
          ),
          const Gap(30),
          ...List.generate(
            examList.data!.length <= 3 ? examList.data!.length : 3,
            (index) => ExamCardCard(
              isTeacher: false,
              data: examList.data![index],
              press: () {
                Navigator.of(context, rootNavigator: true).pushNamed(
                    teacherExamDetailsScreen,
                    arguments: examList.data![index].id);
              },
              prssToEditDel: (String pressTo, int id) {
                //bloc.add(PressToDelEdit(type: pressTo, id: id));
              },
            ),
          ),
        ],
      ),
    );
  }
}
