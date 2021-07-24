import 'package:doctor_appointment/home/doctors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DoctorsList extends StatefulWidget {
  @override
  _DoctorsListState createState() => _DoctorsListState();
}

class _DoctorsListState extends State<DoctorsList> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Specialists',
          style: GoogleFonts.montserrat(color: Colors.black , fontWeight: FontWeight.bold),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0.0,

      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 8.0),

          child: Column(
            children:<Widget> [
              Card(
                color: Colors.white,
                elevation: 4,
                margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 22,
                    backgroundImage: NetworkImage('https://image.flaticon.com/icons/png/512/2805/2805211.png') ,
                  ),

                  title: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Doctors(specialist: 'Medicine specialist')),
                      );
                    },
                    child: Row(
                      children: [
                        Text(
                          "Medicine specialist",
                          style: GoogleFonts.montserrat(color: Colors.black ,  fontSize: 20),
                        ),
                      ],
                    ),
                  ),

                ),
              ),

              SizedBox(height: 10,),

              Card(
                color: Colors.white,
                elevation: 4,
                margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 22,
                    backgroundImage: NetworkImage("https://image.flaticon.com/icons/png/512/3299/3299193.png") ,
                  ),
                  title: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Doctors(specialist: 'Child specialist')),
                      );
                    },
                    child: Row(
                      children: [
                        Text(
                          "Child specialist",
                          style: GoogleFonts.montserrat(color: Colors.black , fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                  //subtitle: Text('Blood group-'),
                ),
              ),

              SizedBox(height: 10,),

              Card(
                color: Colors.white,
                elevation: 4,
                margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 22,
                    backgroundImage: NetworkImage("https://image.flaticon.com/icons/png/512/3270/3270926.png") ,
                  ),
                  title: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Doctors(specialist: 'Dentist')),
                      );
                    },
                    child: Row(
                      children: [
                        Text(
                          "Dentist",
                          style: GoogleFonts.montserrat(color: Colors.black , fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                  //subtitle: Text('Blood group-'),
                ),
              ),

              SizedBox(height: 10,),

              Card(
                color: Colors.white,
                elevation: 4,
                margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 22,
                    backgroundImage: NetworkImage("https://image.flaticon.com/icons/png/512/1835/1835006.png") ,
                  ),
                  title: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Doctors(specialist: 'Urologist')),
                      );
                    },
                    child: Row(
                      children: [
                        Text(
                          "Urologist",
                          style: GoogleFonts.montserrat(color: Colors.black , fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                  //subtitle: Text('Blood group-'),
                ),
              ),

              SizedBox(height: 10,),

              Card(
                color: Colors.white,
                elevation: 4,
                margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 22,
                    backgroundImage: NetworkImage("https://image.flaticon.com/icons/png/512/4200/4200980.png") ,
                  ),
                  title: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Doctors(specialist: 'Skin and hair')),
                      );
                    },
                    child: Row(
                      children: [
                        Text(
                          "Skin and hair",
                          style: GoogleFonts.montserrat(color: Colors.black  , fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                  //subtitle: Text('Blood group-'),
                ),
              ),

              SizedBox(height: 10,),

              Card(
                color: Colors.white,
                elevation: 4,
                margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 22,
                    backgroundImage: NetworkImage("https://image.flaticon.com/icons/png/512/3015/3015949.png") ,
                  ),
                  title: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Doctors(specialist: 'Eye')),
                      );
                    },
                    child: Row(
                      children: [
                        Text(
                          "Eye",
                          style: GoogleFonts.montserrat(color: Colors.black  , fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                  //subtitle: Text('Blood group-'),
                ),
              ),

              SizedBox(height: 10,),

              Card(
                color: Colors.white,
                elevation: 4,
                margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 22,
                    backgroundImage: NetworkImage("https://image.flaticon.com/icons/png/512/3461/3461634.png") ,
                  ),
                  title: InkWell(

                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Doctors(specialist: 'Cardiologist')),
                      );
                    },

                    child: Row(
                      children: [
                        Text(
                          "Cardiologist",
                          style: GoogleFonts.montserrat(color: Colors.black , fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                  //subtitle: Text('Blood group-'),
                ),
              ),

              SizedBox(height: 10,),

              Card(
                color: Colors.white,
                elevation: 4,
                margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 22,
                    backgroundImage: NetworkImage("https://image.flaticon.com/icons/png/512/3974/3974908.png") ,
                  ),
                  title: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Doctors(specialist: 'Neurology')),
                      );
                    },
                    child: Row(
                      children: [
                        Text(
                          "Neurology",
                          style: GoogleFonts.montserrat(color: Colors.black , fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                  //subtitle: Text('Blood group-'),
                ),
              ),

              SizedBox(height: 10,),

              Card(
                color: Colors.white,
                elevation: 4,
                margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 22,
                    backgroundImage: NetworkImage("https://image.flaticon.com/icons/png/512/881/881803.png") ,
                  ),
                  title: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Doctors(specialist: 'Orthopedic')),
                      );
                    },
                    child: Row(
                      children: [
                        Text(
                          "Orthopedic",
                          style: GoogleFonts.montserrat(color: Colors.black , fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                  //subtitle: Text('Blood group-'),
                ),
              ),

            ],
          ),

        ),
      ),
    );
  }
}
