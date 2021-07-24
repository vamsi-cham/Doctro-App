
import 'package:doctor_appointment/api/ApiUrl.dart';
import 'package:doctor_appointment/home/book_appointment.dart';
import 'package:doctor_appointment/home/main_screen.dart';
import 'package:doctor_appointment/home/paylater.dart';
import 'package:doctor_appointment/main.dart';
import 'package:doctor_appointment/widget/loading.dart';
import 'package:doctor_appointment/widget/login_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';



class Mybookings extends StatefulWidget {
  @override
  _MybookingsState createState() => _MybookingsState();
}

class _MybookingsState extends State<Mybookings> {

  bool loading = false;

  Future getbookings() async{
    // print(user);

    setState(() {
      loading = true;
    });

    var response = await http.post(Uri.parse(ApiUrl.baseurl+"userbookings.php"),body:{
      "moblie" : user[0]['moblie'],
      "tb" : "patient_appointments",
      "action" : "getuserbookings"

    });
    //print('addUser Response: ${response.body}');


    var data = json.decode(response.body);
    if(data['status']==200){
      bookings = data['data'];
      //print(bookings);
    }
    setState(() {
      loading = false;
    });
  }
  @override
  void initState() {
    getbookings();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: BackButton(
            color: Colors.black,
          onPressed: (){
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return MainScreen();
                },
              ),
            );
          } ,
        ),
        title: Text(
          'My bookings',
          style: GoogleFonts.montserrat(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: bookings.length == 0 ? Container(
        child: Center(
          child: Text(
            "No bookings made till now...",
            style: GoogleFonts.montserrat(color: Colors.black,fontSize: 17,),
            textAlign: TextAlign.center,
          ),
        ),
      )  : ListView.builder(
          itemCount: bookings.length,
          itemBuilder: (BuildContext context,int index){

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Background(
                child: Column(
                  children: [
                    Row(
                      children:<Widget> [

                        Spacer(),
                        Column(
                          children: [

                            Text(
                                bookings[index]['doctor_name'],
                              style: GoogleFonts.montserrat(color: Colors.black ,fontSize:24 ),
                            ),
                            Text(
                              '\n${bookings[index]['specialist']} ',
                              style: GoogleFonts.montserrat(color: Colors.black ),
                            ),
                            Text(
                              '\nFee - ${bookings[index]['fee']} ',
                              style: GoogleFonts.montserrat(color: Colors.black ),
                            ),
                          ],
                        ) ,
                        Spacer(),
                        CircleAvatar(
                          radius: 26,
                          backgroundImage: NetworkImage('${bookings[index]['photo']}') ,
                        ),

                        Spacer(),

                      ],
                    ),
                    SizedBox(height: 10,),

                    Background(
                      child: Column(
                       children:<Widget> [
                         Text(
                           'Appointment timings\n',
                           style: GoogleFonts.montserrat(color: Colors.blueGrey,fontSize: 20),
                         ),
                         Text(
                           'Date - ${bookings[index]['appointment_date']} \n',
                           style: GoogleFonts.montserrat(color: Colors.black,fontSize: 15),
                         ),
                         Text(
                           'Time - ${bookings[index]['appointment_time']} \n',
                           style: GoogleFonts.montserrat(color: Colors.black,fontSize: 15),
                         ),
                       ],
                      ),
                    ),

                    SizedBox(height: 20,),

                    Text(
                      'Booking Status - ${bookings[index]['booking_status']} \n',
                      style: GoogleFonts.montserrat(color: Colors.black,fontSize: 15),
                    ),
                    Text(
                      'Payment Status - ${bookings[index]['payment_status']} \n',
                      style: GoogleFonts.montserrat(color: Colors.black,fontSize: 15),
                    ),
                    Visibility(
                      visible: (bookings[index]['payment_status'] == "pending"),
                        child: ElevatedButton(
                          //style: GoogleFonts.montserrat(color: Colors.black,fontSize: 15),
                          onPressed: () {

                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) =>
                                  Paylater(
                                    appointmentid : bookings[index]['id'],
                                    docfees: bookings[index]['fee'],
                                  )
                              ),
                            );

                          },
                          child:  Text('Pay now'),
                        ),
                    ),
                  ],
                ),
              ),
            );
          }
      ),
    );
  }
}
