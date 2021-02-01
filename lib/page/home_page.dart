import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_signin_example/page/home.dart';
import 'package:google_signin_example/screens/auth/auth.dart';
import 'package:google_signin_example/utilities/googlebutton.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
// final GoogleSignIn googleSignIn = GoogleSignIn();

class _WelcomeState extends State<Welcome> {
  // FirebaseUser user;
  Color primaryColor = Color(0xff18203d);
  Color secondaryColor = Color(0xff232c51);
  Color logoGreen = Color(0xff25bcbb);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Stack(
        children: [
          Positioned(
            top: MediaQuery.of(context).size.height / 6,
            left: 5,
            right: 5,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: <Widget>[
                  //We take the image from the assets
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(120),
                        color: primaryColor),
                    child: Shimmer.fromColors(
                      period: Duration(milliseconds: 1500),
                      baseColor: logoGreen,
                      highlightColor: Colors.grey[300],
                      child: Image.asset(
                        'assets/genius.png',
                        height: 250,
                        width: 250,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  //Texts and Styling of them
                  Text(
                    'Welcome to the Genius App.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 28),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Your journey to achieve genius, starts here.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey[600], fontSize: 18),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  //Our MaterialButton which when pressed will take us to a new screen named as
                  //LoginScreen
                  GoogleSignupButtonWidget(),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Text('Terms and Condition',
                style: TextStyle(color: Colors.grey[500], fontSize: 18)),
          )
        ],
      ),
    );
  }
}

// class Check extends StatefulWidget {
//   @override
//   _CheckState createState() => _CheckState();
// }

// class _CheckState extends State<Check> {
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<FirebaseUser>(
//       future: FirebaseAuth.instance.currentUser(),
//       builder: (context, snapshot) {
//         if (snapshot.hasData) {
//           FirebaseUser user = snapshot.data;
//           return HomePage();
//         } else {
//           return LoginScreen();
//         }
//       },
//     );
//   }
// }
