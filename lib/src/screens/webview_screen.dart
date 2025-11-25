import 'dart:io';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import '../services/download_service.dart';

class WebViewScreen extends StatefulWidget {
  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late final WebViewController _controller;
  bool _isLoading = true;
  final String startUrl = 'https://digitalsatbara.mahabhumi.gov.in/';

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(NavigationDelegate(
        onPageStarted: (url) => setState(() => _isLoading = true),
        onPageFinished: (url) => setState(() => _isLoading = false),
        onNavigationRequest: (req) {
          if (req.url.endsWith('.pdf')) {
            _downloadPdf(req.url);
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ))
      ..loadRequest(Uri.parse(startUrl));
  }

  Future<void> _downloadPdf(String url) async {
    final ok = await Permission.storage.request();
    if (!ok.isGranted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Storage permission required')));
      return;
    }
    try {
      final file = await DownloadService.downloadFile(url, prefix: 'shetkari_');
      await Share.shareFiles([file.path], text: 'Downloaded 7/12 / 8A from Shetkari Mitra');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Saved: ${file.path}')));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Download failed')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      WebViewWidget(controller: _controller),
      if (_isLoading) Center(child: CircularProgressIndicator(color: Colors.green.shade700)),
    ]);
  }
}
