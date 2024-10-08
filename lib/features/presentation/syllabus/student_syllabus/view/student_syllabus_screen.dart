import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_of_future/core/router/route_constents.dart';
import 'package:school_of_future/core/translations/local_keys.dart';
import 'package:school_of_future/core/utils/colors.dart';
import 'package:school_of_future/core/widgets/app_bar.dart';
import 'package:school_of_future/core/widgets/body.dart';
import 'package:school_of_future/core/widgets/custom_tab.dart';
import 'package:school_of_future/core/widgets/doc_viewer.dart';
import 'package:school_of_future/core/widgets/text.dart';
import 'package:school_of_future/features/presentation/syllabus/student_syllabus/bloc/student_syllabus_bloc.dart';
import 'package:school_of_future/features/presentation/syllabus/student_syllabus/widgets/student_syllabus_card.dart';

class StudentSyllabusScreen extends StatelessWidget {
  const StudentSyllabusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scroll = ScrollController();
    final size = MediaQuery.of(context).size;

    return BlocBuilder<StudentSyllabusBloc, StudentSyllabusState>(
      builder: (context, state) {
        final bloc = context.read<StudentSyllabusBloc>();

        scroll.addListener(() {
          if (scroll.position.pixels == scroll.position.maxScrollExtent) {
            bloc.add(PageIncrement());
          }
        });

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
              child: state.activeTab == "0"
                  ? Column(
                      children: [
                        if (state.studentFullSyllabus.data != null)
                          Column(
                            children: List.generate(
                              state.studentFullSyllabus.data!.length,
                              (index) => SizedBox(
                                height: size.height,
                                width: size.width,
                                child: DocViewer(
                                  url: state
                                      .studentFullSyllabus.data![index].url!,
                                ),
                              ),
                            ),
                          ),
                      ],
                    )
                  : Column(
                      children: [
                        if (state.classQuizText.data != null)
                          Expanded(
                            child: ListView.builder(
                              controller: scroll,
                              itemCount: state.classQuizText.data!.length,
                              itemBuilder: (context, index) {
                                final data = state.classQuizText.data![index];
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.of(context, rootNavigator: true)
                                        .pushNamed(
                                      syllabusDetailsScreen,
                                      arguments: data.id,
                                    );
                                  },
                                  child: StudentSyllabusCard(
                                    data: data,
                                  ),
                                );
                              },
                            ),
                          ),
                        if (state.incrementLoader)
                          const Padding(
                            padding: EdgeInsets.all(20),
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                        if (!state.incrementLoader && state.isEndList)
                          Container(
                            padding: const EdgeInsets.only(bottom: 20, top: 10),
                            child: const TextB(
                              text: "End of the list",
                              fontColor: bRed,
                              alignMent: TextAlign.center,
                            ),
                          )
                      ],
                    ),
            ),
          ),
        );
      },
    );
  }
}
