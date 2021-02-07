import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'clip.dart';

FloatingActionButton addButton(BuildContext context,String sentence, String data) => FloatingActionButton(
  heroTag: null,
  onPressed: () async {
    if(data == null) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("추가 할 수 없습니다."),
      ));

    }else{

    Database db = await DatabaseHelper.instance.database;
    await db.insert(
      "clips",

      Clip(filename: data).toMap(),
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );

    print(await db.query("clips"));

    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text("추가되었습니다."),
  ));
  }},
  child: Icon(Icons.add), 
);