import 'package:doctor_appointment/api/ApiUrl.dart';
import 'package:doctor_appointment/authentication/login.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SignupForm extends StatefulWidget {
  @override
  _SignupFormState createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController moblie = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();
  TextEditingController address = TextEditingController();

  //This function call checks the user is already registered or not.

  Future checkuser() async{

    var response = await http.post(Uri.parse(ApiUrl.baseurl+"checkuser.php"),body:{

      "moblie" :moblie.text,
      "action" : "checkuser",
      "tb":"user",

    });
    var ata = json.decode(response.body);
    print(ata);

    if(ata['status']==200){  //This means the user is already registered with this number.
      Fluttertoast.showToast(
          msg: "Account is already registered with this number" ,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 4,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0
      );
      return;
    }
    if(ata['status']==201){  //This means the user is not registered with this number
      return signup();
    }


  }

  Future signup() async{

    var response = await http.post(Uri.parse(ApiUrl.baseurl+"signup.php"),body:{
      "name" : name.text,
      "moblie" :moblie.text,
      "email" :email.text,
      "password" : password.text,
      "address" : address.text,
      "action" : "signup",
      "tb":"user",

    });

    if(response.statusCode==200){

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            return Login();
          },
        ),
      );
      Fluttertoast.showToast(
          msg: "Your account has been created. Login now" ,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 4,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0
      );
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
                  "       Sign  ",
                  style: GoogleFonts.montserrat(
                    color: Colors.black,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,

                  ),
                ),
                Text(
                  "Up",
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
            "Please fill details to proceed",
            style: GoogleFonts.montserrat(
              color: Colors.grey,
              fontSize: 15.0,
            ),
          ),

          SizedBox(height: 30,),
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

              controller: name,
              decoration: InputDecoration(
                border: InputBorder.none,
                icon: Icon(
                  Icons.person,
                  color: Color(0xFF00897b),
                ),
                hintText: 'Name',
              ),
            ),
          ),

          SizedBox(height: 20.0),
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
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                border: InputBorder.none,
                icon: Icon(
                  Icons.phone,
                  color: Color(0xFF00897b),
                ),
                hintText: 'Phone number',
                prefix: Text(
                  '+91',

                ),
              ),
              controller: moblie,
            ),
          ),
          SizedBox(height: 20.0),
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

              controller: address,
              decoration: InputDecoration(
                border: InputBorder.none,
                icon: Icon(
                  Icons.location_history,
                  color: Color(0xFF00897b),
                ),
                hintText: 'Address',

              ),
            ),
          ),
          SizedBox(height: 20.0),
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

              controller: email,
              decoration: InputDecoration(
                border: InputBorder.none,
                icon: Icon(
                  Icons.email,
                  color: Color(0xFF00897b),
                ),
                hintText: 'Email Id',
              ),
            ),
          ),

          SizedBox(height: 20.0),
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
                hintText: 'Password',
              ),
            ),
          ),
          SizedBox(height: 20.0),
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

              controller: confirmpassword,
              obscureText: true,
              decoration: InputDecoration(
                border: InputBorder.none,
                icon: Icon(
                  Icons.lock,
                  color: Color(0xFF00897b),
                ),
                hintText: 'Confirm password',
              ),
            ),
          ),
          SizedBox(height: 30.0),
          InkWell(
            onTap: () async {
              if(password.text != confirmpassword.text){

                Fluttertoast.showToast(
                    msg: "passwords are not matching" ,
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 4,
                    backgroundColor: Colors.blue,
                    textColor: Colors.white,
                    fontSize: 16.0
                );

              }
              else{
                checkuser(); //This function call checks the user is already registered or not.
              }

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
                  'Sign Up',
                  style: GoogleFonts.montserrat(color: Colors.white,fontSize: 20,),
                ),
              ),
            ),
          ),

          SizedBox(height: 10,),
          InkWell(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Already have an account ?  ",
                    style: GoogleFonts.montserrat(color: Colors.black),

                  ),
                  Text(
                    "Login",
                    style: GoogleFonts.montserrat(color: Color(0xFF00897b),fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return Login();
                    },
                  ),
                );
              }
          ),
          SizedBox(height: 20,),

        ],
      ),
    );
  }
}
