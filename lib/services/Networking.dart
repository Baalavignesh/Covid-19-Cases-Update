import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkingBrain {
  NetworkingBrain({this.params});

  final params;
  String city;
  String output;

  Future getWorldData() async {
    try {
      var value = {'name': params};
      var uri = 'https://covid-19-data.p.rapidapi.com/totals';

      http.Response response = await http.get(uri, headers: {
        'x-rapidapi-host': "covid-19-data.p.rapidapi.com",
        'x-rapidapi-key': "84768ddbd5mshe582f65a69666d5p1fea75jsn3a2b9202cc14"
      });
      String data = response.body;
      print(data);
      print(response.statusCode);
      return jsonDecode(data);
    } catch (e) {
      print('error here');
      print(e);
    }
  }

  Future getData() async {
    try {
      var value = {'name': params};
      var uri = Uri.parse('https://covid-19-data.p.rapidapi.com/country')
          .replace(queryParameters: value)
          .toString();
      http.Response response = await http.get(uri, headers: {
        'x-rapidapi-host': "covid-19-data.p.rapidapi.com",
        'x-rapidapi-key': "84768ddbd5mshe582f65a69666d5p1fea75jsn3a2b9202cc14"
      });
      String data = response.body;
      print(data);
      print(response.statusCode);
      return jsonDecode(data);
    } catch (e) {
      print('error here');
      print(e);
      return output;
    }
  }
}
