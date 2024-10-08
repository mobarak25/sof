import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_of_future/core/router/route_constents.dart';
import 'package:school_of_future/core/translations/local_keys.dart';
import 'package:school_of_future/core/utils/colors.dart';
import 'package:school_of_future/core/widgets/app_bar.dart';
import 'package:school_of_future/core/widgets/body.dart';
import 'package:school_of_future/core/widgets/custom_tab.dart';
import 'package:school_of_future/features/presentation/app_common/filter_sidebar/bloc/filter_sidebar_bloc.dart';
import 'package:school_of_future/features/presentation/syllabus/teacher_full_syllabus_list/bloc/teacher_syllabus_list_bloc.dart';
import 'package:school_of_future/features/presentation/syllabus/teacher_full_syllabus_list/widgets/full_syllabus.dart';
import 'package:school_of_future/features/presentation/syllabus/teacher_full_syllabus_list/widgets/syllabus_class_quiz_test.dart';

class TeacherSyllabusListScreen extends StatelessWidget {
  const TeacherSyllabusListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TeacherSyllabusListBloc, TeacherSyllabusListState>(
      builder: (context, state) {
        final bloc = context.read<TeacherSyllabusListBloc>();
        final filterBloc = context.read<FilterSidebarBloc>();

        return Body(
          isFullScreen: true,
          appBar: FutureAppBar(
            actions: const [SizedBox()],
            title: LocaleKeys.syllabus.tr(),
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 15),
            color: bInnerBg,
            child: CustomTab(
              loading: state.loading,
              showSearch: false,
              tabList: [
                LocaleKeys.full.tr(),
                LocaleKeys.classTest.tr(),
                LocaleKeys.quiz.tr(),
              ],
              onTabChanged: (int tabIndex) {
                bloc.add(DataForTab(tabIndex: tabIndex.toString()));
              },
              search: (String value) {},
              child: Column(
                children: [
                  if (state.activeTab == "0")
                    FullSyllabusView(
                      teacherFullSyllabus: state.teacherFullSyllabus,
                    )
                  else
                    ClassQuidSyllabusView(
                      pageTitle: state.activeTab == '1'
                          ? "Class Test Syllabus"
                          : "Quiz Test Syllabus",
                      pressContinue: () {
                        Navigator.of(context, rootNavigator: true).pushNamed(
                          syllabusClassQuizScreen,
                          arguments: {
                            "type": state.activeTab == '1'
                                ? "class-test"
                                : "quiz-test",
                            "version_id": filterBloc.state.selectedVersionId,
                            "class_id": filterBloc.state.selectedClassId,
                            "subject_id": filterBloc.state.selectedSubjectId,
                            "section_id": filterBloc.state.selectSectionId,
                          },
                        );
                      },
                      pressAddNew: () {
                        Navigator.of(context, rootNavigator: true).pushNamed(
                          teacherSyllabusCreateScreen,
                          arguments: -1,
                        );
                      },
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
