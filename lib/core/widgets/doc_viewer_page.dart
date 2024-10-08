import 'package:flutter/material.dart';
import 'package:school_of_future/core/utils/utilities.dart';
import 'package:school_of_future/core/widgets/app_bar.dart';
import 'package:school_of_future/core/widgets/body.dart';
import 'package:school_of_future/core/widgets/doc_viewer.dart';

class DocViewerScreen extends StatelessWidget {
  final String url;
  const DocViewerScreen({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Body(
      appBar: const FutureAppBar(
        actions: [SizedBox()],
        title: "View Document",
      ),
      child: SizedBox(
        height: size.height,
        width: size.width,
        child: DocViewer(url: generateValidUrl(url)),
      ),
    );
  }
}
