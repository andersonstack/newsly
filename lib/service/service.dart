import 'package:http/http.dart' as http;
import 'dart:convert';
import '../interface/article.dart';

class DataService {
  static final String _apiKey = '7c5127495be040c4b00f56851450989f';

  final List<Map<String, Object>> objects;

  const DataService({this.objects = const []});

  Future<List<Map<String, dynamic>>> fetchNewsPappers({
    int page = 1,
    int pageSize = 5,
    String filter = "",
    String country = "us",
  }) async {
    final queryParams = {
      'page': '$page',
      'pageSize': '$pageSize',
      'apiKey': _apiKey,
      if (filter.isNotEmpty) 'category': filter,
      if (filter.isEmpty) 'country': country,
    };

    final uri = Uri.https('newsapi.org', '/v2/top-headlines', queryParams);

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return List<Map<String, dynamic>>.from(data['articles']);
    } else {
      throw Exception("Erro ao buscar notícias: ${response.statusCode}");
    }
  }

  Future<List<Article>> loadArticles({
    int page = 1,
    int pageSize = 5,
    String filter = "",
  }) async {
    final articlesData = await fetchNewsPappers(
      page: page,
      pageSize: pageSize,
      filter: filter,
    );
    return articlesData.map((json) => Article.fromJson(json)).toList();
  }
}
