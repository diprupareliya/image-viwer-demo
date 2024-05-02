import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gallery_app/screen/homescreen.dart';
import 'package:get/get.dart';


Future<void> main() async {
  await Firebase.initializeApp(
    options: firebaseConfig,
  );
  runApp(const MyApp());
}

const firebaseConfig = FirebaseOptions(
    apiKey: "AIzaSyCkREBVNKZ84ftPqdMSoja8vQsKb2r0EyE",
    authDomain: "imageviewer-demo.firebaseapp.com",
    projectId: "imageviewer-demo",
    storageBucket: "imageviewer-demo.appspot.com",
    messagingSenderId: "909260257694",
    appId: "1:909260257694:web:f1f89fdcea12d87a643e8f",
    measurementId: "G-JQM3MBMJ1L"
);

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return  const GetMaterialApp(
      debugShowCheckedModeBanner: false,
        title: 'Material App',
        home: HomeScreenView()
    );
  }
}

