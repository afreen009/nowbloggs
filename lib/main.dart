import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_signin_example/page/home.dart';
import 'package:google_signin_example/page/home_page.dart';
import 'package:google_signin_example/services/theme_changer.dart';
import 'package:google_signin_example/theme.dart';
import 'package:google_signin_example/widget/signin.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  static final String title = 'Google SignIn';

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  StreamSubscription _intentDataStreamSubscription;
  List<SharedMediaFile> _sharedFiles;
  String _sharedText;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _intentDataStreamSubscription =
        ReceiveSharingIntent.getTextStream().listen((String value) {
      setState(() {
        _sharedText = value;
      });
    }, onError: (err) {
      print("getLinkStream error: $err");
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeChanger>(
      create: (_) => ThemeChanger(),
      child: Builder(builder: (context) {
        final themeChanger = Provider.of<ThemeChanger>(context);
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: MyApp.title,
          themeMode: themeChanger.getTheme,
          darkTheme: Style.get(true),
          theme: Style.get(false),
          home: CheckPage(),
        );
      }),
    );
  }
}

class CheckPage extends StatefulWidget {
  @override
  _CheckPageState createState() => _CheckPageState();
}

class _CheckPageState extends State<CheckPage> {
  String email;
  String photoUrl;
  String displayName;
  SharedPreferences prefs;
  checkInfo() async {
    prefs = await SharedPreferences.getInstance();
    email = prefs.getString('email');
    photoUrl = prefs.getString('photoUrl');
    displayName = prefs.getString('displayName');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider(
        create: (context) => GoogleSignInProvider(),
        child: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            final provider = Provider.of<GoogleSignInProvider>(context);
            if (provider.isSigningIn) {
              return buildLoading();
            } else if (snapshot.hasData) {
              return HomePage();
            } else {
              return Welcome();
            }
          },
        ),
      ),
    );
  }

  Widget buildLoading() => Stack(
        fit: StackFit.expand,
        children: [
          Center(child: CircularProgressIndicator()),
        ],
      );
}
