import 'package:http/http.dart' as http;
import 'dart:convert';

class DataService {
  static final String _apiKey = '7c5127495be040c4b00f56851450989f';
  static const String _baseUrl = 'https://newsapi.org/v2';

  final List<Map<String, Object>> objects;

  const DataService({this.objects = const []});

  Future<void> fetchNewsPappers() async {
    final response = await http.get(
      Uri.parse('$_baseUrl/everything?q=technology&apiKey=$_apiKey'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      // ignore: avoid_print
      print(data['totalResults']);
    }
  }
}
