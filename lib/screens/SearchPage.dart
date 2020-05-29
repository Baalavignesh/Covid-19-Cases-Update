import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

const cardColor = Color(0xFF1D1E33);

class _SearchPageState extends State<SearchPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
//    alertBox();
  }

  String cityName;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: TextField(
          decoration: InputDecoration(
//                          border: InputBorder.none,
            border: OutlineInputBorder(),
            hintText: 'Enter City Name',
            hintStyle: TextStyle(fontSize: 20.0, color: Colors.grey),
//
          ),
        ),
      ),
    );
  }
}
