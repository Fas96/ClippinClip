import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';


class WorldTime{
  String name; // name of the location
  String lastModified;//  the current time of the location
  String size; //flags of the location
  String url;  // the url to the location json request
  bool isDayTime=false; // determines if its day or night


  //constructor
  WorldTime({this.name, this.size,this.url});
//getting data from database

  Future<void> getTime() async{

    try{
    Response response=await get( 'http://worldtimeapi.org/api/timezone/$url');
    //convert to json
    Map data=jsonDecode(response.body );
    
    
    String datetime = data['datetime'];


    DateTime now = DateTime.parse(datetime);

    String offset = data['utc_offset'].substring(1,3);

    //ternaru operator
    isDayTime = (now.hour>6 && now.hour<20)? true:false;

    //adds up the offset from the time zoon
    now = now.add(Duration(hours: int.parse(offset)));
    //using the intl lib to format the date
    lastModified= DateFormat.jm().format(now);
  }catch(e){
      print('error $e');
      lastModified='could not get time data';
    }
}}