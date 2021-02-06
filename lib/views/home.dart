import 'dart:convert';
import 'savedVideolist.dart';
import 'package:http/http.dart';
import 'package:world_time_app/model/speciality.dart';
import 'package:world_time_app/views/doctor_info.dart';
import 'package:flutter/material.dart';
import 'searchresult.dart';
import 'addbutton.dart';
import 'videoplayerscreen.dart';

String selectedCategorie= "Adults";

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}
//


String wordsearch='안녕하세요 잘 지내세요';
class _HomePageState extends State<HomePage> {


  List<SpecialityModel> specialities;

  final _controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                      SavedFiles(),
                    )
                  );
                },
              ),
          ],
        ),// Populate the Drawer in the next step.
      ),
     ),
      body: Builder (builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(vertical: 10,horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 10,),
                Text("단어 검색", style: TextStyle(
                  color: Colors.black87.withOpacity(0.8),
                  fontSize: 30,
                  fontWeight: FontWeight.w600
                ),),
                SizedBox(height: 40,),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  height: 50,
                  decoration: BoxDecoration(
                    color: Color(0xffEFEFEF),
                    borderRadius: BorderRadius.circular(14)
                  ),
                  child: Row(
                    children: <Widget>[
                      IconButton(
                          icon: Icon(Icons.search),
                          onPressed: () => _submitted(_controller.text))
                      ,
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
                SizedBox(height: 30,),
                Text("Daily Clips", style: TextStyle(
                    color: Colors.black87.withOpacity(0.8),
                    fontSize: 30,
                    fontWeight: FontWeight.w600
                ),),
                SizedBox(height: 20,),

                FutureBuilder (
                  future: () async {
                    List list = [];
                    for(int i = 0; i < 3; i = i + 1) {
                      //print(i);
                      Response response = await get( 'http://beerabbit.kr/api/doTest.php' );
                      List data = jsonDecode(response.body);
                      list.add(data);
                    }
                    return list;
                  } (),
                  builder: (context, snapshot) {
                    if(snapshot.hasData) {
                      List<Widget> widgetList = [];
                      for(int i = 0; i < 3; i = i + 1) {
                        //print(i);
                        print(snapshot.data);
                        widgetList.add(Card(
                            margin: EdgeInsets.all(12),
                            child: Column(
                              children: [
                                Stack(
                                  children: [
                                    Center (
                                      child: Padding (
                                        padding: EdgeInsets.all(30),
                                        child: 
                                        VideoPlayerScreen(filename: snapshot.data[i][1]['filename']),
                                      ),
                                    ),
                                    Positioned(
                                      right: 10,
                                      bottom: 10,  
                                      child: addButton(context, snapshot.data[i][0]['script'], snapshot.data[i][1]['filename']),
                                    ),
                                  ],
                                ),
                                Center (
                                  child: Text(
                                    snapshot.data[i][0]['script'],
                                    style: TextStyle (
                                      fontSize: 25
                                    )
                                  )
                                )
                              ]   
                          ),
                        )
                        );
                      }
                      return Column (
                        children: widgetList,
                      );
                    }
                    else {
                      return Center(child: CircularProgressIndicator());
                    }
                  }
                ),

              ],
            ),
          ),
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

class CategorieTile extends StatefulWidget {

  final String categorie;
  final bool isSelected;
  _HomePageState context;
  CategorieTile({this.categorie, this.isSelected,this.context});

  @override
  _CategorieTileState createState() => _CategorieTileState();
}

class _CategorieTileState extends State<CategorieTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        widget.context.setState(() {
          selectedCategorie = widget.categorie;
        });
      },
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 20),
        margin: EdgeInsets.only(left: 8),
        height: 30,
        decoration: BoxDecoration(
          color: widget.isSelected ? Color(0xffFFD0AA) : Colors.white,
          borderRadius: BorderRadius.circular(30)
        ),
        child: Text(widget.categorie, style: TextStyle(
          color: widget.isSelected ?  Color(0xffFC9535) : Color(0xffA1A1A1)
        ),),
      ),
    );
  }
}

class SpecialistTile extends StatelessWidget {

  final String imgAssetPath;
  final String speciality;
  final int noOfDoctors;
  final Color backColor;
  SpecialistTile({@required this.imgAssetPath,@required this.speciality
    ,@required this.noOfDoctors, @required this.backColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      margin: EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: backColor,
        borderRadius: BorderRadius.circular(24)
      ),
      padding: EdgeInsets.only(top: 16,right: 16,left: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(speciality, style: TextStyle(
            color: Colors.white,
            fontSize: 20
          ),),
          SizedBox(height: 6,),
          Text("$noOfDoctors Doctors", style: TextStyle(
            color: Colors.white,
            fontSize: 13
          ),),
          Image.asset(imgAssetPath, height: 160,fit: BoxFit.fitHeight,)
        ],
      ),
    );
  }
}


class DoctorsTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
          //prings up the next page
          builder: (context) => DoctorsInfo()
        ));
      },
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xffFFEEE0),
          borderRadius: BorderRadius.circular(20)
        ),
        padding: EdgeInsets.symmetric(horizontal: 24,
        vertical: 18),
        child: Row(
          children: <Widget>[
            Image.asset("assets/doctor_pic.png", height: 50,),
            SizedBox(width: 17,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Dr. Stefeni Albert", style: TextStyle(
                  color: Color(0xffFC9535),
                  fontSize: 19
                ),),
                SizedBox(height: 2,),
                Text("Heart Speailist", style: TextStyle(
                  fontSize: 15
                ),)
              ],
            ),
            Spacer(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15,
              vertical: 9),
              decoration: BoxDecoration(
                color: Color(0xffFBB97C),
                borderRadius: BorderRadius.circular(13)
              ),
              child: Text("Saves", style: TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w500
              ),),
            )
          ],
        ),
      ),
    ); 
  }
}





















class UserSearchString extends SearchDelegate{
  @override
  List<Widget> buildActions(BuildContext context) {
    return [IconButton(icon: Icon(Icons.close), onPressed: (){


    })];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(icon: Icon(Icons.arrow_back),onPressed: (){

      Navigator.pop(context);

    });
  }
  String selectedResult;

  @override
  Widget buildResults(BuildContext context) {
    return Container(
      child: Center(
        child: Text(selectedResult),
      ),
    );

  }

  List<String> recentList = ['Text 2','Text 3'];
  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> listExample =['Text 2','Text 3'];
    List<String> suggestLst =[];
    query.isEmpty ?  suggestLst =recentList:suggestLst.addAll(listExample.where(
          (element)=>element.contains(query),
    )) ;

    return ListView.builder(itemCount:suggestLst.length,itemBuilder: (context,index){
      return ListTile(
        title: Text(suggestLst[index]),
      );
    });
  }

}