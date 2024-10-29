import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:school_of_future/core/navigator/navigator_key.dart';
import 'package:school_of_future/core/router/route_constents.dart';
import 'package:school_of_future/core/translations/local_keys.dart';
import 'package:school_of_future/core/utils/colors.dart';
import 'package:school_of_future/core/widgets/text.dart';
import 'package:school_of_future/features/presentation/app_dashboard/dashboard/widgets/feature_item.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class TeacherMenus extends StatelessWidget {
  const TeacherMenus({
    super.key,
    required this.panelController,
  });

  final PanelController panelController;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      scrollDirection: Axis.horizontal,
      crossAxisCount: 2,
      crossAxisSpacing: 5,
      mainAxisSpacing: 5,
      childAspectRatio: 1.3,
      children: [
        FeatureItem(
          iconName: "assets/images/feature_icons_svg/ic_notice.svg",
          title: context.tr(LocaleKeys.notice),
          press: () {
            panelController.close();
            navigatorKey.currentState!
                .pushNamedAndRemoveUntil(noticeList, ModalRoute.withName('/'));
          },
        ),
        FeatureItem(
          iconName: "assets/images/feature_icons_svg/ic_homework.svg",
          title: context.tr(LocaleKeys.homeWork),
          press: () {
            panelController.close();
            navigatorKey.currentState!.pushNamedAndRemoveUntil(
                teacherAssignmentListScreen, ModalRoute.withName('/'));
          },
        ),
        FeatureItem(
          iconName: "assets/images/feature_icons_svg/ic_classwork.svg",
          title: context.tr(LocaleKeys.classwork),
          press: () {
            panelController.close();
            navigatorKey.currentState!.pushNamedAndRemoveUntil(
                classworkListScreen, ModalRoute.withName('/'));
          },
        ),
        // FeatureItem(
        //   iconName: "assets/images/feature_icons_svg/ic_leave.svg",
        //   title: context.tr(LocaleKeys.leave),
        //   press: () {
        //     panelController.close();
        //     navigatorKey.currentState!.pushNamedAndRemoveUntil(
        //         leaveListScreen, ModalRoute.withName('/'));
        //   },
        // ),
        Column(
          children: [
            SizedBox(
              width: 60,
              height: 60,
              child: PopupMenuButton(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: bWhite,
                    borderRadius: BorderRadius.circular(5),
                    border:
                        Border.all(color: kTextDefaultColor.withOpacity(0.12)),
                  ),
                  child: SvgPicture.asset(
                    'assets/images/feature_icons_svg/ic_leave.svg',
                    colorFilter: ColorFilter.mode(
                      kTextDefaultColor.withOpacity(0.52),
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                itemBuilder: (context) {
                  return ["Own", "Student"].map((action) {
                    return PopupMenuItem(
                      value: action,
                      child: Text(action),
                    );
                  }).toList();
                },
                onSelected: (String value) {
                  if (value == "Student") {
                    panelController.close();
                    navigatorKey.currentState!.pushNamedAndRemoveUntil(
                        leaveListScreen, ModalRoute.withName('/'));
                  } else {
                    panelController.close();
                    navigatorKey.currentState!.pushNamedAndRemoveUntil(
                        teacherOwnleaveListScreen, ModalRoute.withName('/'));
                  }
                },
              ),
            ),
            const Gap(5),
            TextB(
              text: context.tr(LocaleKeys.leave),
              fontSize: 10,
              fontColor: kMenuTextColor,
            ),
          ],
        ),
        FeatureItem(
          iconName: "assets/images/feature_icons_svg/ic_resource.svg",
          title: context.tr(LocaleKeys.resources),
          press: () {
            panelController.close();
            navigatorKey.currentState!.pushNamedAndRemoveUntil(
                teacherResourcesListScreen, ModalRoute.withName('/'));
          },
        ),
        FeatureItem(
          iconName: "assets/images/feature_icons_svg/ic_lesson_plan.svg",
          title: context.tr(LocaleKeys.lessonPlan),
          press: () {
            panelController.close();
            navigatorKey.currentState!.pushNamedAndRemoveUntil(
                lessonPlanListScreen, ModalRoute.withName('/'));
          },
        ),
        FeatureItem(
          iconName: "assets/images/feature_icons_svg/ic_meeting.svg",
          title: context.tr(LocaleKeys.meeting),
          press: () {
            panelController.close();
            navigatorKey.currentState!.pushNamedAndRemoveUntil(
                teacherMeetingListScreen, ModalRoute.withName('/'));
          },
        ),
        FeatureItem(
          iconName: "assets/images/feature_icons_svg/ic_routine.svg",
          title: context.tr(LocaleKeys.routine),
          press: () {
            panelController.close();
            navigatorKey.currentState!.pushNamedAndRemoveUntil(
                routineScreen, ModalRoute.withName('/'));
          },
        ),
        FeatureItem(
          iconName: "assets/images/feature_icons_svg/ic_syllabus.svg",
          title: context.tr(LocaleKeys.syllabus),
          press: () {
            panelController.close();
            navigatorKey.currentState!.pushNamedAndRemoveUntil(
                teacherSyllabusListScreen, ModalRoute.withName('/'));
          },
        ),
        FeatureItem(
          iconName: "assets/images/feature_icons_svg/ic_transport.svg",
          title: context.tr(LocaleKeys.transport),
          press: () {
            panelController.close();
            navigatorKey.currentState!.pushNamedAndRemoveUntil(
                transportScreen, ModalRoute.withName('/'));
          },
        ),
        FeatureItem(
          iconName: "assets/images/feature_icons_svg/ic_attendance.svg",
          title: context.tr(LocaleKeys.attendance),
          press: () {
            panelController.close();
            navigatorKey.currentState!.pushNamedAndRemoveUntil(
                teacherAttendanceScreen, ModalRoute.withName('/'));
          },
        ),
        FeatureItem(
          iconName:
              "assets/images/feature_icons_svg/icon_digital_rep_inner.svg",
          title: context.tr(LocaleKeys.question),
          press: () {
            panelController.close();
            navigatorKey.currentState!.pushNamedAndRemoveUntil(
                questionBankScreen, ModalRoute.withName('/'));
          },
        ),
      ],
    );
  }
}
