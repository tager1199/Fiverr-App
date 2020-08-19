import 'package:flutter/material.dart';

class ToDo extends StatelessWidget {
  final List<String> toDo;

  ToDo(this.toDo);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
        children: toDo
            .map(
              (element) => Card(
            child: Column(
              children: <Widget>[Text(element)],
            ),
          ),
        )
            .toList());

  }
}

