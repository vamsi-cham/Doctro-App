
import 'package:doctor_appointment/authentication/signup_form.dart';
import 'package:flutter/material.dart';



class SignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children:<Widget> [

          Expanded(

            child: ListView(
             // padding: EdgeInsets.all(20.0),
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 3,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.white, Colors.blue[50]],
                      ),
                      borderRadius:
                      BorderRadius.only(bottomRight: Radius.circular(300) )),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[

                      Image.asset("assets/doc.png",height: 200,),


                    ],
                  ),
                ),
                SignupForm(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

