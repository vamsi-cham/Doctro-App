import 'package:doctor_appointment/api/ApiUrl.dart';
import 'package:doctor_appointment/home/doctor_profile.dart';
import 'package:doctor_appointment/home/home.dart';
import 'package:doctor_appointment/home/main_screen.dart';
import 'package:doctor_appointment/widget/loading.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SearchDoc extends StatefulWidget {

  final String query;

  SearchDoc({Key key ,@required this.query }) : super(key: key);

  @override
  _SearchDocState createState() => _SearchDocState();
}

class _SearchDocState extends State<SearchDoc> {

    List searchedDocs = [];
    bool loading = false;

    Future searchdoctor() async{

      setState(() {
        loading = true;
      });
      // print(user);

      var response = await http.post(Uri.parse(ApiUrl.baseurl+"searchdoctor.php"),body:{
        "query" : widget.query,
        "tb" : "doctor",
        "action" : "searchdoctor"

      });
      //print('addUser Response: ${response.body}');


      var data = json.decode(response.body);
      //print(data);

      if(data['status']==200){
        searchedDocs = data['data'];
        print(searchedDocs);
      }

      setState(() {
        loading = false;
      });

    }
    @override
    void initState() {
      searchdoctor();
      super.initState();
    }



  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;


    final double itemHeight = (size.height - kToolbarHeight - 24) / 3;
    final double itemWidth = size.width / 2;

    return loading ? Loading() : Scaffold(

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
          },
        ),
        title: Text(
          'Results for ${widget.query}',
          style: GoogleFonts.montserrat(color: Colors.black ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.0,

      ),

        body: searchedDocs.length == 0 ? Container(
          child: Center(
            child: Text(
              "No Doctors found for ${widget.query}...",
              style: GoogleFonts.montserrat(color: Colors.black,fontSize: 17,),
              textAlign: TextAlign.center,
            ),
          ),
        ) :
        new GridView.builder(
            itemCount: searchedDocs.length,
            gridDelegate:  new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio:(itemWidth / itemHeight),mainAxisSpacing: 10, crossAxisSpacing: 10,),
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
                          backgroundImage: NetworkImage('${searchedDocs[index]['photo']}') ,
                        ),
                        //SvgPicture.asset('assets/user-profile.svg',height: 100,),
                        Text(
                          '\n${searchedDocs[index]['doctor_name']}',
                          style: GoogleFonts.montserrat(color: Colors.black ,fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '${searchedDocs[index]['specialist']}\n',
                          style: GoogleFonts.montserrat(color: Colors.black ),
                        ),
                        Text(
                          '${searchedDocs[index]['location']}\n',
                          style: GoogleFonts.montserrat(color: Colors.black ),
                        ),
                        InkWell(
                          onTap: () async {

                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) =>
                                  DocProfile(
                                    doctorname: searchedDocs[index]['doctor_name'],
                                    doctorpic:searchedDocs[index]['photo'] ,
                                    doclocation: searchedDocs[index]['location'],
                                    docspeciality: searchedDocs[index]['specialist'],
                                    docfees: searchedDocs[index]['fee'],
                                    docemail: searchedDocs[index]['email'],
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
