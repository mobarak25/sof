import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_of_future/core/router/route_constents.dart';
import 'package:school_of_future/core/translations/local_keys.dart';
import 'package:school_of_future/core/utils/colors.dart';
import 'package:school_of_future/core/widgets/app_bar.dart';
import 'package:school_of_future/core/widgets/body.dart';
import 'package:school_of_future/core/widgets/text.dart';
import 'package:school_of_future/features/presentation/syllabus/syllabus_class_quiz/bloc/syllabus_class_quiz_bloc.dart';
import 'package:school_of_future/features/presentation/syllabus/syllabus_class_quiz/widgets/syllabus_card.dart';

class SyllabusClassQuizScreen extends StatelessWidget {
  const SyllabusClassQuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scroll = ScrollController();
    return BlocBuilder<SyllabusClassQuizBloc, SyllabusClassQuizState>(
      builder: (context, state) {
        final bloc = context.read<SyllabusClassQuizBloc>();
        final data = state.classQuizTest.data;
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
            isLoading: state.loading,
          ),
          child: data != null
              ? Stack(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 13, horizontal: 15),
                      margin: const EdgeInsets.only(top: 15),
                      child: ListView(
                        controller: scroll,
                        children: [
                          ...List.generate(
                            data.length,
                            (index) => SyllabusCard(
                              data: data[index],
                              pressToDel: (String value, int id) {
                                bloc.add(PressToDelete(type: value, id: id));
                              },
                              pressToView: (int id) {
                                Navigator.of(context, rootNavigator: true)
                                    .pushNamed(syllabusDetailsScreen,
                                        arguments: id);
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
                              padding:
                                  const EdgeInsets.only(bottom: 20, top: 10),
                              child: TextB(
                                text: context.tr(LocaleKeys.endOfTheList),
                                fontColor: bRed,
                                alignMent: TextAlign.center,
                              ),
                            )
                        ],
                      ),
                    ),
                  ],
                )
              : const Center(
                  child: CircularProgressIndicator(),
                ),
        );
      },
    );
  }
}
