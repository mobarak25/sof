import 'package:flutter/material.dart';
import 'package:school_of_future/core/widgets/app_bar.dart';
import 'package:school_of_future/core/widgets/doc_viewer.dart';

class DocViewerScreen extends StatelessWidget {
  final String url;
  const DocViewerScreen({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const FutureAppBar(
        title: 'Document Viewer',
      ),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: DocViewer(url: url),
      ),
    );
  }
}
