import 'package:doctor_appointment/api/ApiUrl.dart';
import 'package:doctor_appointment/home/home.dart';
import 'package:doctor_appointment/main.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  var phone = user[0]['moblie'];

  final name = TextEditingController(text: user[0]['name']);
  final moblie = TextEditingController(text: user[0]['moblie']);
  final email = TextEditingController(text: user[0]['email']);
  final address = TextEditingController(text: user[0]['address']);
  final password = TextEditingController(text: user[0]['password']);

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
          msg: "Account is already registered with this moblie number" ,
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
      return updateuserdata();
    }


  }

  Future updateuserdata() async {
    //var url = "http://192.168.0.106:80/smartschool_restapi/updatepass.php?user_id=${Teacherid}&password=${newpass.text}&action=updatepassword&tb=teacher";
    var response = await http.post(Uri.parse(ApiUrl.baseurl+"updateuserdata.php"),body:{
      "user_id" : user[0]['id'] ,
      "name" : name.text,
      "moblie" : moblie.text,
      "email" : email.text,
      "address" : address.text,
      "password" : password.text,
      "tb" : "user",
      "action" : "updateUserData"


    });

   if(response.statusCode==200) {
     user[0]['name']=name.text;
     user[0]['moblie']=moblie.text;
     user[0]['email']=email.text;
     user[0]['password']=password.text;
     user[0]['address']=address.text;
     //user.replaceRange(0, 0, {name.text,moblie.text,email.text,password.text,address.text});
     //user.add({name.text,moblie.text,email.text,password.text,address.text} );
     Fluttertoast.showToast(
         msg: "updated successfully" ,
         toastLength: Toast.LENGTH_SHORT,
         gravity: ToastGravity.BOTTOM,
         timeInSecForIosWeb: 4,
         backgroundColor: Colors.blue,
         textColor: Colors.white,
         fontSize: 16.0
     );
    // print(user);

     Navigator.pushReplacement(
       context,
       MaterialPageRoute(
         builder: (context) {
           return Home();
         },
       ),
     );

   }


  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Profile',
          style: GoogleFonts.montserrat(color: Colors.black , fontWeight: FontWeight.bold),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0.0,

      ),

      body: ListView(
        children: <Widget>[

          Container(
            height: 64,
           // margin: EdgeInsets.only(bottom: 20),
            child: Center(
              child: CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage("https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8dXNlcnxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60") ,
              ),
            ),
          ),

          Container(
            height: MediaQuery.of(context).size.height /1.5,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(top: 62),
            child: Column(
              children: <Widget>[
                //Spacer(),
                Container(
                  width: MediaQuery.of(context).size.width / 1.2,
                  height: 50,
                  padding:
                  EdgeInsets.only(top: 4, left: 16, right: 16, bottom: 4),
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

                      hintText: 'Name',
                      icon: Icon(
                        Icons.person,
                        color: Colors.blueGrey,
                      ),
                    ),


                  ),
                ),

                SizedBox(   //Use of SizedBox
                  height: 30,
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 1.2,
                  height: 50,
                  padding:
                  EdgeInsets.only(top: 4, left: 16, right: 16, bottom: 4),
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

                      hintText: 'Password',
                      icon: Icon(
                        Icons.lock,
                        color: Colors.blueGrey,
                      ),
                    ),


                  ),
                ),
                SizedBox(   //Use of SizedBox
                  height: 30,
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 1.2,
                  height: 50,
                  padding:
                  EdgeInsets.only(top: 4, left: 16, right: 16, bottom: 4),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(color: Colors.black12, blurRadius: 5)
                      ]),
                  child: TextFormField(

                    controller: moblie,
                    //obscureText: true,
                    decoration: InputDecoration(
                      border: InputBorder.none,

                      hintText: 'Moblie number',

                      icon: Icon(
                        Icons.phone,
                        color: Colors.blueGrey,
                      ),
                    ),


                  ),
                ),

                SizedBox(   //Use of SizedBox
                  height: 30,
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 1.2,
                  height: 50,
                  padding:
                  EdgeInsets.only(top: 4, left: 16, right: 16, bottom: 4),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(color: Colors.black12, blurRadius: 5)
                      ]),
                  child: TextFormField(


                    controller: email,

                    //obscureText: true,
                    decoration: InputDecoration(
                      border: InputBorder.none,

                      hintText: 'Email Id',


                      icon: Icon(
                        Icons.email,
                        color: Colors.blueGrey,
                      ),
                    ),


                  ),
                ),

                SizedBox(
                  height: 20,
                ),

                Container(
                  width: MediaQuery.of(context).size.width / 1.2,
                  height: 50,
                  padding:
                  EdgeInsets.only(top: 4, left: 16, right: 16, bottom: 4),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(color: Colors.black12, blurRadius: 5)
                      ]),
                  child: TextFormField(


                    controller: address,

                    //obscureText: true,
                    decoration: InputDecoration(
                      border: InputBorder.none,

                      hintText: 'Address',


                      icon: Icon(
                        Icons.location_history,
                        color: Colors.blueGrey,
                      ),
                    ),


                  ),
                ),

                SizedBox(
                  height: 20,
                ),

                InkWell(
                  onTap: () async {

                    if(phone == moblie.text){

                    updateuserdata();
                    }else{  //if the user tries to update his moblie number,it first checks there is any account with this number.
                      checkuser();
                    }
                  },
                  child: Container(
                    height: 45,
                    width: MediaQuery.of(context).size.width / 3.0,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.blueGrey,
                            Colors.blueGrey,
                          ],
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(50))),
                    child: Center(
                      child: Text(
                        'Save'.toUpperCase(),
                        style: GoogleFonts.montserrat(color: Colors.white,fontSize: 16,),
                      ),
                    ),
                  ),
                ),

                // Spacer(flex: 3,),
              ],
            ),
          )


        ],
      ),

    );
  }
}
