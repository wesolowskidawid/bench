import 'dart:convert';
import 'package:bench/objects/Med.dart';
import 'package:http/http.dart' as http;

Future<Map<String, String>> fetchData(double weight, int id) async {
  final queryParameters = {
    'weight': weight.toString(),
    'id': id.toString(),
  };
  final body = json.encode(queryParameters);
  var url = Uri.http('192.168.0.157:7070', '/calc');

  var response = await http.post(url, body: body);

  if (response.statusCode == 200) {
    Map<String, dynamic> responseBody = json.decode(response.body);
    Map<String, String> result = {
      'weight': responseBody['weight'],
      'activesubstance': responseBody['activesubstance'],
      'meddose': responseBody['meddose'],
      'packagesize': responseBody['packagesize']
    };
    return result;
  }
  throw Exception('Failed to load data');
}

// Future<List<Med>> fetchMedList() async {
//   var client = http.Client();
//   var url = Uri.https('192.168.0.157:7070', '/meds');
//   var response = await client.get(url);
//   print('Response status: ${response.statusCode}');
//   print('Response body: ${response.body}');
//   if (response.statusCode == 200) {
//     var responseBody = json.decode(response.body);
//     return List<Med>.from(responseBody);
//   } else {
//     throw Exception('Failed to load data');
//   }
// }