import 'package:flutter/material.dart';

// ignore: camel_case_types
class Reusable_Card extends StatelessWidget {
  Reusable_Card(
      {this.colour, this.cardChild, this.title, this.value, this.fontsize});
  final Color colour;
  final Widget cardChild;
  final String title;
  final String value;
  final double fontsize;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w800,
              fontFamily: 'QuickSand',
            ),
          ),
          SizedBox(
            height: 30,
            width: 80,
            child: Divider(
              color: Colors.grey,
            ),
          ),
          Text(
            value,
            style: TextStyle(
                fontSize: fontsize ?? 50,
                fontWeight: FontWeight.w900,
                fontFamily: 'QuickSand'),
          )
        ],
      ),
      margin: EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: colour,
      ),
    );
  }
}
