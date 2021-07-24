import 'package:doctor_appointment/home/main_screen.dart';
import 'package:doctor_appointment/intro.dart';
import 'package:flutter/material.dart';
import 'package:doctor_appointment/api/ApiUrl.dart';
import 'package:doctor_appointment/authentication/sign_up.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:doctor_appointment/main.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  TextEditingController moblie = TextEditingController();
  TextEditingController password = TextEditingController();


  //User login with moblie number and password

  Future login() async{
    print(user);

    var response = await http.post(Uri.parse(ApiUrl.baseurl+"login.php"),body:{
      "moblie" : moblie.text,
      "password" : password.text,
      "tb" : "user",
      "action" : "login"

    });
    //print('addUser Response: ${response.body}');


    var data = json.decode(response.body);
    //print(data);

    if(data['status']==201){

      Fluttertoast.showToast(
          msg: "Invalid email or password" ,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 4,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0
      );

      return;
    }
    if(data['status']==200){
      user = data['data'];
      //print(user);

      if(user[0]['intropage'] == "unseen"){
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) {
              return Introscreen();
            },
          ),
        );
      }else {
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
    }

  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[

          Padding(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 8.0),
            child: Row(
              children: [
                Text(
                  "       Log  ",
                  style: GoogleFonts.montserrat(
                    color: Colors.black,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,

                  ),
                ),
                Text(
                  "In",
                  style: GoogleFonts.montserrat(
                    color: Color(0xFF00897b),
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,

                  ),
                ),
              ],
            ),
          ),
          Text(
            "Please enter your credentials to proceed",
            style: GoogleFonts.montserrat(
              color: Colors.grey,
              fontSize: 15.0,
            ),
          ),

          SizedBox(height: 30,),
          Container(
            //color: Colors.blue,
            width: MediaQuery.of(context).size.width / 1.2,
            height: 45,
            padding: EdgeInsets.only(
                top: 4, left: 16, right: 16, bottom: 4),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(50)),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(color: Colors.black12, blurRadius: 5)
                ]),
            child: TextFormField(


              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                border: InputBorder.none,
                icon: Icon(
                  Icons.phone,
                  color: Color(0xFF00897b),
                ),
                hintText: '   phone number',

                prefix: Text(
                  '+91',

                ),
              ),
              controller: moblie,
            ),
          ),
          SizedBox(height: 30.0),
          Container(
            width: MediaQuery.of(context).size.width / 1.2,
            height: 45,
            padding: EdgeInsets.only(
                top: 4, left: 16, right: 16, bottom: 4),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(50)),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(color: Colors.black12, blurRadius: 5)
                ]),
            child: TextFormField(

              controller: password,
              obscureText: true,
              decoration: InputDecoration(
                border: InputBorder.none,
                icon: Icon(
                  Icons.lock,
                  color: Color(0xFF00897b),
                ),
                hintText: '         password',
              ),
            ),
          ),
          SizedBox(height: 30.0),
          InkWell(
            onTap: () async {
              login();
            },
            child: Container(
              height: 45,
              width: MediaQuery.of(context).size.width / 1.2,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF00897b),
                      Color(0xFF00897b),
                    ],
                  ),
                  borderRadius:
                  BorderRadius.all(Radius.circular(50))),
              child: Center(
                child: Text(
                  'Log In',
                  style: GoogleFonts.montserrat(color: Colors.white,fontSize: 22,),
                ),
              ),
            ),
          ),
          SizedBox(height: 20,),
          InkWell(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Create an account ?  ",
                    style: GoogleFonts.montserrat(color: Colors.black),

                  ),
                  Text(
                    "Signup",
                    style: GoogleFonts.montserrat(color: Color(0xFF00897b),fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignUp();
                    },
                  ),
                );
              }
          ),


        ],
      ),
    );
  }
}
