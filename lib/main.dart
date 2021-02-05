
import 'package:flutter/material.dart';
import 'package:world_time_app/pages/home.dart';
import 'package:world_time_app/pages/choose_location.dart';
import 'package:world_time_app/pages/loading.dart';
import 'package:world_time_app/views/home.dart';
import 'package:world_time_app/views/savedVideolist.dart';
import 'package:world_time_app/views/searchresult.dart';
import 'views/home.dart';
import 'views/savedVideolist.dart';
import 'views/savedVideolist.dart';

void main() {
  runApp( MaterialApp(
    initialRoute: '/',
    routes: {

      '/location':(context)=>ChooseLocation(),
      '/':(context)=>SavedFiles()
      ,
    },

  ));
}
