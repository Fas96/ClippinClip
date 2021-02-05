import 'package:flutter/material.dart';
import 'addbutton.dart';

class SingleClip extends StatefulWidget {
  @override
  _SingleClipState createState() => _SingleClipState();

  String sentence;
  SingleClip({@required this.sentence});
}

class _SingleClipState extends State<SingleClip> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        brightness: Brightness.light,
        iconTheme: IconThemeData(
            color: Colors.black87
        ),
      ),
      drawer: Drawer(
          child: Container()// Populate the Drawer in the next step.
      ),
      body: Builder (builder: (BuildContext context) {
          return Center(
          child: Column (
            children: [
              Expanded(
                flex: 1,
                child: FittedBox(
                  fit: BoxFit.fitWidth, 
                  child: Text("widget.sentence", style: TextStyle(
                    //fontSize: 40,
                    )
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(),
              ),
              Expanded(
                flex: 5,
                child: Padding (
                  padding: EdgeInsets.all(20),
                  child: Container (
                    width: 400,
                    height: 300,
                    decoration: BoxDecoration (
                      color: Colors.grey,
                    ),
                  ),
                ),  
                /*
                Card(
                  child: Padding (
                    padding: EdgeInsets.all(200),
                  )
                ),
                */
              ),
              Expanded(
                flex: 2,
                child: addButton(context),
                /*
                FloatingActionButton(
                  heroTag: null,
                  onPressed: () {
                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text("추가되었습니다."),
                    ));
                  },
                  child: Icon(Icons.add), 
                ),
                */
              ),
              Expanded(
                flex: 1,
                child: Container(),
              ),
            ],
          ),
        );
      }
      )
    );
  }
}