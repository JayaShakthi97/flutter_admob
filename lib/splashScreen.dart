import 'package:adstesting/home.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> initFirebase() =>
      FirebaseAdMob.instance.initialize(appId: FirebaseAdMob.testAppId);

  @override
  void initState() {
    super.initState();
    initFirebase().then(
      (value) => Future.delayed(Duration(seconds: 2), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
