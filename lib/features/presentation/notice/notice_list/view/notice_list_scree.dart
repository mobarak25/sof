import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:school_of_future/core/navigator/navigator_key.dart';
import 'package:school_of_future/core/router/route_constents.dart';
import 'package:school_of_future/core/translations/local_keys.dart';
import 'package:school_of_future/core/utils/colors.dart';
import 'package:school_of_future/core/utils/text_styles.dart';
import 'package:school_of_future/core/utils/utilities.dart';
import 'package:school_of_future/core/widgets/app_bar.dart';
import 'package:school_of_future/core/widgets/body.dart';
import 'package:school_of_future/core/widgets/text.dart';
import 'package:school_of_future/core/widgets/text_field.dart';
import 'package:school_of_future/features/presentation/notice/notice_list/bloc/notice_list_bloc.dart';
import 'package:school_of_future/features/presentation/notice/notice_list/widgets/notice_item.dart';

class NoticeList extends StatelessWidget {
  const NoticeList({super.key});

  @override
  Widget build(BuildContext context) {
    final searchFocusnode = FocusNode();
    final searchController = TextEditingController();
    final scroll = ScrollController();

    return BlocBuilder<NoticeListBloc, NoticeListState>(
      builder: (context, state) {
        final bloc = context.read<NoticeListBloc>();
        scroll.addListener(() {
          if (scroll.position.pixels == scroll.position.maxScrollExtent) {
            bloc.add(PageIncrement());
          }
        });

        return Body(
          isFullScreen: true,
          appBar: FutureAppBar(
            title: LocaleKeys.notice.tr(),
            isLoading: state.loading,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: state.notice.noticeList != null
                ? Column(
                    children: [
                      const Gap(10),
                      TextFieldB(
                        paddingHeight: 20,
                        hintText: LocaleKeys.search.tr(),
                        borderColor: bGray12,
                        focusNode: searchFocusnode,
                        controller: searchController,
                        prefixIcon: const Icon(
                          Icons.search,
                          size: 25,
                          color: bPrimaryColor,
                        ),
                        onChanged: (value) {
                          bloc.add(ChangeSearch(searchValue: value));
                        },
                      ),
                      const Gap(20),
                      Expanded(
                        child: ListView.builder(
                          controller: scroll,
                          itemCount: state.notice.noticeList!.length,
                          itemBuilder: (context, position) {
                            return Column(
                              children: [
                                ItemNotice(
                                  secondLineLabel: LocaleKeys.forNotice.tr(),
                                  thirdLineLabel: LocaleKeys.by.tr(),
                                  day: getDate(
                                      value: state.notice.noticeList![position]
                                          .createdAt!,
                                      formate: 'dd'),
                                  month: getDate(
                                      value: state.notice.noticeList![position]
                                          .createdAt!,
                                      formate: 'MM'),
                                  title:
                                      state.notice.noticeList![position].title!,
                                  secondLineValue: state.notice
                                              .noticeList![position].isCommon ==
                                          1
                                      ? LocaleKeys.all.tr()
                                      : 'You',
                                  thirdLineValue: state
                                      .notice.noticeList![position].authorName!,
                                  time: getDate(
                                      value: state.notice.noticeList![position]
                                          .createdAt!,
                                      formate: 'dd MMM hh:mm a'),
                                  press: () {
                                    Navigator.pushNamed(
                                      navigatorKey.currentState!.context,
                                      noticeDetailsScreen,
                                      arguments:
                                          state.notice.noticeList![position].id,
                                    );
                                  },
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                      if (state.incrementLoader)
                        const Padding(
                          padding: EdgeInsets.only(top: 20, bottom: 30),
                          child: CircularProgressIndicator(
                            color: kPrimaryColor,
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
                      const Gap(75)
                    ],
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  ),
          ),
        );
      },
    );
  }
}
