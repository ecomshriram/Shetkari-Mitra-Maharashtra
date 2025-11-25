import 'package:flutter/material.dart';
import 'webview_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          _buildHeader(context),
          Expanded(child: WebViewScreen()),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: Colors.green.shade800,
      child: Row(
        children: [
          Image.asset('assets/images/logo.png', width: 42, height: 42),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              'Shetkari Mitra',
              style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
            ),
          ),
          IconButton(
            icon: Icon(Icons.info_outline, color: Colors.white),
            onPressed: () {
              showAboutDialog(
                context: context,
                applicationName: 'Shetkari Mitra',
                applicationVersion: '1.0',
                children: [Text('Official Mahabhumi WebView for 7/12 & 8A')],
              );
            },
          ),
        ],
      ),
    );
  }
}
