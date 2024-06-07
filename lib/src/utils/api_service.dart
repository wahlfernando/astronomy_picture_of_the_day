import 'dart:convert';
import 'package:http/http.dart' as http;

class APIService {
  static const String baseURL = 'https://api.nasa.gov/planetary/apod';
  static const String apiKey = '3pwwhkdFsWE9S2Tn0y9RdLCBPtdLUGQiIdXEt0gs';

  Future<Map<String, dynamic>> fetchAPOD(String date) async {
    final response = await http.get(Uri.parse('$baseURL?api_key=$apiKey&date=$date'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load APOD');
    }
  }
}
