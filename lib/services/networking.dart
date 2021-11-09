import 'package:http/http.dart' as http;
import 'dart:convert';

const apiKey = "FDA8C205-99C2-4DEB-9A56-07E4B1B66307";
const adress = "https://rest.coinapi.io/v1/exchangerate";

class Networking {
  Future networkData() async {
    String api = "$adress/BTC/USD?apikey=$apiKey";
    http.Response response = await http.get(Uri.parse(api));

    if (response.statusCode == 200) {
      String data = response.body;
      return await jsonDecode(data);
      print(response.body);
    } else {
      print(response.statusCode);
    }
  }
}
