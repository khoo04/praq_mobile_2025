import 'package:flutter/material.dart';

import '../pages/webview_page.dart';

class AppScaffold extends StatelessWidget {
  final Widget body;

  const AppScaffold({super.key, required this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Image.asset('assets/images/wsmb2024_logo.png', height: 55),
        centerTitle: true,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: body,
      bottomNavigationBar: TextButton(
        onPressed: () {
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (context) => WebviewPage()));
        },
        child: Text('Official Page'),
      ),
    );
  }
}
