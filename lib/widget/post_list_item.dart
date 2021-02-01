import 'package:flutter/material.dart';
import 'package:google_signin_example/page/post_details.dart';
import 'package:google_signin_example/page/sharing_post.dart';
import 'package:share/share.dart';

import '../model/post_entity.dart';
import 'helpers.dart';
// import '../widgets/helpers.dart';

class PostListItem extends StatefulWidget {
  final PostEntity post;

  PostListItem(this.post);

  @override
  _PostListItemState createState() => _PostListItemState();
}

class _PostListItemState extends State<PostListItem> {
  // SharingPost share;

  String _selectedChoices;

  // final shareData = SharingPost();

  void _select(String choice) {
    setState(() {
      _selectedChoices = choice;
    });
    // showSnackBar(choice);
  }

  sharePost(
    BuildContext context,
  ) {
    print(widget.post.link);
    final RenderBox box = context.findRenderObject();
    Share.share(widget.post.title + '\n' + widget.post.link,
        subject: widget.post.link,
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }
  @override
  Widget build(BuildContext context) {
    // print(post.image);
    String imageUrl = widget.post.image;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => PostDetails(widget.post)));
        },
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 14.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: imageUrl.isNotEmpty
                    ? CachedImage(
                        widget.post.image,
                        width: 100,
                        height: 85,
                      )
                    : Center(child: Text('no image')),
              ),
            ),
            Flexible(
              child: SizedBox(
                height: 85.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.post.title,
                      textAlign: TextAlign.left,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1, //TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18.0, fontFamily: 'Roboto'),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(widget.post.date),
                        Expanded(
                          child: Text(
                            widget.post.category,
                            textAlign: TextAlign.end,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
