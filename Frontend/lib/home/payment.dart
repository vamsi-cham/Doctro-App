import 'dart:io';
import 'package:doctor_appointment/api/ApiUrl.dart';
import 'package:doctor_appointment/home/book_appointment.dart';
import 'package:doctor_appointment/home/main_screen.dart';
import 'package:doctor_appointment/main.dart';
import 'package:doctor_appointment/widget/loading.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import "package:async/async.dart";
import 'package:path/path.dart';

class Payment extends StatefulWidget {
  final String doctorname;
  final String doctorpic;
  final String docspeciality;
  final String docfees;
  final String docemail;
  final String booktime;
  final String bookdate;

  // receive data from the FirstScreen as a parameter
  Payment({Key key, @required this.doctorname, @required this.doctorpic , @required this.docspeciality , @required this.docfees , @required this.docemail,@required this.booktime,@required this.bookdate}) : super(key: key);

  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {

  var phonepay;
  var googlepay;
  var paytm;
  var fileName =  'No file selected';
  int id = 0;
  String radioButtonItem = '';
  File file;
  bool loading = false;

  Future getpaymentids() async{

    setState(() {
      loading = true;
    });

    var response = await http.post(Uri.parse(ApiUrl.baseurl+"getpaymentids.php"),body:{

      "tb" : "payments_upi",
      "action" : "getpaymentids"

    });
    var data = json.decode(response.body);
    print(data);

     if(data['status'] == 200){
       phonepay = data['data'][0]['phone_pay'];
       googlepay = data['data'][0]['google_pay'];
       paytm = data['data'][0]['paytm'];
     }

    setState(() {
      loading = false;
    });

  }

  @override
  void initState() {
    getpaymentids();
    super.initState();
  }

  Future uploadpayment(file,BuildContext context) async {

    var stream= new http.ByteStream(DelegatingStream(file.openRead()));
    var length= await file.length();
    var uri = Uri.parse(ApiUrl.baseurl+"uploadpayment.php");
    var request = new http.MultipartRequest("POST", uri);
    var multipartFile = new http.MultipartFile("file", stream, length, filename: basename(file.path));

    request.files.add(multipartFile);
    request.fields['action'] = "uploadpayment";


    var respond = await request.send();
    //print(respond.headers);
    if(respond.statusCode==200){
      print("Upload success...");
      booknow(context);
    }else{
      print("Upload Failed...");
      Fluttertoast.showToast(
          msg: "please try again" ,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 4,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }

  }
  Future getbookings(BuildContext context) async{
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


  Future booknow(BuildContext context) async{
   // DateFormat dateFormat = DateFormat("yyyy-MM-dd");
   // String bookedDate = dateFormat.format(selectedDate);
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
      "appointment_date" : widget.bookdate,
      "appointment_time" : widget.booktime,
      "payment_status" : "Success,not verified",
      "payment_upi" : radioButtonItem,
      "payment_proof" : fileName,
      "action" : "bookappointment",
      "tb":"patient_appointments",

    });

    //print(response.statusCode);

    if(response.statusCode==200){

      getbookings(context);

    }
  }


  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: BackButton(
            color: Colors.black
        ),
        title: Text(
          'Pay fee',
          style: GoogleFonts.montserrat(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,

      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'AMOUNT - ${widget.docfees}/-',
                  style: GoogleFonts.montserrat(color: Colors.black,fontSize: 20),
                ),
              ),
              Divider(),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'SELECT A PAYMENT METHOD',
                      style: GoogleFonts.montserrat(color: Colors.blueGrey,fontSize: 14),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Radio(
                    value: 1,
                    groupValue: id,
                    activeColor: Colors.blue,
                    onChanged: (val) {
                      setState(() {
                        radioButtonItem = phonepay;
                        id = 1;
                      });
                    },
                  ),
                  Text(
                    'Phone pay',
                    style: new TextStyle(fontSize: 17.0),
                  ),
                ],
              ),
              Row(
                children: [
                  Radio(
                    value: 2,
                    groupValue: id,
                    activeColor: Colors.blue,
                    onChanged: (val) {
                      setState(() {
                        radioButtonItem = googlepay;
                        id = 2;
                      });
                    },
                  ),
                  Text(
                    'Google Pay',
                    style: new TextStyle(
                      fontSize: 17.0,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Radio(
                    value: 3,
                    groupValue: id,
                    activeColor: Colors.blue,
                    onChanged: (val) {
                      setState(() {
                        radioButtonItem = paytm;
                        id = 3;
                      });
                    },
                  ),
                  Text(
                    'Paytm',
                    style: new TextStyle(
                      fontSize: 17.0,
                    ),
                  ),
                ],
              ),
              Divider(),
              Visibility(
                visible: (id != 0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'UPI ID',
                            style: GoogleFonts.montserrat(color: Colors.blueGrey,fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Pay to the below upi and upload the screenshot',
                            style: GoogleFonts.montserrat(color: Colors.black,fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                    Visibility(
                      visible: (id == 1),
                      child: Text(
                        phonepay,
                        style: GoogleFonts.montserrat(color: Colors.black,fontSize: 20),
                      ),
                    ),
                    Visibility(
                      visible: (id == 2),
                      child: Text(
                        googlepay,
                        style: GoogleFonts.montserrat(color: Colors.black,fontSize: 20),
                      ),
                    ),
                    Visibility(
                      visible: (id == 3),
                      child: Text(
                        paytm,
                        style: GoogleFonts.montserrat(color: Colors.black,fontSize: 20),
                      ),
                    ),
                    Divider(),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'UPLOAD PAYMENT SCREENSHOT',
                            style: GoogleFonts.montserrat(color: Colors.blueGrey,fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                    TextButton.icon(
                      icon: Icon(
                        Icons.upload_file,
                        size: 19,
                        color: Colors.blue,
                      ),
                        onPressed: () async{
                          print("yes");
                          FilePickerResult result = await FilePicker.platform.pickFiles(type: FileType.custom,
                            allowedExtensions: ['jpg', 'pdf', 'doc','docx'],);

                          if(result != null) {
                            file = File(result.files.single.path);
                            setState(() {
                              fileName = basename(file.path);
                            });
                            // print('vamsi $file');
                           // uploadreport(customers[index]['patient_id'],file,context);
                          } else {
                            // User canceled the picker
                          }
                        },

                        label: Text(
                          'Select a file',
                          style: GoogleFonts.montserrat(color: Colors.blueGrey,fontSize: 19,),

                        )
                    ),

                    SizedBox(height: 8,),
                    Text(
                      fileName,
                      style: GoogleFonts.montserrat(color: Colors.black,fontSize: 16,),
                    ),
                    SizedBox(height: 50,),
                    InkWell(
                      onTap: fileName != 'No file selected' ? () async {

                        uploadpayment(file,context);

                      }:null,
                      child: Container(
                        height: 45,
                        width: MediaQuery.of(context).size.width / 2,
                        decoration: fileName != 'No file selected' ? BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.blueGrey,
                                Colors.blueGrey,
                              ],
                            ),
                            borderRadius:
                            BorderRadius.all(Radius.circular(50))):BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.grey[50],
                                Colors.grey[50],
                              ],
                            ),
                            borderRadius:
                            BorderRadius.all(Radius.circular(50))),
                        child: fileName != 'No file selected' ? Center(
                          child: Text(
                            'Book',
                            style: GoogleFonts.montserrat(color: Colors.white,fontSize: 18,),
                          ),
                        ):Center(
                          child: Text(
                            'Book',
                            style: GoogleFonts.montserrat(color: Colors.black,fontSize: 18,),
                          ),
                        ),
                      ),
                    ),


                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
