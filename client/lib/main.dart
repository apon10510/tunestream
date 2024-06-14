// import 'package:client/core/theme.dart';
// import 'package:client/features/auth/view/pages/login_page.dart';
// import 'package:flutter/material.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: AppTheme.darkThemeMode,
//       home: LoginPage(),
//     );
//   }
// }

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WebViewExample(),
    );
  }
}

class WebViewExample extends StatefulWidget {
  @override
  WebViewExampleState createState() => WebViewExampleState();
}

class WebViewExampleState extends State<WebViewExample> {
  late WebViewController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WebView Download Example'),
        actions: [
          IconButton(
            icon: Icon(Icons.download),
            onPressed: _downloadWebpage,
          ),
        ],
      ),
      body: WebView(
        initialUrl: 'https://flutter.dev/',
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          _controller = webViewController;
        },
      ),
    );
  }

  Future<void> _downloadWebpage() async {
    final String? htmlContent = await _controller
        .runJavascriptReturningResult("document.documentElement.outerHTML;");
    if (htmlContent != null) {
      final directory = await getApplicationDocumentsDirectory();
      final path = '${directory.path}/downloaded_page.html';
      final file = File(path);
      await file.writeAsString(htmlContent);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Webpage downloaded to $path')),
      );
    }
  }
}

class OfflineWebView extends StatelessWidget {
  final String filePath;

  OfflineWebView(this.filePath);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Offline WebPage')),
      body: WebView(
        initialUrl: Uri.dataFromString(
          File(filePath).readAsStringSync(),
          mimeType: 'text/html',
          encoding: Encoding.getByName('utf-8'),
        ).toString(),
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
