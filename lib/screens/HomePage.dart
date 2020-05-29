import '../services/Networking.dart';
import 'package:flutter/material.dart';
import '../reusables/ReusableCard.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

const cardColor = Color(0xFF1D1E33);

class HomePageMain extends StatefulWidget {
  HomePageMain({this.results, this.topWords, this.cityNames});

  final results;
  final topWords;
  final cityNames;

  @override
  _HomePageMainState createState() => _HomePageMainState();
}

class _HomePageMainState extends State<HomePageMain> {
  // ignore: non_constant_identifier_names
  var ResultData;
  var cityName;
  var confirmed;
  var recovered;
  var critical;
  var cityName1;
  var deaths;
  double topword;
  String loadingText = '';
  double number;

  getData() async {
    print('yess');
    topword = widget.topWords;
    cityName = widget.cityNames;
    updateUIWorld(widget.results);
  }

  updateUIWorld(data) {
    setState(() {
      number = 30;
      topword = 60;
      cityName = 'World';
      print(data[0]);
      confirmed = data[0]['confirmed'];
      recovered = data[0]['recovered'];
      critical = data[0]['critical'];
      deaths = data[0]['deaths'];
    });
  }

  updateUICountry(data) {
    setState(() {
      print(data[0]);

      cityName = data[0]['country'];
      confirmed = data[0]['confirmed'];
      recovered = data[0]['recovered'];
      critical = data[0]['critical'];
      deaths = data[0]['deaths'];
    });
  }

  alertBox() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: cardColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: Container(
              height: 200,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: TextField(
//                        onSubmitted: work(),
                        style: new TextStyle(
                          color: Colors.white,
                          fontFamily: 'ComicNeue',
                        ),
                        onTap: () {
                          setState(() {
                            number = 1;
                            cityName = '---';
                          });
                        },
                        decoration: InputDecoration(
                          fillColor: Colors.red,
//                          border: InputBorder.none,
                          border: OutlineInputBorder(),
                          hintText: 'Enter Country Name',
                          hintStyle:
                              TextStyle(fontSize: 20.0, color: Colors.grey),
                        ),
                        onChanged: (value) {
                          setState(() {
                            cityName1 = value;
                          });
                        },
                      ),
                    ),
                    Center(
                      child: Text(
                        loadingText,
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'ComicNeue',
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 320.0,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            loadingText = 'loading...';
                          });
                        },
                        child: Center(
                          child: RaisedButton(
                            onPressed: () async {
                              try {
                                NetworkingBrain network =
                                    NetworkingBrain(params: cityName1);
                                ResultData = await network.getData();
                                print(ResultData);
                                updateUICountry(ResultData);
                                print('data');
                                Future.delayed(const Duration(seconds: 1), () {
                                  setState(() {
                                    number = 30;
                                    topword = 60;
                                  });
                                });
                              } catch (e) {
                                print(e);
                                print('got ot');
                                setState(() {
                                  cityName = 'Enter Proper Country Name';
                                  number = 1;
                                  topword = 30;
                                });
                              }

                              Navigator.of(context).pop();
                            },
                            child: Text(
                              "Search",
                              style: TextStyle(color: Colors.white),
                            ),
                            color: Color(0xFFeb1555),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(
              height: 40,
            ),
            Expanded(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Center(
                      child: Text(
                        cityName,
                        style: TextStyle(
                          fontSize: topword,
                          fontWeight: FontWeight.w800,
                          fontFamily: 'QuickSand',
                        ),
                      ),
                    ),
                  ],
                ),
                margin: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: cardColor,
                ),
              ),
            ),
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Reusable_Card(
                      colour: cardColor,
                      title: 'Confirmed',
                      fontsize: number,
                      value: confirmed.toString(),
                    ),
                  ),
                  Expanded(
                    child: Reusable_Card(
                      colour: cardColor,
                      title: 'Recovered',
                      fontsize: number,
                      value: recovered.toString(),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Reusable_Card(
                      colour: cardColor,
                      title: 'Critical',
                      fontsize: number,
                      value: critical.toString(),
                    ),
                  ),
                  Expanded(
                    child: Reusable_Card(
                      colour: cardColor,
                      title: 'Death',
                      fontsize: number,
                      value: deaths.toString(),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  RoundIconButton(
                    icon: FontAwesomeIcons.globe,
                    onPressed: () async {
                      NetworkingBrain network = NetworkingBrain();
                      ResultData = await network.getWorldData();
                      updateUIWorld(ResultData);
                    },
                  ),
                  RoundIconButton(
                    icon: FontAwesomeIcons.search,
                    onPressed: () {
                      alertBox();
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RoundIconButton extends StatelessWidget {
  RoundIconButton({@required this.icon, this.onPressed});
  final IconData icon;
  final Function onPressed;
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      child: Icon(icon),
      onPressed: onPressed,
      elevation: 6,
      constraints: BoxConstraints.tightFor(
        width: 56,
        height: 56,
      ),
      shape: CircleBorder(),
      fillColor: Color(0xFF4C4F5E),
    );
  }
}
