import 'package:doctor_appointment/api/ApiUrl.dart';
import 'package:doctor_appointment/home/main_screen.dart';
import 'package:doctor_appointment/home/payment.dart';
import 'package:doctor_appointment/main.dart';
import 'package:doctor_appointment/widget/login_widget.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';


List bookings = [];
class BookAppointment extends StatefulWidget {

  final String doctorname;
  final String doctorpic;
  final String docspeciality;
  final String docfees;
  final String docemail;

  // receive data from the FirstScreen as a parameter
  BookAppointment({Key key, @required this.doctorname, @required this.doctorpic , @required this.docspeciality , @required this.docfees , @required this.docemail}) : super(key: key);


  @override
  _BookAppointmentState createState() => _BookAppointmentState();
}

class _BookAppointmentState extends State<BookAppointment> {

  var orderid;
  var checkoutprice;
  var paymentid;
  var paymenttime;



  Future getbookings() async{
   // print(user);

    var response = await http.post(Uri.parse(ApiUrl.baseurl+"userbookings.php"),body:{
      "moblie" : user[0]['moblie'],
      "tb" : "patient_appointments",
      "action" : "getuserbookings"

    });
    //print('addUser Response: ${response.body}');


    var data = json.decode(response.body);
    //print(data);

    if(data['status']==200){
      bookings = data['data'];
      //print(bookings);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            return MainScreen();
          },
        ),
      );
      Fluttertoast.showToast(
          msg: "Your appointment is booked" ,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 4,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }

  }


  Future booknow() async{
    DateFormat dateFormat = DateFormat("yyyy-MM-dd");
    String bookedDate = dateFormat.format(selectedDate);
    //String bookedTime = "${selectedTime.hour} : ${selectedTime.minute} ";

    var response = await http.post(Uri.parse(ApiUrl.baseurl+"bookAppointment.php"),body:{
      "name" : user[0]['name'],
      "moblie" :user[0]['moblie'],
      "email" :user[0]['email'],
      "address" : user[0]['address'],
      "doctor_name" : widget.doctorname,
      "doctor_email" : widget.docemail,
      "photo" : widget.doctorpic,
      "specialist" : widget.docspeciality,
      "fee" : widget.docfees,
      "appointment_date" : bookedDate,
      "appointment_time" : selectedTime.format(context),
      "payment_status" : "pending",
      "payment_upi" : "not paid",
      "payment_proof" : "not uploaded",
      "action" : "bookappointment",
      "tb":"patient_appointments",

    });

    //print(response.statusCode);

    if(response.statusCode==200){

      getbookings();

    }
  }


  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay(hour: 10, minute: 00);

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null && picked != selectedTime)
      setState(() {
        selectedTime = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: BackButton(
            color: Colors.black
        ),
        title: Text(
            'Book Appointment',
          style: GoogleFonts.montserrat(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,

      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[

            SizedBox(height: 30.0),
            Background(
              child: Row(
                children:<Widget> [

                  Spacer(),
                  Column(
                    children: [
                      Text(
                        'Book Appointment for this doctor\n',
                        style: GoogleFonts.montserrat(color: Colors.blueGrey),
                      ),
                      Text(
                        widget.doctorname,
                        style: GoogleFonts.montserrat(color: Colors.black ,fontSize:24 ),
                      ),
                      Text(
                        '\n${widget.docspeciality} \n\nFee - ${widget.docfees}',
                        style: GoogleFonts.montserrat(color: Colors.black ),
                      ),
                    ],
                  ) ,
                  Spacer(),
                  CircleAvatar(
                    radius: 26,
                    backgroundImage: NetworkImage('${widget.doctorpic}') ,
                  ),

                  Spacer(),

                ],
              ),
            ),
            SizedBox(height: 50.0),

            SizedBox(
              height: 30,
              child: Text(
                'Select a date for appointment',
                style: GoogleFonts.montserrat(color: Colors.blueGrey,fontSize: 18,),
              ),
            ),
            TextButton.icon(
              label: Text(
                "${selectedDate.toLocal()}".split(' ')[0],
                // textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(color: Colors.black,fontSize: 20),
              ) ,
              icon: Icon(
                Icons.mode_edit,
                color: Colors.black,
              ),
              onPressed: () {
                _selectDate(context);
              },
            ),

            SizedBox(
              height: 30,
              child: Text(
                'Select a time for appointment',
                style: GoogleFonts.montserrat(color: Colors.blueGrey,fontSize: 18,),
              ),
            ),
            TextButton.icon(
              label: Text(
                "${selectedTime.format(context)}",
                // textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(color: Colors.black,fontSize: 20),
              ) ,
              icon: Icon(
                Icons.mode_edit,
                color: Colors.black,
              ),
              onPressed: () {
                _selectTime(context);
              },
            ),

            SizedBox(height: 40.0),
            Row(
              children: [
                Spacer(),
                InkWell(
                  onTap: () async {

                    booknow();
                    //generateOrderid();

                    //booknow();
                  },
                  child: Container(
                    height: 45,
                    width: MediaQuery.of(context).size.width / 2.7,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.blueGrey,
                            Colors.blueGrey,
                          ],
                        ),
                        borderRadius:
                        BorderRadius.all(Radius.circular(50))),
                    child: Center(
                      child: Text(
                        'Book',
                        style: GoogleFonts.montserrat(color: Colors.white,fontSize: 18,),
                      ),
                    ),
                  ),
                ),
                Text(
                  ' OR ',
                  style: GoogleFonts.montserrat(color: Colors.black,fontSize: 14,),
                ),
                InkWell(
                  onTap: () async {
                    DateFormat dateFormat = DateFormat("yyyy-MM-dd");
                    String bookedDate = dateFormat.format(selectedDate);

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>
                          Payment(
                            doctorname: widget.doctorname,
                            doctorpic:widget.doctorpic,
                            docspeciality: widget.docspeciality,
                            docfees: widget.docfees,
                            docemail: widget.docemail,
                            booktime: selectedTime.format(context),
                            bookdate: bookedDate,
                          )
                      ),
                    );
                    //generateOrderid();

                    //booknow();
                  },
                  child: Container(
                    height: 45,
                    width: MediaQuery.of(context).size.width / 2.7,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.blueGrey,
                            Colors.blueGrey,
                          ],
                        ),
                        borderRadius:
                        BorderRadius.all(Radius.circular(50))),
                    child: Center(
                      child: Text(
                        'Book & Pay',
                        style: GoogleFonts.montserrat(color: Colors.white,fontSize: 18,),
                      ),
                    ),
                  ),
                ),
                Spacer(),
              ],
            ),
            //SizedBox(height: 20,),

          ],
        ),
      ),
    );
  }
}
