import 'package:world_time_app/data/data.dart';
import 'package:world_time_app/model/speciality.dart';
import 'package:world_time_app/views/doctor_info.dart';
import 'package:flutter/material.dart';

List<String> words = ["I", "am", "a", "man"];
int selectedWordIndex = 0;
List<List<String>> sentences = [
  ["I like apples"],
  ["I am Sam", "Who am I?"],
  ["A piece of cake"],
  ["Manner makes man", "Man!"],
];

class SearchResult extends StatefulWidget {
  @override
  _SearchResultState createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {

  List<SpecialityModel> specialities;

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
      body: Column (
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
                  Card (
                    child: Padding(
                      padding: EdgeInsets.all(100),
                      child: Center(child: Text(sentence)),
                      ),
                  ),
                ).toList(),
              ),
            ),         
        ],
      ),
    );
  }
}
