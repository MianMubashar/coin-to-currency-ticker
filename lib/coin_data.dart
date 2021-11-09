import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const apiKey = "FDA8C205-99C2-4DEB-9A56-07E4B1B66307";
const adress = "https://rest.coinapi.io/v1/exchangerate";
const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];
const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  Future getCoinData(String currency) async {
    String api = "$adress/BTC/$currency?apikey=$apiKey";
    http.Response response = await http.get(
      Uri.parse(api),
    );
    if (response.statusCode == 200) {
      String jsonData = await response.body;
      var data = await jsonDecode(jsonData)['rate'];
      print(data);
      return data;
    } else {
      print(response.statusCode);
    }
  }
}
