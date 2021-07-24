import 'package:doctor_appointment/authentication/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.white,
      statusBarBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white
  ));
  //SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
  runApp(MyApp());
}

List user = [] ;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Replace the 3 second delay with your initialization code:
      future: Future.delayed(Duration(seconds: 3)),
      builder: (context, AsyncSnapshot snapshot) {
        // Show splash screen while waiting for app resources to load:
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              home: Splash());
        } else {
          // Loading is done, return the app:
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Login(),
          );
        }
      },
    );
  }
}

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/Doctro SPLASH.png"),
          ),
        ),
        child: null /* add child content here */,
      ),
    );
  }
}


