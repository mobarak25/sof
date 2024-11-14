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
import 'package:school_of_future/core/widgets/custom_tab.dart';
import 'package:school_of_future/core/widgets/floating_button.dart';
import 'package:school_of_future/core/widgets/text.dart';
import 'package:school_of_future/features/presentation/app_common/filter_sidebar/bloc/filter_sidebar_bloc.dart';
import 'package:school_of_future/features/presentation/app_common/filter_sidebar/view/filter_sidebar.dart';
import 'package:school_of_future/features/presentation/quiz/teacher_quiz_list/bloc/quiz_list_screen_bloc.dart';
import 'package:school_of_future/features/presentation/quiz/teacher_quiz_list/widgets/quiz_card.dart';

class QuizListScreen extends StatelessWidget {
  const QuizListScreen({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    final scroll = ScrollController();

    return BlocBuilder<QuizListScreenBloc, QuizListScreenState>(
      builder: (context, state) {
        final bloc = context.read<QuizListScreenBloc>();
        final filterBloc = context.read<FilterSidebarBloc>();

        scroll.addListener(() {
          if (scroll.position.pixels == scroll.position.maxScrollExtent) {
            bloc.add(PageIncrement());
          }
        });
        return Body(
          isFullScreen: true,
          appBar: FutureAppBar(
            actions: const [SizedBox()],
            title: LocaleKeys.onlineQuiz.tr(),
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
                showVersion: true,
                showClass: true,
                showSubject: true,
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
                child: state.quizList.data != null
                    ? CustomTab(
                        loading: state.loading,
                        tabList: const [],
                        onTabChanged: (int tabIndex) {},
                        search: (String value) {
                          bloc.add(ChangeSearch(
                              searchText: value, filterBloc: filterBloc));
                        },
                        child: Column(
                          children: [
                            Expanded(
                              child: ListView(
                                controller: scroll,
                                children: [
                                  ...List.generate(
                                    state.quizList.data!.length,
                                    (index) {
                                      return QuizCard(
                                        data: state.quizList.data![index],
                                        press: () {},
                                        prssToEditDel:
                                            (String pressTo, int id) {
                                          bloc.add(PressToDelEdit(
                                              type: pressTo, id: id));
                                        },
                                      );
                                    },
                                  ),
                                  if (state.quizList.data!.isEmpty)
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
                        ))
                    : const Center(
                        child: CircularProgressIndicator(),
                      ),
              ),
              FloatingButton(
                press: () {
                  Navigator.of(context, rootNavigator: true)
                      .pushNamed(quizCreateScreen, arguments: -1);
                },
              )
            ],
          ),
        );
      },
    );
  }
}
