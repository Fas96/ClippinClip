import 'package:flutter/material.dart';
import 'videoplayerscreen.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sqflite/sqflite.dart';
import 'clip.dart';

class SavedFiles extends StatefulWidget {
  @override
  _SavedFilesState createState() => _SavedFilesState();
}

class _SavedFilesState extends State<SavedFiles> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(

          title: Text('나만의 암기장'),),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: (){
            Navigator.pushNamed(context, '/simpleClip',arguments:
            {

            }
            );
          },
          label: Text('Q&A'),
          icon: Icon(Icons.question_answer),
          backgroundColor: Colors.pink,
        ),

        body: FutureBuilder(
      future: () async {
        Database db = await DatabaseHelper.instance.database;
        return await db.query("clips");
      } (),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
            List<Map<String, dynamic>> list = snapshot.data.toList();
            print('--------------------');
            print(list);

            print('--------------------');
            return new StaggeredGridView.countBuilder(
              crossAxisCount: 4,
              itemCount: list.length,
              itemBuilder: (BuildContext context, int index) => new Container(

                width: 100,
                height: 100,
                child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                color: Colors.lightBlue,
                elevation: 10,
                child: index < list.length ? VideoPlayerScreen(filename: list[index]['filename']) : ListTile(leading:  Icon(Icons.album, size: 70), title: Text('Heart Shaker', style: TextStyle(color: Colors.white)),
                    subtitle: Text('TWICE', style: TextStyle(color: Colors.white)),
                  ),
                ),
              ),
              staggeredTileBuilder: (int index) => new StaggeredTile.count(2, index.isEven ? 2 : 1), mainAxisSpacing: 4.0, crossAxisSpacing: 4.0,);
        }
        else {
          return Center(child: CircularProgressIndicator());
        }
      }
    ));
  }
}

