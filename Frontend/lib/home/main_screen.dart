
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:doctor_appointment/home/doctors_list.dart';
import 'package:doctor_appointment/home/home.dart';
import 'package:doctor_appointment/home/userprofile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {


  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);

    super.initState();
  }

  int pageIndex = 1;

  List<Widget> pageList = <Widget>[

    DoctorsList(),
    Home(),
    Profile(),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pageList[pageIndex],
      bottomNavigationBar: CurvedNavigationBar(

        backgroundColor: Colors.blue,
        animationCurve: Curves.easeOutCubic,
        buttonBackgroundColor: Colors.white,
        //type: BottomNavigationBarType.fixed,
        index: pageIndex,
        onTap: (value) {
          setState(() {

            pageIndex=value;

          });
        },
        items: [

          (Icon(Icons.local_hospital,color: Colors.blueGrey,) ),
          (Icon(Icons.home,color: Colors.blueGrey,) ),
          //(Icon(Icons.person,color: Colors.blueGrey,) ),
          CircleAvatar(
            radius: 16,
            backgroundImage: NetworkImage("https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8dXNlcnxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60") ,
          ),

        ],
      ),
    );

  }
}
