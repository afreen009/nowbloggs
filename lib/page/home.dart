import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_signin_example/model/post_entity.dart';
import 'package:google_signin_example/network/wp_api.dart';
import 'package:google_signin_example/page/article.dart';
import 'package:google_signin_example/page/edit_profile.dart';
import 'package:google_signin_example/page/explore_page.dart';
import 'package:google_signin_example/page/post_details.dart';
import 'package:google_signin_example/page/view_all.dart';
import 'package:google_signin_example/widget/config.dart';
import 'package:google_signin_example/widget/login.dart';
import 'package:provider/provider.dart';
import '../services/theme_changer.dart';
import '../tabs/home_tab.dart';
import 'all_videos.dart';
import 'channel_list.dart';

const String testDevice = '';

class HomePage extends StatefulWidget {
  // final String email;
  // final String photoUrl;
  // // value.photoUrl,value.email,value.displayName
  // HomePage({this.displayName, this.email, this.photoUrl});
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // BannerAd _bannerAd;
  FirebaseAuth auth = FirebaseAuth.instance;
  int currentIndex = 0;
  bool _switchValue = false;
  Color primaryColor = Color(0xff18203d);
  Color secondaryColor = Color(0xff232c51);
  Color logoGreen = Color(0xff25bcbb);
  Widget _appBarTitle = Text(
    'Genius',
    style: TextStyle(color: Colors.white),
  );
  String string;
  bool search = false;
  List<PostEntity> data = new List<PostEntity>();
  final TextEditingController _filter = new TextEditingController();
  final dio = new Dio();
  String _searchText = "";
  List names = new List();
  List filteredNames = new List();
  List<PostEntity> posts = new List<PostEntity>();
  List tempList = new List();
  Icon _searchIcon = new Icon(
    Icons.search,
    color: Color(0xff18203d),
  );
  List<String> url = [
    'https://enginejunkies.com/',
    'http://festivalsofearth.com/',
    'http://insuranceofearth.com/',
    'https://bookworms99.com/'
  ];
  _HomePageState() {
    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        setState(() {
          _searchText = "";
          filteredNames = names;
        });
      } else {
        setState(() {
          _searchText = _filter.text;
        });
      }
    });
  }

  void _getNames() async {
    List tempList = new List();

    print('inside');
    for (int i = 0; i < url.length; i++) {
      WpApi.getPostsList(category: FEATURED_CATEGORY_ID, baseurl: url[i])
          .then((_posts) {
        setState(() {
          print('data is here$_posts');
          data.addAll(_posts);
          for (int j = 0; j < 5; j++) {
            print("title" + data.toString());
            tempList.add(data[j].title);
          }
        });
      });
    }

    print('temp $tempList');
    // setState(() {
    setState(() {
      names = tempList;
      names.shuffle();
      filteredNames = names;
    });
    // });
  }

  @override
  void initState() {
    this._getNames();
    super.initState();
    tempList.clear();
  }

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Color(0xff18203d);
    // final themeChanger = Provider.of<ThemeChanger>(context);
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: 8.0,
        title: _appBarTitle,
        centerTitle: false,
        backgroundColor: primaryColor,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Container(
              height: 200, width: 200, child: Image.asset('assets/genius.png')),
        ),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              foregroundColor: primaryColor,
              child: IconButton(
                icon: _searchIcon,
                onPressed: () {
                  setState(() {
                    search = !search;
                    _searchPressed();
                  });
                },
              ),
            ),
          ),
          // Transform.scale(
          //     scale: .7,
          //     child: InkWell(
          //       onTap: () {
          //         setState(() {
          //           _switchValue = !_switchValue;
          //         });
          //       },
          //       child: CupertinoSwitch(
          //         trackColor: Colors.grey,
          //         value: _switchValue,
          //         onChanged: (bool value) {
          //           setState(() {
          //             _switchValue = value;
          //             themeChanger.toggle();
          //           });
          //         },
          //       ),
          //     )),
          // IconButton(
          //   icon: Icon(
          //     FontAwesomeIcons.powerOff,
          //     color: Colors.white,
          //   ),
          //   splashColor: Colors.transparent,
          //   highlightColor: Colors.transparent,
          //   onPressed: () => signOutUser().then((value) {
          //     Navigator.of(context).pushAndRemoveUntil(
          //         MaterialPageRoute(builder: (context) => LoginScreen()),
          //         (Route<dynamic> route) => false);
          //   }),
          // ),
        ],
      ),
      body: !search
          ? IndexedStack(
              index: currentIndex,
              children: <Widget>[
                Articles(),
                ViewAll(
                  baseurl: [
                    'https://Slasherhub.com/',
                    'http://Gosportx.com/',
                    'http://Gotrekx.com/',
                    'https://Gossipwheel.com/',
                    'https://Trendznet.com/'
                  ],
                  option: 'explore',
                ),
                HomeTab(),
                VideoTab(),
                EditProfilePage(),
                // SettingsUI()
              ],
            )
          : _buildList(),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: primaryColor,
        unselectedItemColor: Colors.white,
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              FontAwesomeIcons.home,
              size: 18,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.explore,
              size: 18,
            ),
            label: 'Explore',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(
          //     FontAwesomeIcons.search,
          //     size: 18,
          //   ),
          //   label: 'Search',
          // ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.article,
              size: 18,
            ),
            label: 'Articles',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.videocam_sharp,
              size: 20,
            ),
            label: 'Videos',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              size: 20,
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  _buildList() {
    if (_searchText.isNotEmpty) {
      print('data[index $data');

      for (int i = 0; i < filteredNames.length; i++) {
        if (filteredNames[i]
            .toLowerCase()
            .contains(_searchText.toLowerCase())) {
          print('filtered nameas');
          print(filteredNames[i]);
          tempList.add(filteredNames[i]);
        }
      }
      filteredNames = tempList;
    }
    return Container(
      child: ListView.builder(
        itemCount: names == null ? 0 : filteredNames.length,
        itemBuilder: (BuildContext context, int index) {
          return new ListTile(
              title: Text(filteredNames[index]),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PostDetails(data[index])));
              });
        },
      ),
    );
  }

  void _searchPressed() {
    setState(() {
      print(filteredNames);
      if (this._searchIcon.icon == Icons.search) {
        this._searchIcon = new Icon(Icons.close);
        this._appBarTitle = Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0), color: Colors.white),
          child: Center(
            child: new TextField(
              autofocus: true,
              controller: _filter,
              decoration: new InputDecoration(
                  prefixIcon: new Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  hintText: 'Search the posts'),
            ),
          ),
        );
      } else {
        this._searchIcon = new Icon(Icons.search);
        this._appBarTitle = new Text(
          'Search...',
          style: TextStyle(color: Colors.white),
        );
        filteredNames = names;
        _filter.clear();
      }
    });
  }

  @override
  void dispose() {
    // _connectivity.disposeStream();
    super.dispose();
  }
}
