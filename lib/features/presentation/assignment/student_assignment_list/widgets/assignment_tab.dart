import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_of_future/core/router/route_constents.dart';
import 'package:school_of_future/core/utils/colors.dart';
import 'package:school_of_future/core/utils/text_styles.dart';
import 'package:school_of_future/core/utils/utilities.dart';
import 'package:school_of_future/core/widgets/text.dart';
import 'package:school_of_future/core/widgets/text_field.dart';
import 'package:school_of_future/features/domain/entities/assignment_list_response.dart';
import 'package:school_of_future/features/presentation/assignment/student_assignment_list/widgets/assignment_item.dart';

class AssignmentCustomTab<T> extends StatefulWidget {
  const AssignmentCustomTab({
    super.key,
    required this.loading,
    required this.tabList,
    required this.onTabChanged,
    required this.data,
    required this.search,
  });

  final bool loading;
  final List<String> tabList;
  final Function onTabChanged;
  final Function search;
  final T data;

  @override
  State<AssignmentCustomTab> createState() => _AssignmentCustomTabState();
}

class _AssignmentCustomTabState extends State<AssignmentCustomTab> {
  final PageController pageController = PageController();
  int activePage = 0;
  final searchFocusnode = FocusNode();
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final datalist = widget.data as List<AssignmentItem>;
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: bWhite, borderRadius: BorderRadius.circular(10)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ...List.generate(
                widget.tabList.length,
                (index) => Expanded(
                  child: GestureDetector(
                    onTap: () {
                      pageController.jumpToPage(index);
                      //widget.onTabChanged(index);
                    },
                    child: Container(
                      height: 45,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: activePage == index ? bJungleGreen : bWhite,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextB(
                        text: widget.tabList[index],
                        fontColor: activePage == index ? bWhite : bGray,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const Gap(10),
        TextFieldB(
          focusNode: searchFocusnode,
          controller: searchController,
          hintText: "Search",
          prefixIcon: const Icon(
            Icons.search,
            size: 25,
          ),
          suffixIcon: GestureDetector(
            onTap: () {
              Scaffold.of(context).openEndDrawer();
            },
            child: Container(
              height: 50,
              width: 35,
              padding: const EdgeInsets.only(right: 5),
              alignment: Alignment.centerRight,
              decoration: const BoxDecoration(
                border: Border(
                  left: BorderSide(color: bGray12),
                ),
              ),
              child: const Icon(Icons.filter_alt),
            ),
          ),
          onChanged: (value) {
            widget.search(value);
          },
        ),
        const Gap(10),
        Expanded(
          child: PageView.builder(
            controller: pageController,
            itemCount: widget.tabList.length,
            onPageChanged: (int page) {
              setState(() {
                activePage = page;
              });
              widget.onTabChanged(page);
            },
            itemBuilder: (BuildContext context, int index) {
              return widget.loading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : widget.data.isEmpty
                      ? const Center(
                          child: TextB(
                            text: "Data not found",
                            textStyle: bBody1B,
                            fontColor: bRed,
                          ),
                        )
                      : ListView.builder(
                          itemCount: datalist.length,
                          itemBuilder: (context, position) {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context, rootNavigator: true)
                                        .pushNamed(
                                      studentAssignmentDetailsScreen,
                                      arguments: datalist[position].id,
                                    );
                                  },
                                  child: StudentAssignmentItem(
                                    subjectGroupId: datalist[position]
                                        .subject!
                                        .subjectGroup!
                                        .id!,
                                    subjectName:
                                        datalist[position].subject!.name ?? '',
                                    topicName: datalist[position].title ?? '',
                                    dueDate: getDate(
                                        value: datalist[position].dueAt!,
                                        formate: "dd MMM yyyy"),
                                    totalMark:
                                        "${datalist[position].marks}".tr(),
                                    daysLeft:
                                        "${datalist[position].daysLeft}".tr(),
                                    submissionStatus:
                                        datalist[position].submissionStatus,
                                    draftStatus: datalist[position].status == 0,
                                    submissionRequired:
                                        datalist[position].isSubmitable!,
                                  ),
                                ),
                                const Gap(15),
                              ],
                            );
                          },
                        );
            },
          ),
        ),
      ],
    );
  }
}
