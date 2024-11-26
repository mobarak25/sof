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
import 'package:school_of_future/features/presentation/class_work/teacher_classwork_list/bloc/classwork_list_bloc.dart';
import 'package:school_of_future/features/presentation/class_work/teacher_classwork_list/widgets/classwork_card.dart';

class TeacherClassworkListScreen extends StatelessWidget {
  const TeacherClassworkListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scroll = ScrollController();
    return BlocBuilder<ClassworkListBloc, ClassworkListState>(
      builder: (context, state) {
        final bloc = context.read<ClassworkListBloc>();
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
            title: context.tr(LocaleKeys.classwork),
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
                showStartDate: true,
                showVersion: true,
                showClass: true,
                showSubject: true,
                showSection: true,
                btnText: context.tr(LocaleKeys.filter),
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
                    context.tr(LocaleKeys.published),
                    context.tr(LocaleKeys.draft),
                  ],
                  onTabChanged: (int tabIndex) {
                    bloc.add(DataForTab(
                        tabIndex: tabIndex.toString(), filterBloc: filterBloc));
                  },
                  search: (String value) {
                    bloc.add(ChangeSearch(
                        searchText: value, filterBloc: filterBloc));
                  },
                  child: state.classworkList.data != null
                      ? Column(
                          children: [
                            Expanded(
                              child: ListView(
                                controller: scroll,
                                children: [
                                  ...List.generate(
                                      state.classworkList.data!.length,
                                      (position) {
                                    final dataItem =
                                        state.classworkList.data![position];
                                    return Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.of(context,
                                                    rootNavigator: true)
                                                .pushNamed(
                                              classworkDetailsScreen,
                                              arguments: dataItem.id,
                                            );
                                          },
                                          child: ClassworkCard(
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
                                  if (state.classworkList.data!.isEmpty)
                                    TextB(
                                      text:
                                          context.tr(LocaleKeys.noResultFound),
                                      textStyle: bBody1B,
                                      fontColor: bRed,
                                      alignMent: TextAlign.center,
                                    ),
                                  if (!state.incrementLoader && state.isEndList)
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 15, bottom: 30),
                                      child: TextB(
                                        text:
                                            context.tr(LocaleKeys.endOfTheList),
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
                    // Navigator.pushNamed(navigatorKey.currentState!.context,
                    //     teacherAssignmentCreateScreen);

                    Navigator.of(context, rootNavigator: true)
                        .pushNamed(teacherClassworkCreateSreen, arguments: -1);
                  },
                )
            ],
          ),
        );
      },
    );
  }
}
