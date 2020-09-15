import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

//import 'package:flutter_wordpress/flutter_wordpress.dart' as wp;
import 'package:http/http.dart' as http;
import 'dart:convert';

//import 'package:url_launcher/url_launcher.dart';
//import 'package:flutter_html_view/flutter_html_view.dart';
import 'package:webview_flutter/webview_flutter.dart';

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
    var res = await http.get(
        Uri.encodeFull(apiUrl + "posts?_embed&per_page=10"),
        headers: {"Accept": "application/json"});

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
    return SingleChildScrollView(
      child: SizedBox(
        width: (MediaQuery.of(context).size.width),
        height: 10000.0,
        child: Scaffold(
            body: ListView.builder(
          itemCount: posts == null ? 0 : posts.length,
          itemBuilder: (BuildContext context, int index) {
            if (posts[index]["categories"].contains(widget.category)) {
              return GestureDetector(
                child: Card(
                  margin: EdgeInsets.all(5.0),
                  color: Color(0xFFA6ACAF), // card color
                  child: Column(
                    children: <Widget>[
                      Card(
                        child: Column(
                          children: <Widget>[
                            new CachedNetworkImage(
                              imageUrl: posts[index]["_embedded"]
                                  ["wp:featuredmedia"][0]["source_url"],
                              placeholder: (context, url) =>
                                  CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ),
                            new Padding(
                              padding: EdgeInsets.all(10.0),
                              child: new ListTile(
                                title: new Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 10.0),
                                    child: new Text(
                                        posts[index]["title"]["rendered"])),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                onTap: () {
                  WebView(
                    initialUrl: posts[index]["guid"]["rendered"],
                    javascriptMode: JavascriptMode.unrestricted,
                  );
                  //launch(posts[index]["guid"]["rendered"]);
                },
              );
            } else {
              return Column(
                children: [
                  Text("Sorry but we do not have any coupons in that category")
                ],
              );
            }
          },
        )),
      ),
    );
  }
}
