import 'package:doctor_appointment/home/contact_us.dart';
import 'package:doctor_appointment/home/doctors_list.dart';
import 'package:doctor_appointment/home/mybookings.dart';
import 'package:doctor_appointment/home/search_doctor.dart';
import 'package:doctor_appointment/home/userprofile.dart';
import 'package:doctor_appointment/widget/home_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sticky_headers/sticky_headers.dart';
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String query = '';

  GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {

    final controller = TextEditingController();
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height ) / 10;
    final double itemWidth = size.width / 6;


    return Scaffold(

      key: _scaffoldkey,

      backgroundColor: Colors.grey[50],

      drawer: UserDashboard(),

      body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children:<Widget> [

                  Row(
                    children: [
                      IconButton(icon: Icon(Icons.menu_open),color: Colors.black,iconSize: 30, onPressed: () => _scaffoldkey.currentState.openDrawer()),
                      Spacer(),
                      CircleAvatar(
                        radius: 18,
                        backgroundImage: NetworkImage("https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8dXNlcnxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60") ,
                      ),

                    ],
                  ),

                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
                    child: Text(
                      "Let's Find Your Doctor",
                      style: GoogleFonts.montserrat(
                        color: Colors.black,
                        fontSize: 35.0,

                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Spacer(),
                      CircleAvatar(
                        radius: 22,
                        backgroundImage: NetworkImage("https://image.flaticon.com/icons/png/512/3270/3270926.png") ,
                      ),
                      Spacer(),
                      CircleAvatar(
                        radius: 22,
                        backgroundImage: NetworkImage("https://image.flaticon.com/icons/png/512/3974/3974908.png") ,
                      ),
                      Spacer(),
                      CircleAvatar(
                        radius: 22,
                        backgroundImage: NetworkImage("https://image.flaticon.com/icons/png/512/3461/3461634.png") ,
                      ),
                      Spacer(),
                      CircleAvatar(
                        radius: 22,
                        backgroundImage: NetworkImage("https://image.flaticon.com/icons/png/512/3299/3299193.png") ,
                      ),
                      Spacer(),
                    ],
                  ),
                  SizedBox(height: 10,),
                  StickyHeader(
                    header: Container(
                      height: 42,
                      //margin: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white,
                        border: Border.all(color: Colors.blue,width: 2),
                      ),
                     // padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: TextField(
                        controller: controller,
                        decoration: InputDecoration(
                          icon: Icon(
                            Icons.local_hospital,
                            color: Colors.blue,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(Icons.search),
                            onPressed: (){
                              if(controller.text.isNotEmpty){

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => SearchDoc(query: controller.text,)),
                                );

                              }
                            },
                          ),
                          hintText: 'Search Doctor or Location',
                          hintStyle: GoogleFonts.montserrat(),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    content: Column(
                      children:<Widget> [
                        SizedBox(height: 20,),
                        GridView.count(

                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          childAspectRatio: (itemWidth / itemHeight),
                          primary: false,
                          crossAxisCount: 2,
                          controller: new ScrollController(keepScrollOffset: false),
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          children: <Widget>[
                            Card(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              elevation: 4,

                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => DoctorsList()),
                                  );
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children:<Widget> [
                                    SvgPicture.asset('assets/medical-doctor.svg',height: 100,),
                                    Text(
                                      '\nBook Appointment',
                                      style: GoogleFonts.montserrat(color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),


                            ),
                            Card(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              elevation: 4,
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => Profile()),
                                  );
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children:<Widget> [
                                    SvgPicture.asset('assets/user-profile.svg',height: 100,),
                                    Text(
                                      '\nProfile',
                                      style: GoogleFonts.montserrat(color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),


                            ),

                            Card(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              elevation: 4,
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => Mybookings()),
                                  );
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children:<Widget> [
                                    SvgPicture.asset('assets/enrollment.svg',height: 100,),
                                    Text(
                                      '\nMy bookings',
                                      style: GoogleFonts.montserrat(color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),


                            ),


                            Card(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              elevation: 4,
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => DoctorsList()),
                                  );
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children:<Widget> [
                                    SvgPicture.asset('assets/doctor.svg',height: 90,),
                                    Text(
                                      '\nDoctors list',
                                      style: GoogleFonts.montserrat(color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Card(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              elevation: 4,
                              child: InkWell(
                                onTap: (){
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) => Contactus()));
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children:<Widget> [
                                    SvgPicture.asset('assets/customer-service.svg',height: 100,),
                                    Text(
                                      '\nContact us',
                                      style: GoogleFonts.montserrat(color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
    );
  }
}
