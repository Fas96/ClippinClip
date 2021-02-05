import 'package:flutter/material.dart';

import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class SavedFiles extends StatefulWidget {
  @override
  _SavedFilesState createState() => _SavedFilesState();
}

class _SavedFilesState extends State<SavedFiles> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child:  new StaggeredGridView.countBuilder(
      crossAxisCount: 4,
      itemCount: 14,
      itemBuilder: (BuildContext context, int index) => new Container(
        width: 100,
        height: 100,
        child: Card(

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          color: Colors.pinkAccent,
          elevation: 10,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const ListTile(
                leading:  Icon(Icons.album, size: 70),
                title: Text('Heart Shaker', style: TextStyle(color: Colors.white)),
                subtitle: Text('TWICE', style: TextStyle(color: Colors.white)),
              ),
              ButtonBar(

                  children: <Widget>[
                    FlatButton(
                      child: const Text('Edit', style: TextStyle(color: Colors.white)),
                      onPressed: () {},
                    ),
                    FlatButton(
                      child: const Text('Delete', style: TextStyle(color: Colors.white)),
                      onPressed: () {},
                    ),
                  ],
                ),

            ],
          ),
        ),
  ),
      staggeredTileBuilder: (int index) =>
      new StaggeredTile.count(2, index.isEven ? 2 : 2), mainAxisSpacing: 4.0, crossAxisSpacing: 4.0,));
  }
}
