import 'package:flutter/material.dart';

import 'HomePage.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../services/Networking.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  String url;

  Route<Object> get route => null;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocationData();
  }

  void getLocationData() async {
    NetworkingBrain network = NetworkingBrain();
    var result = await network.getWorldData();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HomePageMain(
          results: result,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.white,
          size: 50.0,
        ),
      ),
    );
  }
}
