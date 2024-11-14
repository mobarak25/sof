import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_of_future/core/utils/colors.dart';
import 'package:school_of_future/core/widgets/text.dart';
import 'package:school_of_future/core/widgets/text_field.dart';

class CustomTab extends StatefulWidget {
  const CustomTab({
    super.key,
    required this.loading,
    required this.tabList,
    required this.onTabChanged,
    required this.search,
    required this.child,
    this.showSearch = true,
  });

  final bool loading;
  final List<String> tabList;
  final Function onTabChanged;
  final Function search;
  final Widget child;
  final bool showSearch;

  @override
  State<CustomTab> createState() => _CustomTabState();
}

class _CustomTabState extends State<CustomTab> {
  final PageController pageController = PageController();
  int activePage = 0;
  final searchFocusnode = FocusNode();
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (widget.tabList.isNotEmpty)
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
        if (widget.showSearch)
          Column(
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
            ],
          ),
        // const Gap(5),
        // Row(
        //   children: [
        //     Container(
        //       padding: const EdgeInsets.fromLTRB(10, 0, 5, 3),
        //       margin: const EdgeInsets.only(right: 10),
        //       decoration: const BoxDecoration(
        //         color: bWhite,
        //       ),
        //       child: const Row(
        //         children: [
        //           TextB(
        //             text: "text",
        //             fontColor: bGray52,
        //           ),
        //           Gap(5),
        //           Icon(
        //             Icons.close,
        //             color: bGray32,
        //           ),
        //         ],
        //       ),
        //     ),
        //   ],
        // ),

        const Gap(10),
        if (widget.tabList.isNotEmpty)
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
                    ? const Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(20),
                            child: CircularProgressIndicator(),
                          ),
                        ],
                      )
                    : widget.child;
              },
            ),
          )
        else
          Expanded(
            child: widget.loading
                ? const Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(20),
                        child: CircularProgressIndicator(),
                      ),
                    ],
                  )
                : widget.child,
          )
      ],
    );
  }
}
