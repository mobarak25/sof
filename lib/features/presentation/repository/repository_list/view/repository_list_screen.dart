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
import 'package:school_of_future/core/widgets/text.dart';
import 'package:school_of_future/core/widgets/text_field.dart';
import 'package:school_of_future/features/presentation/repository/repository_list/bloc/repository_list_bloc.dart';
import 'package:school_of_future/features/presentation/repository/repository_list/widgets/repository_card.dart';

class RepositoryListScreen extends StatelessWidget {
  const RepositoryListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scroll = ScrollController();
    final searchFocusnode = FocusNode();
    final searchController = TextEditingController();

    return BlocBuilder<RepositoryListBloc, RepositoryListState>(
      builder: (context, state) {
        final bloc = context.read<RepositoryListBloc>();

        scroll.addListener(() {
          if (scroll.position.pixels == scroll.position.maxScrollExtent) {
            bloc.add(PageIncrement());
          }
        });
        return Body(
          isFullScreen: true,
          appBar: FutureAppBar(
            actions: const [SizedBox()],
            title: LocaleKeys.repository.tr(),
            isLoading: state.loading,
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 15),
            color: bInnerBg,
            child: state.repositories.data != null
                ? Column(
                    children: [
                      const Gap(10),
                      TextFieldB(
                        focusNode: searchFocusnode,
                        controller: searchController,
                        hintText: "Search",
                        prefixIcon: const Icon(
                          Icons.search,
                          size: 25,
                        ),
                        onChanged: (value) {
                          bloc.add(ChangeSearch(searchText: value));
                        },
                      ),
                      const Gap(10),
                      Expanded(
                        child: ListView(
                          controller: scroll,
                          children: [
                            ...List.generate(
                              state.repositories.data!.length,
                              (index) {
                                final item = state.repositories.data![index];
                                return Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.of(context,
                                                rootNavigator: true)
                                            .pushNamed(
                                          repositoryDtlsScreen,
                                          arguments: item.id,
                                        );
                                      },
                                      child: RepositoryCard(item: item),
                                    ),
                                    const Gap(10),
                                  ],
                                );
                              },
                            ),
                            if (state.repositories.data!.isEmpty)
                              TextB(
                                text: LocaleKeys.noResultFound.tr(),
                                textStyle: bBody1B,
                                fontColor: bRed,
                                alignMent: TextAlign.center,
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
                : const Center(
                    child: CircularProgressIndicator(),
                  ),
          ),
        );
      },
    );
  }
}
