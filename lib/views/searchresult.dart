import 'package:flutter/material.dart';
import 'singleclip.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'clip.dart';
import 'addbutton.dart';

List<String> words = ["I", "am", "a", "man"];
int selectedWordIndex = 0;
List<List<String>> sentences = [
  ["I like apples"],
  ["I am Sam", "Who am I?", "Am..."],
  ["A friend in need is a friend indeed."],
  ["Manner makes man", "Man!"],
];

class SearchResult extends StatefulWidget {
  @override
  _SearchResultState createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {

  @override
  void initState() {
    super.initState();
  }

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
        return Column (
          children: [
              Container(
                padding: EdgeInsets.fromLTRB(24, 0, 0, 0),
                margin: EdgeInsets.symmetric(horizontal: 10),
                height: 50,
                decoration: BoxDecoration(
                  color: Color(0xffEFEFEF),
                  borderRadius: BorderRadius.circular(14)
                ),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.search),
                    SizedBox(width: 10,),
                    Text("검색", style: TextStyle(
                      color: Colors.grey,
                      fontSize: 19
                    ),)
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                height: 40,
                child: ListView.builder(
                itemCount: words.length,
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index){
                  return GestureDetector(
                    onTap: (){
                      setState(() {
                        selectedWordIndex = index;
                      });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      margin: EdgeInsets.only(left: 8),
                      height: 30,
                      decoration: BoxDecoration(
                        color: selectedWordIndex == index ? Color(0xffFFD0AA) : Colors.white,
                        borderRadius: BorderRadius.circular(30)
                      ),
                      child: Text(words[index], style: TextStyle(
                        color: selectedWordIndex == index ?  Color(0xffFC9535) : Color(0xffA1A1A1),
                        fontSize: 20
                        ),
                        
                      ),
                    ),
                  );
                }),
              ),
              Expanded(
                child: ListView (
                  children: sentences[selectedWordIndex].map<Widget>( (sentence) =>
                    Stack(
                      children: [
                        InkWell(
                          onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                    SingleClip(sentence: sentence)));
                            },
                          child:
                            Center (
                              child: Padding (
                                padding: EdgeInsets.all(30),
                                child: Container (
                                  width: 300,
                                  height: 225,
                                  decoration: BoxDecoration (
                                    color: Colors.grey,
                                  ),
                                  child: Center(child: Text(sentence)),
                                ),
                              ),
                            ) 
                            /*
                            Card (
                            child: Padding(
                              padding: EdgeInsets.all(100),
                              child: Center(child: Text(sentence)),
                              ),
                            ),
                          */
                        ),
                        Positioned(
                          right: 30,
                          bottom: 10,  
                          child: addButton(context),
                          /*
                          FloatingActionButton(
                            heroTag: null,
                            onPressed: () async { 
                              final Future<Database> database = openDatabase(
                                join(await getDatabasesPath(), "saved_clips.db"),
                                onCreate: (db, version) {
                                  return db.execute(
                                    "CREATE TABLE clips(filename TEXT PRIMARY KEY)",
                                  );
                                },
                                version: 1,
                              );

                              final Database db = await database;
                              await db.insert(
                                "clips",
                                Clip(filename: "just_call_me_call_me_call_me_call_me_call_me.mp4").toMap(),
                                conflictAlgorithm: ConflictAlgorithm.ignore,
                              );

                              Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text("추가되었습니다."),
                            ));
                            },
                            child: Icon(Icons.add), 
                          ),
                          */
                        ),
                      ],
                    ),
                  ).toList(),
                ),
              ),         
          ],
        );
      }
      ),
    );
  }
}