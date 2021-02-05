import 'package:flutter/material.dart';
import 'package:world_time_app/services/world_time.dart';

class ChooseLocation extends StatefulWidget {
  @override
  _ChooseLocationState createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {

  int counter=0;

  List<WorldTime> locations = [WorldTime(url: 'Africa/Abidjan',location: 'Abidjan',flag: 'Abidjan.jpg'),
    WorldTime(url: 'Africa/Accra',location: 'Accra',flag: 'Ghana.jpg'),
    WorldTime(url: 'Africa/Algiers',location: 'Algiers',flag: 'Algiers.png'),
    WorldTime(url: 'Africa/Bissau',location: 'Bissau',flag: 'Bissau.png')

  ];

  void updateTime(index) async{
    WorldTime instances = locations[index];
    await instances.getTime();
    //nave to homescreen

    Navigator.pop(context,{
      'location':instances.location,
      'flag':instances.flag,
      'time':instances.time,
      'isDayTime':instances.isDayTime,
    });

  }
  @override
  Widget build(BuildContext context) {

    print('build chooselocation runs');
    return  Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          backgroundColor: Colors.blue[900],
          title: Text('Clipping Clip'),
          centerTitle: true,
          elevation: 0.0,
          actions: [IconButton(icon: Icon(Icons.search), onPressed: (){

          })],
        ),
        body:  ListView.builder(itemCount: locations.length,itemBuilder: (context,index){
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 1.0,vertical: 4.0),
            child: Card(
              child: ListTile(
                onTap: (){ updateTime(index) ;},
                title: Text(locations[index].location),
                leading: CircleAvatar(
                  backgroundColor: Colors.grey[200],
                  backgroundImage: AssetImage('assets/${locations[index].flag}'),
                ),
              ),
            ),
          );
        }),
        floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
      // Add your onPressed code here!
    },
    label: Text('Approve'),
    icon: Icon(Icons.thumb_up),
    backgroundColor: Colors.pink,
    ),
           
    );
  }
}
