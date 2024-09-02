import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_of_future/core/utils/colors.dart';
import 'package:school_of_future/core/utils/text_styles.dart';
import 'package:school_of_future/core/widgets/button.dart';
import 'package:school_of_future/core/widgets/network_image.dart';
import 'package:school_of_future/core/widgets/text.dart';
import 'package:school_of_future/features/presentation/leave/leave_details/widgets/detail_description.dart';

class LeaveDetailsScreen extends StatelessWidget {
  const LeaveDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Leave Details'),
        leading: ModalRoute.of(context)?.canPop == true
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            : null,
      ),
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(17, 10, 17, 120),
            margin: const EdgeInsets.only(top: 14),
            decoration: BoxDecoration(
                color: bWhite, borderRadius: BorderRadius.circular(5)),
            child: Column(
              children: [
                const TextB(
                  text: "2 Days leave for fever",
                  textStyle: bHead6B,
                ),
                const Gap(8),
                RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: "Leave Type: ",
                        style: TextStyle(color: bGray),
                      ),
                      TextSpan(
                        text: "Sick Leave",
                        style: TextStyle(color: bJungleGreen),
                      ),
                    ],
                  ),
                ),
                const Gap(8),
                RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: "Date: ",
                        style: TextStyle(color: bGray),
                      ),
                      TextSpan(
                        text: "02 Sep, 2024 - 05 Sep, 2024",
                        style: TextStyle(color: bJungleGreen),
                      ),
                    ],
                  ),
                ),
                const Gap(30),
                ButtonB(
                  heigh: 55,
                  text: "Pending",
                  press: () {},
                ),
                const Gap(30),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TextB(
                      text: "Student Details",
                      textStyle: bSub1B,
                    ),
                    const Gap(10),
                    Container(
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        border: Border.all(color: bGray12),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 92,
                            height: 92,
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: const NetworkImageB(
                                imageUrl:
                                    "https://www.gravatar.com/avatar/2c7d99fe281ecd3bcd65ab915bac6dd5?s=250"),
                          ),
                          const Gap(10),
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextB(
                                text: "Abdul Karim Sheikh",
                                textStyle: bSub1M,
                              ),
                              TextB(
                                text: "Class: IX",
                                textStyle: bSub2,
                                fontColor: bGray52,
                              ),
                              TextB(
                                text: "Section: Jamuna",
                                textStyle: bSub2,
                                fontColor: bGray52,
                              ),
                              TextB(
                                text: "ID/Roll: 214589",
                                textStyle: bSub2,
                                fontColor: bGray52,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 49),
                const Row(
                  children: [
                    TextB(
                      text: "Description:",
                      textStyle: bSub1B,
                      alignMent: TextAlign.left,
                    ),
                  ],
                ),
                const Gap(20),
                const DetailDescription(
                  description: "fsdff gdfgsdfg sdfgsdfg dsfgdfhhh",
                  attachments: [
                    "https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf",
                    'sdfsfddf'
                  ],
                  // state.data!.attachments!.map((e) => e.file).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
