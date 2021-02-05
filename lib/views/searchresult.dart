import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:world_time_app/views/videoplayerscreen.dart';
import 'singleclip.dart';
import 'package:world_time_app/views/savedVideolist.dart';
import 'addbutton.dart';

List<String> words = ["I", "am", "a", "man"];
int selectedWordIndex = 0;
List<String> sentences;

String wordsearch='안녕하세요 잘 지내세요';
Map gData;

class SearchResult extends StatefulWidget {
  @override
  _SearchResultState createState() => _SearchResultState();

  Map data;

  SearchResult({@required this.data}) {

    print(',,,,,,,,,,,,,,');
    print(data.length);
    print(data);
    sentences = [];
    for(int i=0; i < data.length-1; i++){
      sentences.add(data[i.toString()].substring(0,(data[i.toString()].length-4)).replaceAll('_', " "));
    }
    print(sentences);
    words = data['translated'].split(" ");
    gData = data;
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
                  Navigator.push(context, MaterialPageRoute(

                      builder: (context) => SavedFiles()
                  ));
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
                  children:  mapIndexed(
                    sentences,
                        (index, sentence) =>
                            Card(
                              margin: EdgeInsets.all(12),
                              child: Column(
                                  children: [
                                    Stack(
                                      children: [
                                        Center (
                                          child: Padding (
                                            padding: EdgeInsets.all(30),
                                            child:
                                            VideoPlayerScreen(filename: gData[index.toString()]),
                                          ),
                                        ),
                                        Positioned(
                                          right: 10,
                                          bottom: 10,
                                          child: addButton(context, sentence, gData[index.toString()]),
                                        ),
                                      ],
                                    ),
                                    Center (
                                        child: Text(
                                            sentence,
                                            style: TextStyle (
                                                fontSize: 25
                                            )
                                        )
                                    )
                                  ]
                              ),
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
    print(text);
    wordsearch = text;
    Response response = await get( 'http://beerabbit.kr/api/clipApi.php?kor='+wordsearch);
    //convert to json
    Map sdata=jsonDecode(response.body);
    print('--------------------response---------------------');
    print('http://beerabbit.kr/data/'+ sdata['0']);

    Navigator.push(context, MaterialPageRoute(

        builder: (context) => SearchResult(data: sdata)
    ));
  }
  Iterable<E> mapIndexed<E, T>(
      Iterable<T> items, E Function(int index, T item) f) sync* {
    var index = 0;

    for (final item in items) {
      yield f(index, item);
      index = index + 1;
    }
  }
}