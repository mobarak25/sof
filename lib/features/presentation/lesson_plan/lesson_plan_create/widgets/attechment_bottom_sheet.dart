import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_of_future/core/translations/local_keys.dart';
import 'package:school_of_future/core/utils/colors.dart';
import 'package:school_of_future/core/utils/text_styles.dart';
import 'package:school_of_future/core/widgets/text.dart';

Future<dynamic> openAttechmentSheet(BuildContext context,
    {required Function press}) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) => Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: StatefulBuilder(
        builder: (ctx, myState) {
          return SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
              color: bWhite,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      press("addResource");
                    },
                    child: Row(
                      children: [
                        const Icon(
                          Icons.add,
                          size: 30,
                        ),
                        const Gap(10),
                        TextB(
                          text: LocaleKeys.addResource.tr(),
                          textStyle: bBody1B,
                          fontColor: bGray100,
                        ),
                      ],
                    ),
                  ),
                  const Gap(10),
                  TextButton(
                    onPressed: () {
                      press("uploadFile");

                      Navigator.pop(context);
                    },
                    child: Row(
                      children: [
                        const Icon(
                          Icons.cloud_upload_outlined,
                          size: 30,
                        ),
                        const Gap(10),
                        TextB(
                          text: LocaleKeys.uploadFile.tr(),
                          textStyle: bBody1B,
                          fontColor: bGray100,
                        ),
                      ],
                    ),
                  ),
                  const Gap(15),
                ],
              ),
            ),
          );
        },
      ),
    ),
  );
}
