import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'singleclip.dart';
import 'addbutton.dart';

List<String> words = ["I", "am", "a", "man"];
int selectedWordIndex = 0;
List<List<String>> sentences = [
  ["I like apples"],
  ["I am Sam", "Who am I?", "Am..."],
  ["A friend in need is a friend indeed."],
  ["Manner makes man", "Man!"],
];

String wordsearch='안녕하세요 잘 지내세요';

class SearchResult extends StatefulWidget {
  @override
  _SearchResultState createState() => _SearchResultState();

  Map data;
  SearchResult({@required this.data}) {

    words = data['translated'].split(" ");
  }
}

class _SearchResultState extends State<SearchResult> {
  final _controller = TextEditingController();

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
          child: Container(
            child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
            // 드로워해더 추가
            DrawerHeader(
            child: Text('Menu'),
            decoration: BoxDecoration(
              color: Color(0xffFFD0AA),
            ),
           ),
              ListTile(
                title: Text('나만의 암기장'),
                onTap: (){

                  // here 나만의 암기장 push
                  Navigator.pop(context);
                },
              ),
          ],
        ),// Populate the Drawer in the next step.
      ),
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
                    IconButton(
                        icon: Icon(Icons.search),
                        onPressed: () => _submitted(_controller.text)
                    ),
                    SizedBox(width: 10,),
                    Expanded(
                    child: TextField(
                      controller: _controller,
                      onSubmitted: _submitted,
                      decoration: new InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          hintText: '검색'
                      ),
                    ),
                   )
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
  Future<void> _submitted(String text) async {
    wordsearch = text;
    Response response = await get( 'http://beerabbit.kr/api/clipApi.php?kor='+wordsearch);
    //convert to json
    Map data=jsonDecode(response.body);
    print('--------------------response---------------------');
    print('http://beerabbit.kr/data/'+ data['0']);

    Navigator.push(context, MaterialPageRoute(

        builder: (context) => SearchResult(data: data)
    ));
  }
}