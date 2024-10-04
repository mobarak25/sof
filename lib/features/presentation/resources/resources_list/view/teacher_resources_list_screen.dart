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
import 'package:school_of_future/features/presentation/resources/resources_list/bloc/teacher_resource_list_bloc.dart';
import 'package:school_of_future/features/presentation/resources/resources_list/widgets/resource_card.dart';

class TeacherResourcesListScreen extends StatelessWidget {
  const TeacherResourcesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scroll = ScrollController();
    return BlocBuilder<TeacherResourceListBloc, TeacherResourceListState>(
      builder: (context, state) {
        final bloc = context.read<TeacherResourceListBloc>();
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
            title: LocaleKeys.resources.tr(),
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
                showChapter: true,
                btnText: LocaleKeys.filter.tr(),
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
                  child: state.resources.data != null
                      ? Column(
                          children: [
                            Expanded(
                              child: GridView.count(
                                controller: scroll,
                                primary: false,
                                crossAxisSpacing: 15,
                                mainAxisSpacing: 15,
                                crossAxisCount: 2,
                                children: [
                                  ...List.generate(state.resources.data!.length,
                                      (position) {
                                    final dataItem =
                                        state.resources.data![position];
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.of(context,
                                                rootNavigator: true)
                                            .pushNamed(
                                          resourcesDetailsScreen,
                                          arguments: dataItem.id,
                                        );
                                      },
                                      child: ResourceCard(
                                        item: dataItem,
                                        isTeacher: state.isTeacher,
                                        pressTo: (String pressTo, int id) {
                                          bloc.add(PressToDelEdit(
                                              type: pressTo, id: id));
                                        },
                                      ),
                                    );
                                  }),
                                  if (state.resources.data!.isEmpty)
                                    TextB(
                                      text: LocaleKeys.noResultFound.tr(),
                                      textStyle: bBody1B,
                                      fontColor: bRed,
                                      alignMent: TextAlign.center,
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
                            if (!state.incrementLoader && state.isEndList)
                              const Padding(
                                padding: EdgeInsets.only(top: 15, bottom: 30),
                                child: TextB(
                                  text: "End of the list",
                                  textStyle: bBase2M,
                                  fontColor: bRed,
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
                    Navigator.of(context, rootNavigator: true)
                        .pushNamed(teacherResourcesCreateScreen, arguments: -1);
                  },
                )
            ],
          ),
        );
      },
    );
  }
}
