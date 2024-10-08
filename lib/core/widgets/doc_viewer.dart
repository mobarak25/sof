import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DocViewer extends StatefulWidget {
  final String url;
  final String downloadUrl;

  const DocViewer({super.key, required this.url, this.downloadUrl = ''});

  @override
  DocViewerState createState() => DocViewerState();
}

class DocViewerState extends State<DocViewer> {
  late WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..loadRequest(
          Uri.parse('https://docs.google.com/viewer?url=${widget.url}'))
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(NavigationDelegate(onPageFinished: (url) async {
        var title = await _controller.getTitle();
        if (title != null && title.isEmpty) {
          _controller.reload();
        }
      }));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        WebViewWidget(
          controller: _controller,
        ),
      ],
    );
  }
}
