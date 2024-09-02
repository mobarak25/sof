import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_of_future/core/utils/colors.dart';
import 'package:school_of_future/core/utils/utilities.dart';
import 'package:school_of_future/core/widgets/text.dart';

class ShowFileName extends StatelessWidget {
  const ShowFileName({
    super.key,
    required this.press,
    required this.selectedFile,
  });

  final Function press;
  final List<File> selectedFile;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...List.generate(
          selectedFile.length,
          (index) => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: TextB(
                  text: getFileName(selectedFile[index].path),
                  maxLines: 1,
                ),
              ),
              GestureDetector(
                onTap: () {
                  press(index);
                },
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.delete,
                    color: kErrorColor,
                  ),
                ),
              ),
            ],
          ),
        ),
        const Gap(10),
      ],
    );
  }
}
