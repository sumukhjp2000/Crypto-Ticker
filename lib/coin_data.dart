import 'dart:convert';
import 'package:http/http.dart' as http;

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

const coinAPIURL = 'https://rest.coinapi.io/v1/exchangerate';
const apiKey = 'API KEY'; //699a85d77e6ac23289adcb7a9e53701d

class CoinData {
  Future getCoinData(String selectedCurrency) async {
    var cryMap = Map();
    // 4: Use a for loop here to loop through the cryptoList and request the data for each of them in turn.
    // 5: Return a Map of the results instead of a single value.
    for (String crypto in cryptoList) {
      String requestURL = '$coinAPIURL/$crypto/$selectedCurrency?apikey=$apiKey';
      http.Response response = await http.get(requestURL);
      if (response.statusCode == 200) {
        var decodedData = jsonDecode(response.body);
        var lastPrice = decodedData['rate'];
        cryMap[crypto] = lastPrice;

      } else {
        print(response.statusCode);
        throw 'Problem with the get request';
      }
    }
    return cryMap;
  }
}
