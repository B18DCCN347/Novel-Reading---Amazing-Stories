import 'package:flutter/material.dart';
import 'package:love_novel/ui/components/app_menu_bar.dart';
import 'package:love_novel/ui/components/app_scaffold.dart';
import 'package:love_novel/ui/pages/discovery/controller.dart';
import 'package:love_novel/ui/pages/webview/controller.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatelessWidget {
  WebViewPage({
    Key? key,
  }) : super(key: key);
  static const route = '/webview';
  var controller = AppWebViewController.instance;
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Builder(builder: (BuildContext context) {
        return Column(
          children: [
            AppMenuBar(
              title: "Report",
              showBackButton: true,
            ),
            Expanded(
              child: WebView(
                initialUrl: DiscoveryController
                        .configExtension.value?.liveChatSupportUrl ??
                    'https://flutter.dev',
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (WebViewController webViewController) {
                  controller.webviewController.complete(webViewController);
                },
                onProgress: (int progress) {
                  print('WebView is loading (progress : $progress%)');
                },
                // javascriptChannels: <JavascriptChannel>{
                //   _toasterJavascriptChannel(context),
                // },
                navigationDelegate: (NavigationRequest request) {
                  if (request.url.startsWith('https://www.youtube.com/')) {
                    print('blocking navigation to $request}');
                    return NavigationDecision.prevent;
                  }
                  print('allowing navigation to $request');
                  return NavigationDecision.navigate;
                },
                onPageStarted: (String url) {
                  print('Page started loading: $url');
                },
                onPageFinished: (String url) {
                  print('Page finished loading: $url');
                },
                gestureNavigationEnabled: true,
                backgroundColor: const Color(0x00000000),
              ),
            ),
          ],
        );
      }),
    );
  }
}
