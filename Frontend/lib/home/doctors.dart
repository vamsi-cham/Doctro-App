import 'package:doctor_appointment/api/ApiUrl.dart';
import 'package:doctor_appointment/home/doctor_profile.dart';
import 'package:doctor_appointment/widget/loading.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Doctors extends StatefulWidget {
  final String specialist;

  // receive data from the FirstScreen as a parameter
  Doctors({Key key, @required this.specialist}) : super(key: key);

  @override
  _DoctorsState createState() => _DoctorsState();
}

List specialists = []; // list of all doctors from a particular department

class _DoctorsState extends State<Doctors> {

  bool loading = false;

  Future getdoctorslist() async{

            setState(() {
              loading = true;
            });

            var response = await http.post(Uri.parse(ApiUrl.baseurl+"doctors.php"),body:{
              "specialist" : widget.specialist,
              "tb" : "doctor",
              "action" : "getdoctorslist"

            });

            var data = json.decode(response.body);
            //print(data);

            if(data['status']==200){
              specialists = data['data'];
              print(specialists);
            }
            setState(() {
              loading = false;
            });
  }

  @override
  void initState() {
    getdoctorslist();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(

      appBar: AppBar(
        leading: BackButton(
            color: Colors.black,
        ),
        title: Text(
          'Doctors',
          style: GoogleFonts.montserrat(color: Colors.black , fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.0,

      ),

      body: new GridView.builder(
        itemCount: specialists.length,
          gridDelegate:  new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisSpacing: 10, crossAxisSpacing: 10,),
          primary: false,
          itemBuilder: (BuildContext context, int index) {

          return  new GestureDetector(
            child: Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(35),
              ),
              elevation: 4,
              child: InkWell(
                onTap: () {


                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:<Widget> [
                    CircleAvatar(
                      radius: 22,
                      backgroundImage: NetworkImage('${specialists[index]['photo']}') ,
                    ),
                    //SvgPicture.asset('assets/user-profile.svg',height: 100,),
                    Text(
                      '\n${specialists[index]['doctor_name']}',
                      style: GoogleFonts.montserrat(color: Colors.black ,fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '${specialists[index]['specialist']}\n',
                      style: GoogleFonts.montserrat(color: Colors.black ),
                    ),
                    InkWell(
                      onTap: () async {

                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>
                              DocProfile(
                                doctorname: specialists[index]['doctor_name'],
                                doctorpic:specialists[index]['photo'] ,
                                doclocation: specialists[index]['location'],
                                docspeciality: specialists[index]['specialist'],
                                docfees: specialists[index]['fee'],
                                docemail: specialists[index]['email'],
                              )
                          ),
                        );

                      },
                      child: Container(
                        height: 35,
                        width: MediaQuery.of(context).size.width / 2.7,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.white,
                                Colors.lightBlueAccent,

                              ],
                            ),
                            borderRadius:
                            BorderRadius.all(Radius.circular(50))),
                        child: Center(
                          child: Text(
                            'Appointment',
                            style: GoogleFonts.montserrat(color: Colors.black,fontSize: 18,),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),


            ),
          );

          }

      )

    );
  }
}
