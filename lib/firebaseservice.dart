// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'dart:async';

// class FirebaseService {
//   static final FirebaseFirestore _firebaseFirestore =
//       FirebaseFirestore.instance;
//   static final FirebaseService instance = FirebaseService._();

// // Internal constructor
//   FirebaseService._();

//   Future<void> saveDataUser(User data) {
//     _firebaseFirestore.collection('users').add(data.toJson());
//     return null;
//   }

//   Future<void> saveDataBookMark(BookMarks data) {
//     _firebaseFirestore.collection('bookmarks').add(data.toJson());
//     return null;
//   }
// }
