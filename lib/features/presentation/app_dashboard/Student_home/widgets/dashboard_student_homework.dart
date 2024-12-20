import 'package:gap/gap.dart';
import 'package:flutter/material.dart';
import 'package:school_of_future/core/utils/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:school_of_future/core/translations/local_keys.dart';
import 'package:school_of_future/features/domain/entities/assignment_list_response.dart';
import 'package:school_of_future/features/presentation/app_dashboard/Student_home/widgets/section_title.dart';
import 'package:school_of_future/features/presentation/assignment/student_assignment_list/widgets/assignment_item.dart';
import 'package:school_of_future/features/presentation/assignment/teacher_assignment_list/widgets/assignment_card.dart';

class DashboarStudentHomework extends StatelessWidget {
  const DashboarStudentHomework({
    super.key,
    required this.homework,
    required this.pressToViewAll,
    required this.pressToDetails,
  });

  final AssignmentResponse homework;
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
            icon: "assets/images/ic_homework.svg",
            title: LocaleKeys.homeWork.tr(),
            press: () {
              pressToViewAll();
            },
          ),
          const Gap(30),
          ...List.generate(
            homework.data!.length <= 3 ? homework.data!.length : 3,
            (index) => Container(
              margin: EdgeInsets.only(
                bottom: index ==
                        (homework.data!.length <= 3
                            ? homework.data!.length - 1
                            : 2)
                    ? 0
                    : 12,
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: const [
                    BoxShadow(
                        color: bGray12, offset: Offset(0, 0), blurRadius: 15),
                  ]),
              child: StudentAssignmentItem(
                item: homework.data![index],
                // pressTo: (String pressTo, int id) {
                //   // bloc.add(PressToDelEdit(type: pressTo, id: id));
                // },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
