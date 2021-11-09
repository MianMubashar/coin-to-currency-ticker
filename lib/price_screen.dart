import 'package:crypto_tracker/coin_data.dart';
import 'package:crypto_tracker/services/crypto.dart';
import 'package:crypto_tracker/services/networking.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  DropdownButton androidPicker() {
    List<String> currency = currenciesList;
    List<DropdownMenuItem<String>> dropDownItems = [];
    for (int i = 0; i < currency.length; i++) {
      var menu = DropdownMenuItem(
        child: Text(currency[i]),
        value: currency[i],
      );
      dropDownItems.add(menu);
    }
    return DropdownButton<String>(
      value: dropDownListValue,
      items: dropDownItems,
      onChanged: (value) {
        setState(() {
          dropDownListValue = value!;
        });
      },
    );
  }

  CupertinoPicker iOSPicker() {
    List<Text> list = [];
    for (String i in currenciesList) {
      list.add(Text(i));
    }

    return CupertinoPicker(
      onSelectedItemChanged: (value) {
        print(value);
      },
      itemExtent: 42,
      children: list,
    );
  }

  Widget? platformSelecter() {
    if (Platform.isIOS) {
      return iOSPicker();
    } else if (Platform.isAndroid) {
      return androidPicker();
    }
  }

  String dropDownListValue = 'USD';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  void getData() {
    Networking().networkData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC = ? USD',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: platformSelecter(),
          ),
        ],
      ),
    );
  }
}
