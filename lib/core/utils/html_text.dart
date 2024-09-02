import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:html2md/html2md.dart' as html2md;
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:url_launcher/url_launcher.dart';

class HtmlText extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final EdgeInsets padding;

  const HtmlText(this.text,
      {super.key,
      this.backgroundColor = Colors.white,
      this.padding = const EdgeInsets.symmetric(horizontal: 14, vertical: 18)});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          color: backgroundColor,
          padding: padding,
          child: MarkdownBody(
            data: getHtmlText(text),
          ),
        )
      ],
    );
  }

  String getHtmlText(String html) {
    var text = """<!DOCTYPE html>
    <html>
      <head><meta name="viewport" content="width=device-width, initial-scale=1.0"></head>
        <div>
         $html
        </div>
      </body>
    </html>""";
    return html2md.convert(text);
  }
}

class CustomHtmlText extends StatelessWidget {
  final String htmlText;
  const CustomHtmlText({super.key, required this.htmlText});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Html(
        data: htmlText,
        style: {
          "table": Style(
            backgroundColor: const Color.fromARGB(0x50, 0xee, 0xee, 0xee),
          ),
          "tr": Style(
            border: const Border(bottom: BorderSide(color: Colors.grey)),
          ),
          "th": Style(
            padding: HtmlPaddings.all(6),
            backgroundColor: Colors.grey,
          ),
          "td": Style(
            padding: HtmlPaddings.all(6),
            alignment: Alignment.topLeft,
          ),
          'h5': Style(maxLines: 2, textOverflow: TextOverflow.ellipsis),
        },
        /*onlyRenderTheseTags: {
          "table": (context, child) {
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child:
              (context.tree as TableLayoutElement).toWidget(context),
            );
          },
          "bird": (RenderContext context, Widget child) {
            return TextSpan(text: "🐦");
          },
          "flutter": (RenderContext context, Widget child) {
            return FlutterLogo(
              style: (context.tree.element!.attributes['horizontal'] != null)
                  ? FlutterLogoStyle.horizontal
                  : FlutterLogoStyle.markOnly,
              textColor: context.style.color!,
              size: context.style.fontSize!.size! * 5,
            );
          },
        },
        customImageRenders: {
          networkSourceMatcher(domains: ["flutter.dev"]):
              (context, attributes, element) {
            return FlutterLogo(size: 36);
          },
          networkSourceMatcher(domains: ["mydomain.com"]):
          networkImageRender(
            headers: {"Custom-Header": "some-value"},
            altWidget: (alt) => Text(alt ?? ""),
            loadingWidget: () => Text("Loading..."),
          ),
          // On relative paths starting with /wiki, prefix with a base url
              (attr, _) =>
          attr["src"] != null && attr["src"]!.startsWith("/wiki"):
          networkImageRender(
              mapUrl: (url) => "https://upload.wikimedia.org" + url!),
          // Custom placeholder image for broken links
          networkSourceMatcher():
          networkImageRender(altWidget: (_) => FlutterLogo()),
        },*/
        onLinkTap: (url, __, ___) {
          print("Opening $url...");
        },
        /*onImageTap: (src, _, __, ___) {
          print(src);
        },
        onImageError: (exception, stackTrace) {
          print(exception);
        },*/
        onCssParseError: (css, messages) {
          print("css that errored: $css");
          print("error messages:");
          messages.forEach((element) {
            print(element);
          });
          return null;
        },
      ),
    );
  }
  /*String getHtmlText(String html) {
    var text = """<!DOCTYPE html>
    <html>
      <head><meta name="viewport" content="width=device-width, initial-scale=1.0"></head>
        <div>
         $html
        </div>
      </body>
    </html>""";
    return html2md.convert(text);
  }*/
}

class CustomHtmlThird extends StatelessWidget {
  const CustomHtmlThird({super.key, required this.htmlText});

  final String htmlText;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(12),
        child: HtmlWidget(
          htmlText,
          onTapUrl: (url) {
            _launchURL(url: url);
            return true;
          },
        ));
  }

  _launchURL({required String url}) async =>
      await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
}
