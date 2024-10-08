import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_of_future/core/translations/local_keys.dart';
import 'package:school_of_future/core/utils/colors.dart';
import 'package:school_of_future/core/utils/utilities.dart';
import 'package:school_of_future/core/widgets/app_bar.dart';
import 'package:school_of_future/core/widgets/body.dart';
import 'package:school_of_future/core/widgets/custom_tab.dart';
import 'package:school_of_future/core/widgets/doc_viewer_page.dart';
import 'package:school_of_future/core/widgets/text.dart';
import 'package:school_of_future/features/presentation/syllabus/student_syllabus/bloc/student_syllabus_bloc.dart';

class StudentSyllabusScreen extends StatelessWidget {
  const StudentSyllabusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StudentSyllabusBloc, StudentSyllabusState>(
      builder: (context, state) {
        final bloc = context.read<StudentSyllabusBloc>();

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
                    //const TextB(text: "text")
                    if (state.studentFullSyllabus.data != null)
                      Column(
                        children: List.generate(
                          state.studentFullSyllabus.data!.length,
                          (index) => DocViewerScreen(
                            url: generateValidUrl(
                                state.studentFullSyllabus.data![index].url!),
                          ),
                        ),
                      )
                    else
                      const TextB(text: "text")
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
