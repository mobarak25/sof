import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:school_of_future/core/navigator/navigator_key.dart';
import 'package:school_of_future/core/router/route_constents.dart';
import 'package:school_of_future/core/translations/local_keys.dart';
import 'package:school_of_future/features/presentation/app_dashboard/dashboard/widgets/feature_item.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class StudentMenus extends StatelessWidget {
  const StudentMenus({
    super.key,
    required this.panelController,
  });

  final PanelController panelController;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      scrollDirection: Axis.horizontal,
      crossAxisCount: 2,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
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
                studentAssignmentListScreen, ModalRoute.withName('/'));
          },
        ),
        FeatureItem(
          iconName: "assets/images/feature_icons_svg/ic_classwork.svg",
          title: context.tr(LocaleKeys.classwork),
          press: () {
            panelController.close();
            navigatorKey.currentState!.pushNamedAndRemoveUntil(
                studentClassworkListScreen, ModalRoute.withName('/'));
          },
        ),
        FeatureItem(
          iconName: "assets/images/feature_icons_svg/ic_leave.svg",
          title: context.tr(LocaleKeys.leave),
          press: () {
            panelController.close();
            navigatorKey.currentState!.pushNamedAndRemoveUntil(
                leaveListScreen, ModalRoute.withName('/'));
          },
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
      ],
    );
  }
}
