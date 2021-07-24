import 'package:doctor_appointment/api/ApiUrl.dart';
import 'package:doctor_appointment/home/main_screen.dart';
import 'package:doctor_appointment/main.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:http/http.dart' as http;

class Introscreen extends StatefulWidget {
  @override
  _IntroscreenState createState() => _IntroscreenState();
}

class _IntroscreenState extends State<Introscreen> {
  final introKey = GlobalKey<IntroductionScreenState>();

  Future updateintroseen() async{


    var response = await http.post(Uri.parse(ApiUrl.baseurl+"updateintroscreen.php"),body:{
      "user_id" : user[0]['id'] ,
      "intropage" : "seen",
      "tb" : "user",
      "action" : "updateintroscreen"
    });

    if(response.statusCode == 200){
      print("success");
      return _onIntroEnd(context);
    }
  }


  void _onIntroEnd(context) {
   // updateintroseen();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) {
          return MainScreen();
        },
      ),
    );
    Fluttertoast.showToast(
        msg: "You are logged in successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 4,
        backgroundColor: Colors.blue,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }

  Widget _buildImage(String assetName, [double width = 300]) {
    return Image.asset('assets/$assetName', width: width);
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);

    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return SafeArea(
      child: IntroductionScreen(
        key: introKey,
        globalBackgroundColor: Colors.white,
        globalHeader: Align(
          alignment: Alignment.topRight,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 16, right: 16),
              child: _buildImage('doc.png', 100),
            ),
          ),
        ),
        pages: [
          PageViewModel(
            title: "Need a Doctor?",
            body:
            "Search doctors using our doctro app and find the best doctors around you.",
            image: _buildImage('docapp1.jpg'),
            decoration: pageDecoration,
          ),
          PageViewModel(
            title: "Book your appointment",
            body:
            "Schedule your doctor appointment and make bookings easy.",
            image: _buildImage('Book Appointment.jpg'),
            decoration: pageDecoration,
          ),
          PageViewModel(
            title: "Pay Online",
            body:
            "Now you can pay your doctor appointment fees during booking or later before the appointment.",
            image: _buildImage('Pay Online.png'),
            decoration: pageDecoration,
          ),
        ],
        onDone: () => updateintroseen(),
        //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
        showSkipButton: true,
        skipFlex: 0,
        nextFlex: 0,
        //rtl: true, // Display as right-to-left
        skip: const Text('Skip'),
        next: const Icon(Icons.arrow_forward),
        done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
        curve: Curves.fastLinearToSlowEaseIn,
        controlsMargin: const EdgeInsets.all(16),
        controlsPadding: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
        dotsDecorator: const DotsDecorator(
          size: Size(10.0, 10.0),
          color: Color(0xFFBDBDBD),
          activeSize: Size(22.0, 10.0),
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
          ),
        ),
        dotsContainerDecorator: const ShapeDecoration(
          color: Colors.black87,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
        ),
      ),
    );
  }
}
