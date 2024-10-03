import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:school_of_future/core/translations/local_keys.dart';
import 'package:school_of_future/core/utils/colors.dart';
import 'package:school_of_future/core/utils/text_styles.dart';
import 'package:school_of_future/core/widgets/app_bar.dart';
import 'package:school_of_future/core/widgets/body.dart';
import 'package:school_of_future/core/widgets/text.dart';
import 'package:school_of_future/features/presentation/routine/teacher_routine/bloc/teacher_routine_bloc.dart';
import 'package:school_of_future/features/presentation/routine/teacher_routine/widgets/month_week_day_calander.dart';
import 'package:school_of_future/features/presentation/routine/teacher_routine/widgets/time_line_row.dart';
import 'package:table_calendar/table_calendar.dart';

class RoutineScreen extends StatelessWidget {
  const RoutineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scroll = ScrollController();
    return BlocBuilder<TeacherRoutineBloc, TeacherRoutineState>(
      builder: (context, state) {
        final bloc = context.read<TeacherRoutineBloc>();

        scroll.addListener(() {
          if (scroll.position.pixels == scroll.position.maxScrollExtent) {
            bloc.add(PageIncrement());
          }
        });

        return Body(
          isFullScreen: true,
          appBar: FutureAppBar(
            actions: const [SizedBox()],
            title: LocaleKeys.routine.tr(),
            isLoading: state.loading,
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 13),
            color: bInnerBg,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MonthWeekDayCalendar(
                  onDateChanged: (date) {
                    bloc.add(GetDate(date: date));
                  },
                ),
                const Gap(20),
                if (!state.loading &&
                    state.routine.data != null &&
                    state.routine.data!.isEmpty)
                  Container(
                    padding: const EdgeInsets.all(15),
                    child: TextB(
                      text: LocaleKeys.noResultFound.tr(),
                      textStyle: bBody1B,
                      fontColor: bRed,
                    ),
                  ),
                Expanded(
                  child: !state.loading && state.routine.data != null
                      ? ListView(
                          controller: scroll,
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          children: [
                            ...List.generate(
                              state.routine.data!.length,
                              (index) {
                                return TimeLineRow(
                                  isTeacher: state.isTeacher,
                                  data: state.routine.data![index],
                                );
                              },
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
                                  alignMent: TextAlign.center,
                                ),
                              ),
                          ],
                        )
                      : const Center(
                          child: CircularProgressIndicator(),
                        ),
                ),
                const Gap(70),
              ],
            ),
          ),
        );
      },
    );
  }
}
