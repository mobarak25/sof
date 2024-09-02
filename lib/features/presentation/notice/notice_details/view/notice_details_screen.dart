import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_of_future/core/translations/local_keys.dart';
import 'package:school_of_future/core/utils/colors.dart';
import 'package:school_of_future/core/utils/utilities.dart';
import 'package:school_of_future/core/widgets/app_bar.dart';
import 'package:school_of_future/core/widgets/body.dart';
import 'package:school_of_future/features/presentation/notice/notice_details/bloc/notice_details_bloc.dart';
import 'package:school_of_future/features/presentation/notice/notice_details/widgets/detail_description.dart';
import 'package:school_of_future/features/presentation/notice/notice_details/widgets/notice_details_header.dart';

class NoticeDetailsScreen extends StatelessWidget {
  const NoticeDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NoticeDetailsBloc, NoticeDetailsState>(
      builder: (context, state) {
        final bloc = context.read<NoticeDetailsBloc>();
        return Body(
          isFullScreen: true,
          appBar: FutureAppBar(
            title: LocaleKeys.noticeDetails.tr(),
          ),
          child: state.details.data != null
              ? ListView(
                  children: [
                    Container(
                      padding: const EdgeInsets.fromLTRB(17, 28, 17, 8),
                      margin: const EdgeInsets.only(top: 14),
                      decoration: BoxDecoration(
                          color: bWhite,
                          borderRadius: BorderRadius.circular(5)),
                      child: Column(mainAxisSize: MainAxisSize.min, children: [
                        NoticeDetailHeader(
                          day: getDate(
                              value: state.details.data!.createdAt!,
                              formate: "dd"),
                          month: getDate(
                              value: state.details.data!.createdAt!,
                              formate: "hh:mm a"),
                          title: state.details.data!.title!,
                          forUser: state.details.data!.isCommon == 1
                              ? LocaleKeys.all.tr()
                              : "You",
                          date: getDate(
                              value: state.details.data!.createdAt!,
                              formate: "dd  MMM hh:mm a"),
                        ),
                        const SizedBox(height: 49),
                        DetailDescription(
                          description: state.details.data!.description!,
                          attachments: state.attachment,
                          // state.data!.attachments!.map((e) => e.file).toList(),
                        )
                      ]),
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
