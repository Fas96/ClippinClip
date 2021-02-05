import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Map dataRec = {};


  @override
  Widget build(BuildContext context) {

    dataRec= dataRec.isNotEmpty ? dataRec : ModalRoute.of(context).settings.arguments;

    print('Received data');
    print(dataRec);
    //background image check
    String bgImage = dataRec['isDayTime'] ? 'day.jpg':'night.jpg';
    Color bgColor = dataRec['isDayTime'] ? Colors.blue:Colors.indigo[700];
    print(bgImage);
    return Scaffold(
      backgroundColor:bgColor,

      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text('Home Screen'),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: SafeArea(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/$bgImage'),
            fit: BoxFit.cover,
          )
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 120, 0.0, 0.0),
          child: Column(
            children: [
              FlatButton.icon(onPressed: () async{
               dynamic res= await Navigator.pushNamed(context, '/location');
               setState(() {
                 dataRec={
                   'location':res['location'],
                   'flag':res['flag'],
                   'time':res['time'],
                   'isDayTime':res['isDayTime'],
                 };
               });
              }, icon: Icon(Icons.edit_location,
              color: Colors.grey[300],),
                  label: Text('choose location',
                  style: TextStyle(
                      color: Colors.grey[300]
                  ),))
              ,
              SizedBox(height: 20,)
              ,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    dataRec['location'],
                    style: TextStyle(
                      fontSize: 28.0,
                      letterSpacing: .0,
                      color: Colors.grey[300],
                    ),
                  ),

                ],
              )  ,
              SizedBox(height: 20),
              Text(
                dataRec['time'],
                style: TextStyle(
                  fontSize: 66.0,
                  letterSpacing: .0,
                  fontWeight: FontWeight.bold,
                    color: Colors.grey[300],
                ),
              ),


            ],
          ),
        ),
      )
    ));
  }
}
