import 'dart:async';
import 'package:flutter/material.dart';

import 'home.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    splashScreenStart();
  }

  splashScreenStart() {
    var duration = Duration(seconds: 3);
    return Timer(duration, () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return LandingPage();
      }));
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          "assets/buah.jpg",
          width: 400,
          height: 400,
        ),
      ),
    );
  }
}

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var tinggi = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/FruitLanding.jpg"),
            fit: BoxFit.fitHeight,
          ),
        ),
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  margin: EdgeInsets.only(top: tinggi / 3),
                  height: tinggi / 6,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/FruitGuideText.png"),
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
              ),
              //Button
              Container(
                alignment: Alignment.center,
                width: 200,
                height: 70,
                margin: EdgeInsets.only(top: 50),
                child: ElevatedButton(
                  onPressed: () {
                    Get.off(Home());
                  },
                  child: Text("Let's Go!",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black)),
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(20),
                      primary: Colors.yellow,
                      minimumSize: Size(1000, 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
