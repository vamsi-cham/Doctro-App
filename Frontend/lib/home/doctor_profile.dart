import 'package:doctor_appointment/home/book_appointment.dart';
import 'package:doctor_appointment/widget/login_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DocProfile extends StatefulWidget {

  final String doctorname;
  final String doctorpic;
  final String doclocation;
  final String docspeciality;
  final String docfees;
  final String docemail;

  // receive data from the FirstScreen as a parameter
  DocProfile({Key key, @required this.doctorname, @required this.doctorpic , @required this.doclocation , @required this.docspeciality , @required this.docfees , @required this.docemail}) : super(key: key);


  @override
  _DocProfileState createState() => _DocProfileState();
}

class _DocProfileState extends State<DocProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        leading: BackButton(
            color: Colors.black
        ),
        title: Text(
          'Appointment',
          style: GoogleFonts.montserrat(color: Colors.black , fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),

      body: SingleChildScrollView(
        child: Background(
          child: Column(
            children: <Widget> [
                Row(
                  children:<Widget> [
                    CircleAvatar(
                      radius: 36,
                      backgroundImage: NetworkImage('${widget.doctorpic}') ,
                    ),
                    Spacer(),
                    Column(
                      children: [
                        Text(
                          widget.doctorname,
                          style: GoogleFonts.montserrat(color: Colors.black ,fontSize:24 ),
                        ),
                        Text(
                          '\n${widget.docspeciality} \n\nLocation - ${widget.doclocation} \n\nFee - ${widget.docfees}',
                          style: GoogleFonts.montserrat(color: Colors.black ),
                        ),
                      ],
                    ) ,
                    Spacer(),
                  ],
                ),
              SizedBox(height: 20.0),
              InkWell(
                onTap: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>
                        BookAppointment(
                          doctorname: widget.doctorname,
                          doctorpic:widget.doctorpic,
                          docspeciality: widget.docspeciality,
                          docfees: widget.docfees,
                          docemail: widget.docemail,
                        )
                    ),
                  );
                },
                child: Container(
                  height: 45,
                  width: MediaQuery.of(context).size.width / 2,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.blue,
                          Colors.blue,
                        ],
                      ),
                      borderRadius:
                      BorderRadius.all(Radius.circular(50))),
                  child: Center(
                    child: Text(
                      'Book Appointment',
                      style: GoogleFonts.montserrat(color: Colors.white,fontSize: 18,),
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
}
