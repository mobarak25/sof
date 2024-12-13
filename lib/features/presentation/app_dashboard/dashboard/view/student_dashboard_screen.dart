import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:school_of_future/core/ioc/global.dart';
import 'package:school_of_future/core/navigator/navigator_key.dart';
import 'package:school_of_future/core/router/route_constents.dart';
import 'package:school_of_future/core/translations/local_keys.dart';
import 'package:school_of_future/core/utils/asset_image.dart';
import 'package:school_of_future/core/utils/colors.dart';
import 'package:school_of_future/core/widgets/body.dart';
import 'package:school_of_future/features/presentation/app_dashboard/dashboard/bloc/student_dashboard_bloc.dart';
import 'package:school_of_future/features/presentation/app_dashboard/dashboard/widgets/student_menus.dart';
import 'package:school_of_future/features/presentation/app_dashboard/dashboard/widgets/teacher_menus.dart';
import 'package:school_of_future/core/router/inner_routes.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class StudentDhasboard extends StatelessWidget {
  const StudentDhasboard({super.key});

  // final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    final PanelController panelController = getIt<PanelController>();

    return BlocBuilder<StudentDashboardBloc, StudentDashboardState>(
      builder: (context, state) {
        final bloc = context.read<StudentDashboardBloc>();
        final size = MediaQuery.of(context).size;
        return Body(
          isFullScreen: true,
          child: SlidingUpPanel(
            footer: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Color(0xffEEF9F4), Color(0xffFFF8EB)],
                ),
              ),
              width: size.width,
              child: Padding(
                padding: const EdgeInsets.only(left: 43, right: 43, top: 14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        navigatorKey.currentState!
                            .popUntil((route) => route.isFirst);
                      },
                      child: AbsorbPointer(
                        child: Column(
                          children: [
                            Image.asset(homeGradientIcon, height: 24),
                            const Gap(4),
                            Text(context.tr(LocaleKeys.home)),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context, rootNavigator: true)
                            .pushNamed(menuScreen);
                      },
                      child: AbsorbPointer(
                        child: Column(
                          children: [
                            Image.asset(menuIcon, height: 20),
                            const Gap(4),
                            Text(context.tr(LocaleKeys.menu)),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            controller: panelController,
            color: bTransparentColor,
            boxShadow: const [],
            maxHeight: 320,
            onPanelOpened: () {
              bloc.add(const GetOpenClose(isOPen: true));
            },
            onPanelClosed: () {
              bloc.add(const GetOpenClose(isOPen: false));
            },

            body: Navigator(
              key: navigatorKey,
              onGenerateRoute: studentsRoutes,
            ),

            panel: Stack(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [Color(0xffEEF9F4), Color(0xffFFF8EB)],
                    ),
                  ),
                  child: Container(
                    padding: const EdgeInsets.only(top: 45, bottom: 50),
                    child: state.isTeacher
                        ? TeacherMenus(panelController: panelController)
                        : StudentMenus(panelController: panelController),
                  ),
                ),
                // const Gap(120),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 65,
                    width: 65,
                    alignment: Alignment.topCenter,
                    decoration: const BoxDecoration(
                      color: Color(0xffF7F9EF),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: state.panelIsOpen
                          ? const Icon(Icons.keyboard_arrow_down_rounded)
                          : const Icon(Icons.keyboard_arrow_up_rounded),
                      onPressed: () {
                        bloc.add(PanelControlOnClick(
                            panelController: panelController));
                      },
                    ),
                  ),
                )
              ],
            ),
            //child: const TextB(text: "Student dashboard"),
          ),
        );
      },
    );
  }
}
