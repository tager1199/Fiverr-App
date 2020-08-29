import 'package:flutter/material.dart';
//import 'package:flutter_wordpress/flutter_wordpress.dart' as wp;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'Post.dart';

class PostManager extends StatefulWidget {

  final int category;
  PostManager(this.category);
  @override
  State<StatefulWidget> createState() {
    return _PostManagerState();
  }
}

class _PostManagerState extends State<PostManager> {

  final String apiUrl = "https://www.phillycouponmom.com/wp-json/wp/v2/";
  List posts;

  Future<String> getPosts() async {

    var res = await http.get(Uri.encodeFull(apiUrl + "posts?_embed"), headers: {"Accept": "application/json"});

    // fill our posts list with results and update state
    setState(() {
      var resBody = json.decode(res.body);
      posts = resBody;
    });
    return "Success!";
  }
  @override
  void initState() {
    super.initState();
    this.getPosts();
  }
  @override
  Widget build(BuildContext context) {
    return    SizedBox(
        width: (MediaQuery.of(context).size.width),
        height: 1000.0,
        child: Scaffold(
      body: ListView.builder(
        itemCount: posts == null ? 0 : posts.length,
        itemBuilder: (BuildContext context, int index) {
          print(posts[index]["categories"]);
          if(posts[index]["categories"].contains(widget.category)){
            return Column(

              children: <Widget>[
                Card(
                  child: Column(
                    children: <Widget>[
                      new Image.network(posts[index]["_embedded"]["wp:featuredmedia"][0]["source_url"]),
                      new Padding(
                        padding: EdgeInsets.all(10.0),
                        child: new ListTile(
                          title: new Padding(
                              padding: EdgeInsets.symmetric(vertical: 10.0),
                              child: new Text(posts[index]["title"]["rendered"])),
                          subtitle: new Text(
                              posts[index]["excerpt"]["rendered"].replaceAll(new RegExp(r'<[^>]*>'), '')
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            );
          }
          else{
            return Column();
          }
        },
      ),
    ),
  );
  }

}

