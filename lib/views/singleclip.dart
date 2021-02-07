import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'clip.dart';
import 'videoplayerscreen.dart';
import 'package:sqflite/sqflite.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

List questions = ['What is the title of the song?','What can you say about the characters?','When was it made?','Where was the song made?','When was it released?'];

void questionChecker(String quest) async {
Database db = await DatabaseHelper.instance.database;
  print('re--------------------------------re');
  List<Map> list = await db.rawQuery('SELECT * FROM clip');
print('re--------------------------------re');
}

class SingleClip extends StatefulWidget {
  @override
  _SingleClipState createState() => _SingleClipState();

  String sentence;
  SingleClip({@required this.sentence});
}



class _SingleClipState extends State<SingleClip> {
  VideoPlayerController controller;
  VoidCallback listener;

  @override
  void initState() {
    listener = () => setState(() {});
    videoHandler('http://beerabbit.kr/data/how_many_how_many_are_there.mp4');
    super.initState();
    print("returned values from the ddatabases");
    questionChecker('rere');

    print("end values from the ddatabases");
  }

  void videoHandler(String url) {
    if (controller == null) {
      controller = VideoPlayerController.network(url)
        ..addListener(listener)
        ..setVolume(0.5)
        ..initialize();
    } else {
      if (controller.value.isPlaying) {
        controller.pause();
      } else {
        controller.play();
      }
    }}
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.pushNamed(context, '/', arguments:
            {
            }
            );
          },
          label: Text('End'),
          icon: Icon(Icons.calendar_today),
          backgroundColor: Colors.pink,
        ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          VideoPlayerScreen(filename: 'http://beerabbit.kr/data/how_many_how_many_are_there.mp4'),
          Center(
          child: Card(
            color: Colors.pinkAccent[200],

          child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
           onTap: () {
            print('Card tapped.');
          },
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
              width: 300,
              height: 100,
              child: Text('What is the name of the user?',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                  fontSize: 25.0,
                ),
              ),
      ),
          ),
    ),
    ),
    ),
       SizedBox(height: 30,),
       IconButton(icon: Icon(Icons.speaker), tooltip: 'Increase volume by 10', onPressed: (){

         setState(() {

         });
       })
        ],
      ),

    );

  }

}

class SpeechRecogToText extends StatefulWidget {
  @override
  _SpeechRecogToTextState createState() => _SpeechRecogToTextState();
}

class _SpeechRecogToTextState extends State<SpeechRecogToText> {
  stt.SpeechToText speech;
  bool islistening =false;
  String textSpeech = 'Press the button to start speaking';


  void onListen() async{

    if(!islistening){
      bool available = await speech.initialize(
        onStatus: (val)=>print("-----------onStatus: $val"),   onError: (val)=>print("onStatus: $val")
      );
      if(available){
        setState(() {
          islistening=true;
        });
        speech.listen(
          onResult: (val)=>setState((){
            textSpeech=val.recognizedWords;
            print('----------------------rersults-------------------');
        })
        );
      }
    }else{
      setState(() {
        islistening=false;
        speech.stop();
      });
    }

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    speech=stt.SpeechToText();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[30],

      appBar: AppBar(

        title: Text('Clippin Clip'),),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AvatarGlow(
        animate: islistening,
        glowColor: Theme.of(context).primaryColor,
        endRadius: 80,
        duration: Duration(milliseconds: 2000),
        repeatPauseDuration: Duration(milliseconds: 100),
        repeat: true,
        child: FloatingActionButton(
        onPressed: ()=>onListen(),
        child: Icon(islistening?Icons.mic:Icons.mic_none),
    ),

      ),
        body:SingleChildScrollView(
          reverse: true,
          child: Container(
            padding: EdgeInsets.fromLTRB(25, 25, 25, 150),
            child: Text(textSpeech,style: TextStyle(
              fontSize: 32,
              color: Colors.black87,
              fontWeight: FontWeight.w500

            ),
            ),

          ),
        )
    );
  }
}

