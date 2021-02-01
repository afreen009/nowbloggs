import 'package:flutter/material.dart';
import 'package:google_signin_example/widget/config.dart';
import 'package:shimmer/shimmer.dart';

import '../model/post_entity.dart';
import '../network/wp_api.dart';
import 'home_post.dart';

class HomeCategory extends StatefulWidget {
  final String option;
  final List<String> url;
  HomeCategory({this.url, this.option});
  @override
  _HomeCategoryState createState() => _HomeCategoryState();
}

class _HomeCategoryState extends State<HomeCategory>
    with AutomaticKeepAliveClientMixin {
  List<PostEntity> posts = new List<PostEntity>();
  bool isLoading = true;

  @override
  void initState() {
    // print('here' + widget.url);
    super.initState();
    // print(FEATURED_CATEGORY_ID);
    for (int i = 0; i < widget.url.length; i++) {
      WpApi.getPostsList(category: FEATURED_CATEGORY_ID, baseurl: widget.url[i])
          .then((_posts) {
        setState(() {
          isLoading = false;
          posts.addAll(_posts);
        });
      }).then((value) => print(posts));
    }
  }

  @override
  Widget build(BuildContext context) {
    List<PostEntity> items = posts.reversed.toList();
    items.shuffle();
    // print(items);
    super.build(context);
    return isLoading
        ? SizedBox(
            width: MediaQuery.of(context).size.width / 2.5,
            height: 300.0,
            child: Shimmer.fromColors(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  color: Colors.grey,
                ),
              ),
              baseColor: Colors.white70,
              highlightColor: Colors.grey[700],
              direction: ShimmerDirection.ltr,
            ))
        : ListView.builder(
            itemCount: items?.length ?? 0,
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
//            physics: ClampingScrollPhysics(),
            itemBuilder: (context, index) {
              return HomePost(items[index],
                  isFeaturedList: true, option: widget.option);
            },
          );
  }

  @override
  bool get wantKeepAlive => true;
}
