import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';
import 'package:webview_flutter/webview_flutter.dart';

class Contactus extends StatefulWidget {
  @override
  _ContactusState createState() => _ContactusState();
}

class _ContactusState extends State<Contactus> {
  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Colors.black,
        ),
        title: Text(
          'Contact us',
          style: GoogleFonts.montserrat(color: Colors.black , fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.0,

      ),
      body: WebView(
        initialUrl: 'http://doctrohelp.mnds.tech/',
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
