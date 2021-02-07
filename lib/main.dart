
import 'package:flutter/material.dart';
import 'package:world_time_app/views/singleclip.dart';
import 'package:world_time_app/views/home.dart';

void main() {
  runApp( MaterialApp(

    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    routes: {
      '/simpleClip':(context)=>SpeechRecogToText(),
      '/':(context)=>HomePage()
      ,
    },

  ));
}
