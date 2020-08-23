import 'package:flutter/material.dart';
import 'package:flutter_wordpress/flutter_wordpress.dart' as wp;

class post extends StatelessWidget {
  final List<wp.Post> _posts;

  post(this._posts);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
        children: _posts.map(
              (element) => Card(
            child: Column(
              children: <Widget>[Image.network(element.featuredMedia.mediaDetails.sizes.medium.sourceUrl), Text(element.title.rendered)],
            ),
          ),
        ).toList());
  }
}