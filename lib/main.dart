import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'network/Login screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyAJsiLMKa3hh1Fu67m2JsUzIRvTBAg1SSA",
      appId: "1:333426721780:android:1f0c97211c4f14647fefa1",
      messagingSenderId: "333426721780",
      projectId: "do-to-list-8c648",
    ),
  );
  runApp(const MyApp());
}




