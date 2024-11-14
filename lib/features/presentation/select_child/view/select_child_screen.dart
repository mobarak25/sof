import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import 'package:school_of_future/core/utils/colors.dart';
import 'package:school_of_future/core/utils/text_styles.dart';
import 'package:school_of_future/core/widgets/app_bar.dart';
import 'package:school_of_future/core/widgets/body.dart';
import 'package:school_of_future/core/widgets/button.dart';
import 'package:school_of_future/core/widgets/network_image.dart';
import 'package:school_of_future/core/widgets/text.dart';
import 'package:school_of_future/features/presentation/select_child/bloc/select_child_bloc.dart';

class SelectChildScreen extends StatelessWidget {
  SelectChildScreen({super.key});

  final currentPasswordFocusNode = FocusNode();
  final newPasswordFocusNode = FocusNode();
  final confirmPasswordFocusNode = FocusNode();

  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectChildBloc, SelectChildState>(
      builder: (context, state) {
        final top = MediaQuery.of(context).padding.top;
        final bloc = context.read<SelectChildBloc>();
        return Body(
          isFullScreen: true,
          appBar: const FutureAppBar(title: "Student list"),
          child: state.childList.data != null
              ? Container(
                  padding: EdgeInsets.fromLTRB(15, top, 15, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Select One Of Your Child".tr(),
                        style: bHead5M,
                      ),
                      const Gap(15),
                      Container(
                        width: 145,
                        height: 5,
                        color: kPrimaryColor,
                      ),
                      const Gap(25),
                      TextB(
                        text:
                            "We noticed you have more than one children in this school. Please select one and click confirm to move forward."
                                .tr(),
                        textStyle: bBase,
                        alignMent: TextAlign.center,
                      ),
                      const Gap(25),
                      ...List.generate(
                        state.childList.data!.length,
                        (index) => InkWell(
                          onTap: () {
                            bloc.add(SelectedId(
                                sId: state.childList.data![index].id!,
                                userId: state.childList.data![index].userId!));
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 7),
                            decoration: BoxDecoration(
                              color: state.childList.data![index].id! ==
                                      state.selectedId
                                  ? const Color(0XFFF0F5F9)
                                  : bWhite,
                              boxShadow: state.childList.data![index].id! ==
                                      state.selectedId
                                  ? [
                                      BoxShadow(
                                        offset: const Offset(0, 4),
                                        blurRadius: 10,
                                        color: bBlack.withOpacity(0.16),
                                      )
                                    ]
                                  : null,
                              border:
                                  Border.all(color: const Color(0XFFE0E0E0)),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 60,
                                  height: 60,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: const Color(0XFFE0E0E0)),
                                  ),
                                  child: const NetworkImageB(imageUrl: ''),
                                ),
                                const Gap(15),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextB(
                                      text: state
                                          .childList.data![index].firstName!,
                                      textStyle: bBase2B,
                                    ),
                                    TextB(
                                      text:
                                          "${state.childList.data![index].classRollNo ?? ''} | ${state.childList.data![index].batchName!}",
                                      textStyle: bBase2,
                                      fontColor: bGray32,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const Gap(50),
                      ButtonB(
                        heigh: 60,
                        text: "Confirm",
                        fontSize: 16,
                        // loading: state.loading,
                        fontWeight: FontWeight.w600,
                        textColor: bWhite,
                        press: () {
                          bloc.add(PressToConfirm());
                        },
                      ),
                    ],
                  ),
                )
              : const Center(
                  child: CircularProgressIndicator(),
                ),
        );
      },
    );
  }
}
