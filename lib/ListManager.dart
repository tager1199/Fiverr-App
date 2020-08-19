import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './List.dart';

class ListManager extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ListManagerState();
  }
}

class _ListManagerState extends State<ListManager> {
  List<String> _ToDo = [];
  _loadList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _ToDo = (prefs.getStringList('List') ?? []);
    });
  }
  final prefs = SharedPreferences.getInstance();
  _SetList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setStringList('List', _ToDo);
    });
  }

  @override
  void initState() {
    super.initState();
    _loadList();
  }
  Widget build(BuildContext context) {
    final myController = TextEditingController();
    return Column(
      children: [
        Container(
          child: TextField(
            controller: myController,

          ),
        ),
        Container(
          margin: EdgeInsets.all(10.0),
          child: RaisedButton(
            onPressed: () {
              if (myController.text != ""){
                setState(() {
                  _ToDo.add(myController.text);
                  _SetList();
                });
              }
            },
            child: Text('Add to List'),
          ),
        ),
        ToDo(_ToDo)
      ],
    );
  }
}
