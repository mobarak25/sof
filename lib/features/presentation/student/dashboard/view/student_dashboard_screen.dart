import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:school_of_future/core/ioc/global.dart';
import 'package:school_of_future/core/router/route_constents.dart';
import 'package:school_of_future/core/utils/asset_image.dart';
import 'package:school_of_future/core/utils/colors.dart';
import 'package:school_of_future/core/widgets/body.dart';
import 'package:school_of_future/features/presentation/student/dashboard/bloc/student_dashboard_bloc.dart';
import 'package:school_of_future/features/presentation/student/student_routes/student_routes.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class StudentDhasboard extends StatelessWidget {
  StudentDhasboard({super.key});

  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

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
                          // context
                          //     .read<DashboardMainBodyCubit>()
                          //     .onRouteChangeRequest('',
                          //         isDashBoardButtonRequest: true);
                        },
                        child: AbsorbPointer(
                          child: Column(
                            children: [
                              Image.asset(homeGradientIcon, height: 24),
                              const Gap(4),
                              const Text("Home")
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
                              const Text("Menu")
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                )),
            controller: panelController,
            color: bTransparentColor,
            boxShadow: const [],
            maxHeight: 350,
            onPanelOpened: () {
              bloc.add(const GetOpenClose(isOPen: true));
            },
            onPanelClosed: () {
              bloc.add(const GetOpenClose(isOPen: false));
            },

            body: Navigator(
              key: _navigatorKey,
              onGenerateRoute: studentsRoutes,
            ),

            panel: Stack(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 30),
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [Color(0xffEEF9F4), Color(0xffFFF8EB)],
                    ),
                  ),
                  child: Container(
                    padding: const EdgeInsets.only(top: 50),
                    child: Column(
                      children: [
                        ListTile(
                          leading: const Icon(Icons.home),
                          title: const Text('Home'),
                          onTap: () {
                            panelController.close();
                            _navigatorKey.currentState!.pushNamedAndRemoveUntil(
                                studentHome, ModalRoute.withName('/'));

                            // Navigator.pushNamed(context, '/other');
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.search),
                          title: const Text('Search'),
                          onTap: () {
                            //Navigator.pushNamed(context, '/search');

                            panelController.close();

                            // _navigatorKey.currentState!.pushNamed('/search');

                            _navigatorKey.currentState!.pushNamedAndRemoveUntil(
                                studentSearch, ModalRoute.withName('/'));
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.person),
                          title: const Text('Profile'),
                          onTap: () {
                            if (panelController.isPanelOpen) {
                              panelController.close();
                            }
                            //Navigator.pushNamed(context, '/profile');
                            // _navigatorKey.currentState!.pushNamed('/profile');

                            _navigatorKey.currentState!.pushNamedAndRemoveUntil(
                                studentProfile, ModalRoute.withName('/'));
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 71,
                    width: 71,
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
