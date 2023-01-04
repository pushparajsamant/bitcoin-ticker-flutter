import 'package:bitcoin_ticker/networking.dart';

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

const apiKey = '';
const baseAPIURL = 'https://rest.coinapi.io/v1/exchangerate';

class CoinData {
  Future<dynamic> getCoinExchangeRate(String currency) async {
    var coinMap = new Map<String, double>();
    for (String crypto in cryptoList) {
      NetworkHelper networkHelper =
          NetworkHelper(apiURL: '$baseAPIURL/$crypto/$currency?apikey=$apiKey');
      var coinData = await networkHelper.getData();
      print(coinData);
      coinMap[coinData['asset_id_base']] = coinData['rate'];
    }
    print(coinMap);
    return coinMap;
  }
}
