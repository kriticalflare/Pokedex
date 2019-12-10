import 'dart:convert';

import 'package:http/http.dart' as http;
class NetworkHelper{
  final String apiUrl = 'https://pokemon-barath.herokuapp.com/pokemon/';

  Future<dynamic> getData(String requestType) async{
    http.Response response = await http.get('$apiUrl$requestType');
    if(response.statusCode == 200){
      var data = response.body.toString();
//      print(data);
      var decodedData = jsonDecode(data);
      return decodedData;
    } else {
//      print(response.statusCode);
    }
  }
}