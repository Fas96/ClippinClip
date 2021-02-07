import 'package:flutter/material.dart';

import 'package:world_time_app/services/world_time.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadLocation extends StatefulWidget {
  @override
  _LoadLocationState createState() => _LoadLocationState();
}

class _LoadLocationState extends State<LoadLocation> {

  String time='loading';

void setUpWorldTime() async{
  WorldTime instances = WorldTime(location: 'Berlin', flag:'germany.flga', url: 'Europe/Berlin');
  await instances.getTime();
  Navigator.pushReplacementNamed(context, '/home',arguments: {
    'location':instances.location,
    'flag':instances.flag,
    'time':instances.time,
    'isDayTime':instances.isDayTime,
  });

}


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setUpWorldTime();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      body:    Center(
        child: SpinKitWave (
          color: Colors.white,
          size: 50.0,
        )

      )
    );
  }
}
