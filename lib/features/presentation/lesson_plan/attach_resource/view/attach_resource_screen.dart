import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:school_of_future/core/translations/local_keys.dart';
import 'package:school_of_future/core/utils/colors.dart';
import 'package:school_of_future/core/widgets/app_bar.dart';
import 'package:school_of_future/core/widgets/body.dart';
import 'package:school_of_future/core/widgets/button.dart';
import 'package:school_of_future/core/widgets/network_image.dart';
import 'package:school_of_future/core/widgets/text.dart';
import 'package:school_of_future/core/widgets/text_field.dart';
import 'package:school_of_future/features/presentation/lesson_plan/attach_resource/bloc/attach_resource_bloc.dart';

class AttecheResourceScreen extends StatelessWidget {
  const AttecheResourceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final searchFocusNode = FocusNode();
    final searchController = TextEditingController();

    return BlocBuilder<AttachResourceBloc, AttachResourceState>(
      builder: (context, state) {
        final bloc = context.read<AttachResourceBloc>();
        return Body(
          isFullScreen: true,
          appBar: FutureAppBar(
            actions: const [SizedBox()],
            title: LocaleKeys.selectResourceType.tr(),
          ),
          child: Container(
            padding: const EdgeInsets.only(top: 10),
            color: bInnerBg,
            child: state.allResource.data != null
                ? Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        child: TextFieldB(
                          focusNode: searchFocusNode,
                          controller: searchController,
                          borderColor: bGray12,
                          hintText: LocaleKeys.search.tr(),
                          prefixIcon: const Icon(
                            Icons.search,
                            size: 25,
                            color: kPrimaryColor,
                          ),
                          onChanged: (String value) {
                            bloc.add(ChangeSearch(search: value));
                          },
                        ),
                      ),
                      Expanded(
                        child: ListView(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          children: [
                            if (state.copyCheckUncheck.isEmpty)
                              ...List.generate(state.allCheckUncheck.length,
                                  (position) {
                                return Container(
                                  margin: const EdgeInsets.only(bottom: 10),
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color: bWhite,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: CheckboxListTile(
                                    contentPadding: EdgeInsets.zero,
                                    visualDensity: VisualDensity.compact,
                                    controlAffinity:
                                        ListTileControlAffinity.leading,
                                    title: Row(
                                      children: [
                                        Container(
                                          width: 45,
                                          height: 45,
                                          clipBehavior: Clip.antiAlias,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(3),
                                          ),
                                          child: NetWorkImageViewB(
                                              imageUrl: state
                                                  .allCheckUncheck[position]
                                                  .thumbImg),
                                        ),
                                        const Gap(10),
                                        Flexible(
                                          child: TextB(
                                            text: state.allResource
                                                .data![position].title!,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ],
                                    ),
                                    value: state
                                        .allCheckUncheck[position].isChecked,
                                    onChanged: (bool? value) {
                                      bloc.add(ToggleCheckbox(
                                          value: value!,
                                          id: state
                                              .allCheckUncheck[position].id));
                                    },
                                  ),
                                );
                              })
                            else
                              ...List.generate(state.copyCheckUncheck.length,
                                  (position) {
                                return Container(
                                  margin: const EdgeInsets.only(bottom: 10),
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color: bWhite,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: CheckboxListTile(
                                    contentPadding: EdgeInsets.zero,
                                    visualDensity: VisualDensity.compact,
                                    controlAffinity:
                                        ListTileControlAffinity.leading,
                                    title: Row(
                                      children: [
                                        Container(
                                          width: 45,
                                          height: 45,
                                          clipBehavior: Clip.antiAlias,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(3),
                                          ),
                                          child: NetWorkImageViewB(
                                              imageUrl: state
                                                  .copyCheckUncheck[position]
                                                  .thumbImg),
                                        ),
                                        const Gap(10),
                                        Flexible(
                                          child: TextB(
                                            text: state.allResource
                                                .data![position].title!,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ],
                                    ),
                                    value: state
                                        .copyCheckUncheck[position].isChecked,
                                    onChanged: (bool? value) {
                                      bloc.add(ToggleCheckbox(
                                          value: value!,
                                          id: state
                                              .copyCheckUncheck[position].id));
                                    },
                                  ),
                                );
                              })
                          ],
                        ),
                      ),
                      const Gap(10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: ButtonB(
                          heigh: 60,
                          text: "Save",
                          press: () {
                            Navigator.pop(context, state.allCheckUncheck);
                          },
                        ),
                      ),
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
