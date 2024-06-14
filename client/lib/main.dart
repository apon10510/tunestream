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
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home:  WebViewExample(),
    );
  }
}

class WebViewExample extends StatefulWidget {
  const WebViewExample({super.key});

  @override
  WebViewExampleState createState() => WebViewExampleState();
}

class WebViewExampleState extends State<WebViewExample> {
  late WebViewController _controller;
  String _filePath = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WebView Download Example'),
        actions: [
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: _downloadWebpage,
          ),
          IconButton(
            icon: const Icon(Icons.offline_bolt),
            onPressed: _filePath.isNotEmpty ? _openOfflinePage : null,
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
    final String? htmlContent = await _controller.runJavascriptReturningResult("document.documentElement.outerHTML;");
    if (htmlContent != null) {
      final directory = await getApplicationDocumentsDirectory();
      final path = '${directory.path}/downloaded_page.html';
      final file = File(path);
      await file.writeAsString(htmlContent);

      setState(() {
        _filePath = path;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Webpage downloaded to $path')),
      );
    }
  }

  void _openOfflinePage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => OfflineWebView(_filePath),
      ),
    );
  }
}

class OfflineWebView extends StatelessWidget {
  final String filePath;

  const OfflineWebView(this.filePath, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Offline WebPage')),
      body: FutureBuilder<String>(
        future: File(filePath).readAsString(),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              return WebView(
                initialUrl: Uri.dataFromString(
                  snapshot.data!,
                  mimeType: 'text/html',
                  encoding: Encoding.getByName('utf-8'),
                ).toString(),
                javascriptMode: JavascriptMode.unrestricted,
              );
            }
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
