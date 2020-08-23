import 'package:flutter/material.dart';
import 'package:flutter_wordpress/flutter_wordpress.dart' as wp;
import 'Post.dart';

final _root = 'https://www.phillycouponmom.com'; //replace with your site url
final wp.WordPress wordPress = wp.WordPress(baseUrl: _root);

class PostManager extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PostManagerState();
  }
}

class _PostManagerState extends State<PostManager> {
  @override
  void initState() {
    super.initState();
    this.getPosts();
  }

  Widget buildPost(int index) {
    return Column(
      children: <Widget>[
        Card(
          child: Column(
            children: <Widget>[
              buildImage(index),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: ListTile(
                  title: Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: Text(posts[index].title.rendered)),
                  subtitle: Text(posts[index].excerpt.rendered),
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  Widget buildImage(int index) {
    if (posts[index].featuredMedia == null) {
      return Image.asset('Assets/unnamed.png');
    }
    return Image.network(
      posts[index].featuredMedia.mediaDetails.sizes.medium.sourceUrl,
    );
  }



  Future<String> getPosts() async {
    var res = await fetchPosts();
    setState(() {
      posts = res;
    });
    print("Success!");
  }
  List<wp.Post> posts;

  Future<List<wp.Post>> fetchPosts() async {

    var posts = wordPress.fetchPosts(
      postParams: wp.ParamsPostList(
        context: wp.WordPressContext.view,
        postStatus: wp.PostPageStatus.publish,
        orderBy: wp.PostOrderBy.date,
        order: wp.Order.desc,
      ),
      fetchFeaturedMedia: true,
      fetchCategories: true,
      fetchTags: true,
    );
    return posts;
  }

  @override
  Widget build(BuildContext context) {
    //return ListView.builder(
       // itemCount: posts.length,
       // itemBuilder: (BuildContext context, int index) {
       //   return buildPost(index); //Building the posts list view
     //   });
    return Column(
     children: [
        post(posts)
     ],
    );
  }
}
