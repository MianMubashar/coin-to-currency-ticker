import 'package:crypto_tracker/coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String dropDownListValue = 'USD';

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
          getData();
        });
      },
    );
  }

  CupertinoPicker iOSPicker() {
    List<Text> iosCurrency = [];
    for (String i in currenciesList) {
      iosCurrency.add(Text(i));
    }

    return CupertinoPicker(
      onSelectedItemChanged: (value) {
        setState(() {
          dropDownListValue = currenciesList[value];
          getData();
        });
      },
      itemExtent: 42,
      children: iosCurrency,
    );
  }

  Widget? platformSelecter() {
    if (Platform.isIOS) {
      return iOSPicker();
    } else if (Platform.isAndroid) {
      return androidPicker();
    }
  }

  Map<String, String> cryptoValues = {};
  bool isWaiting = false;
  void getData() async {
    isWaiting = true;
    try {
      var rate = await CoinData().getCoinData(dropDownListValue);
      isWaiting = false;
      setState(() {
        cryptoValues = rate;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  Column makeCards() {
    List<CurrencyCoinCard> card = [];
    for (String crypto in cryptoList) {
      card.add(CurrencyCoinCard(
        cryptoListValue: crypto,
        dropDownListValue: dropDownListValue,
        data: isWaiting ? '?' : cryptoValues[crypto],
      ));
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: card,
    );
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
          makeCards(),
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

class CurrencyCoinCard extends StatelessWidget {
  const CurrencyCoinCard({
    Key? key,
    this.dropDownListValue,
    this.cryptoListValue,
    this.data,
  }) : super(key: key);

  final String? data;
  final String? dropDownListValue;
  final String? cryptoListValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
            '1 $cryptoListValue = $data $dropDownListValue',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
