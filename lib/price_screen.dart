import 'dart:io';

import 'package:bitcoin_ticker/coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String dropdownValue = "AUD";
  String btcExchangeRate = "";
  String ethExchangeRate = "";
  String ltcExchangeRate = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  CupertinoPicker getCupertinoDropDown() {
    List<Text> listItems = [];
    for (String item in currenciesList) {
      listItems.add(Text(item));
    }
    return CupertinoPicker(
      backgroundColor: Colors.blue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        dropdownValue = currenciesList[selectedIndex];
        setState(() {
          loadData();
        });
      },
      scrollController: FixedExtentScrollController(initialItem: 0),
      children: listItems,
    );
  }

  DropdownButton getDropDownButton() {
    return DropdownButton(
      value: dropdownValue,
      items: currenciesList.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          dropdownValue = value!;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CurrencyCard(
                btcExchangeRate: btcExchangeRate,
                dropdownValue: dropdownValue,
                currencyName: 'BTC',
              ),
              CurrencyCard(
                btcExchangeRate: ethExchangeRate,
                dropdownValue: dropdownValue,
                currencyName: 'ETH',
              ),
              CurrencyCard(
                btcExchangeRate: ltcExchangeRate,
                dropdownValue: dropdownValue,
                currencyName: 'LTC',
              ),
            ],
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isAndroid
                ? getDropDownButton()
                : getCupertinoDropDown(),
          ),
        ],
      ),
    );
  }

  void loadData() async {
    var coinData = await CoinData().getCoinExchangeRate(dropdownValue);
    print(coinData);
    setState(() {
      btcExchangeRate = coinData['BTC'].toStringAsFixed(2);
      ethExchangeRate = coinData['ETH'].toStringAsFixed(2);
      ltcExchangeRate = coinData['LTC'].toStringAsFixed(2);
    });
  }
}

class CurrencyCard extends StatelessWidget {
  const CurrencyCard({
    Key? key,
    required this.btcExchangeRate,
    required this.dropdownValue,
    required this.currencyName,
  }) : super(key: key);

  final String btcExchangeRate;
  final String dropdownValue;
  final String currencyName;

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
            '1 $currencyName = $btcExchangeRate $dropdownValue',
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
