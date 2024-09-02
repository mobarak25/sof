import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:quill_json_to_html/json_to_html.dart';
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
        QuillToolbar.simple(
          configurations: QuillSimpleToolbarConfigurations(
            // sharedConfigurations: const QuillSharedConfigurations(
            //   locale: Locale('de'),
            // ),
            controller: qController,
            multiRowsDisplay: false,
            toolbarSize: 60,
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
              configurations: QuillEditorConfigurations(
                controller: qController,
                padding: const EdgeInsets.all(10),
                readOnly: false,

                // sharedConfigurations: const QuillSharedConfigurations(
                //   locale: Locale('de'),
                // ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
