// import 'package:crypto_tracker/coin_data.dart';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'dart:io' show Platform;
// import 'package:http/http.dart' as http;
// import 'dart:convert';
//
// class PriceScreen extends StatefulWidget {
//   @override
//   _PriceScreenState createState() => _PriceScreenState();
// }
//
// class _PriceScreenState extends State<PriceScreen> {
//   String data = " ? ";
//   String dropDownListValue = 'USD';
//   String? crypto;
//   String value = "BTC";
//
//   DropdownButton androidPicker() {
//     List<String> currency = currenciesList;
//     List<DropdownMenuItem<String>> dropDownItems = [];
//     for (int i = 0; i < currency.length; i++) {
//       var menu = DropdownMenuItem(
//         child: Text(currency[i]),
//         value: currency[i],
//       );
//       dropDownItems.add(menu);
//     }
//     return DropdownButton<String>(
//       value: dropDownListValue,
//       items: dropDownItems,
//       onChanged: (value) {
//         setState(() {
//           dropDownListValue = value!;
//           getData();
//         });
//       },
//     );
//   }
//
//   CupertinoPicker iOSPicker() {
//     List<Text> iosCurrency = [];
//     for (String i in currenciesList) {
//       iosCurrency.add(Text(i));
//     }
//
//     return CupertinoPicker(
//       onSelectedItemChanged: (value) {
//         setState(() {
//           dropDownListValue = currenciesList[value];
//           getData();
//         });
//       },
//       itemExtent: 42,
//       children: iosCurrency,
//     );
//   }
//
//   Widget? platformSelecter() {
//     if (Platform.isIOS) {
//       return iOSPicker();
//     } else if (Platform.isAndroid) {
//       return androidPicker();
//     }
//   }
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     getData();
//   }
//
//   bool isWaiting = false;
//   void getData() async {
//     try {
//       isWaiting = true;
//       CoinData coinData = CoinData();
//       double rate = await coinData.getCoinData(dropDownListValue, value);
//       isWaiting = false;
//       setState(() {
//         data = rate.toStringAsFixed(1);
//       });
//     } catch (e) {
//       print(e);
//     }
//   }
//
//   Column makeCards() {
//     List<CurrencyCoinCard> cryptoCards = [];
//     for (String crypto in cryptoList) {
//       cryptoCards.add(
//         CurrencyCoinCard(
//           data: data,
//           dropDownListValue: dropDownListValue,
//           cryptoListValue: isWaiting ? '?' : crypto,
//         ),
//       );
//     }
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       children: cryptoCards,
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('🤑 Coin Ticker'),
//         centerTitle: true,
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: <Widget>[
//           makeCards(),
//           Container(
//             height: 150.0,
//             alignment: Alignment.center,
//             padding: EdgeInsets.only(bottom: 30.0),
//             color: Colors.lightBlue,
//             child: platformSelecter(),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class CurrencyCoinCard extends StatelessWidget {
//   const CurrencyCoinCard({
//     Key? key,
//     required this.data,
//     required this.dropDownListValue,
//     required this.cryptoListValue,
//   }) : super(key: key);
//
//   final String data;
//   final String dropDownListValue;
//   final String cryptoListValue;
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
//       child: Card(
//         color: Colors.lightBlueAccent,
//         elevation: 5.0,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(10.0),
//         ),
//         child: Padding(
//           padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
//           child: Text(
//             '1 $cryptoListValue = $data $dropDownListValue',
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               fontSize: 20.0,
//               color: Colors.white,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
//
//
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
// const apiKey = "FDA8C205-99C2-4DEB-9A56-07E4B1B66307";
// const adress = "https://rest.coinapi.io/v1/exchangerate";
// const List<String> currenciesList = [
//   'AUD',
//   'BRL',
//   'CAD',
//   'CNY',
//   'EUR',
//   'GBP',
//   'HKD',
//   'IDR',
//   'ILS',
//   'INR',
//   'JPY',
//   'MXN',
//   'NOK',
//   'NZD',
//   'PLN',
//   'RON',
//   'RUB',
//   'SEK',
//   'SGD',
//   'USD',
//   'ZAR'
// ];
// const List<String> cryptoList = [
//   'BTC',
//   'ETH',
//   'LTC',
// ];
//
// class CoinData {
//   Future getCoinData(String currency, String value) async {
//     String api = "$adress/$value/$currency?apikey=$apiKey";
//     http.Response response = await http.get(
//       Uri.parse(api),
//     );
//     if (response.statusCode == 200) {
//       String jsonData = await response.body;
//       var data = await jsonDecode(jsonData)['rate'];
//       print(data);
//       return data;
//     } else {
//       print(response.statusCode);
//     }
//   }
// }
//
