import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'clip.dart';

FloatingActionButton addButton(BuildContext context) => FloatingActionButton(
  heroTag: null,
  onPressed: () async { 
    Database db = await DatabaseHelper.instance.database;
    await db.insert(
      "clips",
      Clip(filename: "just_call_me_call_me_call_me_call_me_call_me.mp4").toMap(),
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );

    print(await db.query("clips"));

    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text("추가되었습니다."),
  ));
  },
  child: Icon(Icons.add), 
);