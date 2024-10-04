import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:school_of_future/core/translations/local_keys.dart';
import 'package:school_of_future/core/utils/colors.dart';
import 'package:school_of_future/core/utils/text_styles.dart';
import 'package:school_of_future/core/utils/utilities.dart';
import 'package:school_of_future/core/widgets/app_bar.dart';
import 'package:school_of_future/core/widgets/body.dart';
import 'package:school_of_future/core/widgets/text.dart';
import 'package:school_of_future/features/presentation/syllabus/syllabus_class_quiz/bloc/syllabus_class_quiz_bloc.dart';
import 'package:school_of_future/features/presentation/syllabus/syllabus_class_quiz/widgets/syllabus_card.dart';

class SyllabusClassQuizScreen extends StatelessWidget {
  const SyllabusClassQuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SyllabusClassQuizBloc, SyllabusClassQuizState>(
      builder: (context, state) {
        final bloc = context.read<SyllabusClassQuizBloc>();
        final data = state.classQuizTest.data;
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
                        children: [
                          ...List.generate(
                            data.length,
                            (index) => SyllabusCard(
                              data: data[index],
                              pressToDel: (String value, int id) {
                                bloc.add(PressToDelete(type: value, id: id));
                              },
                            ),
                          ),
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
