import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:quill_json_to_html/json_to_html.dart';
import 'package:school_of_future/core/translations/local_keys.dart';
import 'package:school_of_future/core/utils/colors.dart';

class AppTextEditor extends StatelessWidget {
  const AppTextEditor(
      {super.key, required this.onChange, required this.qController});
  final Function onChange;
  final QuillController qController;

  @override
  Widget build(BuildContext context) {
    qController.addListener(() {
      List jsonContent = qController.document.toDelta().toJson();
      String htmlContent = QuillJsonToHTML.encodeJson(jsonContent);
      onChange(htmlContent);
    });
    return Column(
      children: [
        QuillSimpleToolbar(
          controller: qController,
          configurations: const QuillSimpleToolbarConfigurations(
            multiRowsDisplay: false,
            toolbarSize: 45,
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: bWhite,
            border: Border.all(color: bGray32),
            borderRadius: BorderRadius.circular(10),
          ),
          height: 200,
          child: Expanded(
            child: QuillEditor.basic(
              controller: qController,
              configurations: const QuillEditorConfigurations(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
