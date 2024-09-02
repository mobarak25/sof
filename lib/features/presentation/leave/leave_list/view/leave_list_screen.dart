import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_of_future/core/navigator/navigator_key.dart';
import 'package:school_of_future/core/router/route_constents.dart';
import 'package:school_of_future/core/utils/colors.dart';
import 'package:school_of_future/core/widgets/text.dart';
import 'package:school_of_future/core/widgets/text_field.dart';
import 'package:school_of_future/features/presentation/leave/leave_list/widgets/leave_item.dart';

class LeaveListScreen extends StatelessWidget {
  const LeaveListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Leave'),
        leading: ModalRoute.of(context)?.canPop == true
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            : null,
      ),
      endDrawer: const Drawer(),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 13),
            color: bInnerBg,
            child: const CustomTab(
              tabList: [
                "Pending",
                "Accepted",
                "Rejected",
              ],
            ),
          ),
          Positioned(
            bottom: 100,
            right: 15,
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                    navigatorKey.currentState!.context, parentApplyLeaveScreen);
              },
              child: Container(
                width: 56,
                height: 56,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: bJungleGreen,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.add,
                  size: 30,
                  color: bWhite,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomTab extends StatefulWidget {
  const CustomTab({super.key, required this.tabList});
  final List<String> tabList;

  @override
  State<CustomTab> createState() => _CustomTabState();
}

class _CustomTabState extends State<CustomTab> {
  final PageController pageController = PageController();
  int activePage = 0;
  final searchFocusnode = FocusNode();

  @override
  Widget build(BuildContext context) {
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
          onChanged: (value) {},
        ),
        Expanded(
          child: PageView.builder(
              controller: pageController,
              itemCount: widget.tabList.length,
              onPageChanged: (int page) {
                setState(() {
                  activePage = page;
                });
              },
              itemBuilder: (BuildContext context, int index) {
                return ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, position) {
                    return LeaveItem(
                      day: '10',
                      month: 'Augest',
                      title: 'This is title $index',
                      secondLineValue: 'Sick Leave',
                      thirdLineValue: '02/09/2024 - 02/09/2024',
                      time: '10:10am',
                      press: () {
                        Navigator.pushNamed(navigatorKey.currentState!.context,
                            leaveDetailsScreen);
                      },
                    );
                  },
                );
              }),
        ),
      ],
    );
  }
}
