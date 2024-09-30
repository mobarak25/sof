import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:school_of_future/core/router/route_constents.dart';
import 'package:school_of_future/core/translations/local_keys.dart';
import 'package:school_of_future/core/utils/colors.dart';
import 'package:school_of_future/core/utils/text_styles.dart';
import 'package:school_of_future/core/widgets/app_bar.dart';
import 'package:school_of_future/core/widgets/body.dart';
import 'package:school_of_future/core/widgets/floating_button.dart';
import 'package:school_of_future/core/widgets/text.dart';
import 'package:school_of_future/core/widgets/custom_tab.dart';
import 'package:school_of_future/features/presentation/app_common/filter_sidebar/bloc/filter_sidebar_bloc.dart';
import 'package:school_of_future/features/presentation/app_common/filter_sidebar/view/filter_sidebar.dart';
import 'package:school_of_future/features/presentation/lesson_plan/lesson_plan_list/bloc/lesson_plan_list_bloc.dart';
import 'package:school_of_future/features/presentation/lesson_plan/lesson_plan_list/widgets/lesson_plan_card.dart';

class LessonPlanListScreen extends StatelessWidget {
  const LessonPlanListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scroll = ScrollController();

    return BlocBuilder<LessonPlanListBloc, LessonPlanListState>(
      builder: (context, state) {
        final bloc = context.read<LessonPlanListBloc>();
        final filterBloc = context.read<FilterSidebarBloc>();

        if (state.isFirst) {
          bloc.add(
              DataForTab(tabIndex: state.activeTab, filterBloc: filterBloc));
        }
        scroll.addListener(() {
          if (scroll.position.pixels == scroll.position.maxScrollExtent) {
            bloc.add(PageIncrement(filterBloc: filterBloc));
          }
        });
        return Body(
          isFullScreen: true,
          appBar: FutureAppBar(
            actions: const [SizedBox()],
            title: LocaleKeys.lessonPlan.tr(),
          ),
          drawerChild: Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top,
              bottom: MediaQuery.of(context).padding.bottom,
              left: 10,
              right: 10,
            ),
            child: SingleChildScrollView(
              child: FilterSidebar(
                showVersion: state.isTeacher,
                showClass: state.isTeacher,
                showSubject: state.isTeacher,
                showSubjectForStudent: !state.isTeacher ? true : false,
                showSection: state.isTeacher,
                pressFilterBtn: () {
                  bloc.add(PressFilter(filterBloc: filterBloc));
                },
              ),
            ),
          ),
          child: Stack(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 13, horizontal: 15),
                color: bInnerBg,
                child: CustomTab(
                  loading: state.loading,
                  tabList: [
                    LocaleKeys.published.tr(),
                    LocaleKeys.draft.tr(),
                  ],
                  onTabChanged: (int tabIndex) {
                    bloc.add(DataForTab(
                        tabIndex: tabIndex.toString(), filterBloc: filterBloc));
                  },
                  search: (String value) {
                    bloc.add(ChangeSearch(
                        searchText: value, filterBloc: filterBloc));
                  },
                  child: state.lessonPlanList.data != null
                      ? Column(
                          children: [
                            Expanded(
                              child: ListView(
                                controller: scroll,
                                children: [
                                  ...List.generate(
                                      state.lessonPlanList.data!.length,
                                      (position) {
                                    final dataItem =
                                        state.lessonPlanList.data![position];
                                    return Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.of(context,
                                                    rootNavigator: true)
                                                .pushNamed(
                                              lessonPlanDetailsScreen,
                                              arguments: dataItem.id,
                                            );
                                          },
                                          child: PlanItemCard(
                                            item: dataItem,
                                            isTeacher: state.isTeacher,
                                            pressTo: (String pressTo, int id) {
                                              bloc.add(PressToDelEdit(
                                                  type: pressTo, id: id));
                                            },
                                          ),
                                        ),
                                        const Gap(15),
                                      ],
                                    );
                                  }),
                                  if (state.lessonPlanList.data!.isEmpty)
                                    TextB(
                                      text: LocaleKeys.noResultFound.tr(),
                                      textStyle: bBody1B,
                                      fontColor: bRed,
                                      alignMent: TextAlign.center,
                                    ),
                                  if (!state.incrementLoader && state.isEndList)
                                    const Padding(
                                      padding:
                                          EdgeInsets.only(top: 15, bottom: 30),
                                      child: TextB(
                                        text: "End of the list",
                                        textStyle: bBase2M,
                                        fontColor: bRed,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            if (state.incrementLoader)
                              const Center(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 20),
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                            const Gap(65),
                          ],
                        )
                      : const SizedBox(),
                ),
              ),
              if (state.isTeacher)
                FloatingButton(
                  press: () {
                    Navigator.of(context, rootNavigator: true).pushNamed(
                        teacherlessonPlanCreateScreen,
                        arguments: -1);
                  },
                )
            ],
          ),
        );
      },
    );
  }
}
