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
    Map<String, String> cryptoPrices = {};
    for (String crypto in cryptoList) {
      String api = "$adress/$crypto/$currency?apikey=$apiKey";
      http.Response response = await http.get(
        Uri.parse(api),
      );
      if (response.statusCode == 200) {
        String jsonData = await response.body;
        var decodedData = await jsonDecode(jsonData);
        double data = decodedData['rate'];
        print(data);
        cryptoPrices[crypto] = data.toStringAsFixed(1);
      } else {
        print(response.statusCode);
      }
    }
    return cryptoPrices;
  }
}
