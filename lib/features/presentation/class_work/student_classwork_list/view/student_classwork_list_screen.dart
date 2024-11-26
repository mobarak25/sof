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
import 'package:school_of_future/core/widgets/date_picker.dart';
import 'package:school_of_future/core/widgets/text.dart';
import 'package:school_of_future/core/widgets/custom_tab.dart';
import 'package:school_of_future/core/widgets/text_field.dart';
import 'package:school_of_future/features/presentation/class_work/student_classwork_list/bloc/student_classwork_list_bloc.dart';
import 'package:school_of_future/features/presentation/class_work/student_classwork_list/widgets/classwork_card.dart';

class StudentClassworkListScreen extends StatelessWidget {
  const StudentClassworkListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final publishedController = TextEditingController();
    final publishedFocusNode = FocusNode();

    final scroll = ScrollController();

    return BlocBuilder<StudentClassworkListBloc, StudentClassworkListState>(
      builder: (context, state) {
        final bloc = context.read<StudentClassworkListBloc>();

        scroll.addListener(() {
          if (scroll.position.pixels == scroll.position.maxScrollExtent) {
            bloc.add(PageIncrement());
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
              child: Column(
                children: [
                  const Gap(30),
                  TextFieldB(
                    fieldTitle: context.tr(LocaleKeys.startDate),
                    hintText: context.tr(LocaleKeys.selectStartDate),
                    focusNode: publishedFocusNode,
                    controller: publishedController,
                    borderColor: bGray12,
                    suffixIcon: const Icon(
                      Icons.calendar_month,
                      size: 30,
                      color: bGray32,
                    ),
                    isReadOnly: true,
                    onChanged: () {},
                    onTouch: () {
                      datePicker(
                        context,
                        date: (DateTime date) {
                          bloc.add(
                            SelectStartDate(
                              startDate: date,
                              startController: publishedController,
                            ),
                          );
                        },
                      );
                    },
                    // errorText:
                    //     state.forms == Forms.invalid && state.dateFrom.isEmpty
                    //         ? 'Select date from'
                    //         : '',
                  ),
                  const Gap(30),
                ],
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
                    bloc.add(DataForTab(tabIndex: tabIndex.toString()));
                  },
                  search: (String value) {
                    bloc.add(ChangeSearch(searchText: value));
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
            ],
          ),
        );
      },
    );
  }
}
