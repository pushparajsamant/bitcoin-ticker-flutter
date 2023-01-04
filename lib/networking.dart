import 'dart:convert';

import 'package:http/http.dart' as http;

class NetworkHelper {
  final String apiURL;
  NetworkHelper({required this.apiURL});

  Future<dynamic> getData() async {
    Uri uri = Uri.parse(apiURL);
    var result = await http.get(uri);
    if (result.statusCode == 200) {
      var data = jsonDecode(result.body);
      return data;
    } else {
      print(result);
      return null;
    }
  }
}
