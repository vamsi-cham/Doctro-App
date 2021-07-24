import 'package:doctor_appointment/authentication/login.dart';
import 'package:doctor_appointment/home/book_appointment.dart';
import 'package:doctor_appointment/home/mybookings.dart';
import 'package:doctor_appointment/main.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

class UserDashboard extends StatelessWidget {
  Future<void> _showMyDialog(BuildContext context) async {

    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Logout',
            style: GoogleFonts.montserrat(color: Color(0xFF00897b),fontWeight: FontWeight.bold),
          ),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                //Text('This is a demo alert dialog.'),
                Text(
                  'Are you sure to logout ?',
                  style: GoogleFonts.montserrat(color: Colors.black,fontSize: 20),


                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Yes',
                style: GoogleFonts.montserrat(color: Color(0xFF00897b),),


              ),
              onPressed: () async{

                user = []; //user data will become null after logged out
                bookings = [];


                Navigator.of(context).pushAndRemoveUntil(
                  // the new route
                  MaterialPageRoute(
                    builder: (BuildContext context) => Login(),
                  ),

                  // this function should return true when we're done removing routes
                  // but because we want to remove all other screens, we make it
                  // always return false
                      (Route route) => false,
                );
                Fluttertoast.showToast(
                    msg: "You are logged out" ,
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 4,
                    backgroundColor: Colors.blue,
                    textColor: Colors.white,
                    fontSize: 16.0
                );
              },
            ),
            TextButton(
              child: Text(
                'No',
                style: GoogleFonts.montserrat(color: Color(0xFF00897b),),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Container(
            color: Colors.white,
            height: 200,
            child: UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Colors.white,
                image: DecorationImage(
                  image: AssetImage("assets/doc.png"),
                  fit: BoxFit.fitHeight,
                ),
              ),
              accountName: Text(
              user[0]['name'],
              style: GoogleFonts.montserrat(color: Colors.black,fontSize: 18,),
            ),
              accountEmail: Text(
                user[0]['email'],
                style: GoogleFonts.montserrat(color: Colors.black,fontSize: 14,),
              ),
              currentAccountPicture: CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage("https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8dXNlcnxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60") ,
              ), ),
          ),

          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[

                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.home,
                      color: Colors.blueGrey,
                      size: 30.0,
                    ),
                  ),
                  title: Text(
                    "Home",
                    style: GoogleFonts.montserrat(color: Colors.black,fontSize: 16,),

                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
                Divider(),
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.local_hospital,
                      color: Colors.blueGrey,
                      size: 30.0,
                    ),
                  ),
                  title: Text(
                    "Orders",
                    style: GoogleFonts.montserrat(color: Colors.black,fontSize: 16,),

                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Mybookings()),
                    );

                  },
                ),
                Divider(),
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.logout,
                      color: Colors.blueGrey,
                      size: 30.0,
                    ),
                  ),
                  title: Text(
                    "Logout",
                    style: GoogleFonts.montserrat(color: Colors.black,fontSize: 16,),

                  ),
                  onTap: () {

                    _showMyDialog(context);

                  },
                ),
                Divider(),

                /*SizedBox(
                    height: 35,
                    child: Text(
                      '                                        Version- 1.0.0',
                      style: GoogleFonts.montserrat(color: Colors.black,fontSize: 13,),

                    )
                ),*/

              ],
            ),
          ),
        ],
      ),
    );
  }
}
