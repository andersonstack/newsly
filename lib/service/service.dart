import 'package:http/http.dart' as http;
import 'dart:convert';
import '../interface/article.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DataService {
  final List<Map<String, Object>> objects;

  const DataService({this.objects = const []});

  Future<List<Map<String, dynamic>>> fetchNewsPappers({
    int page = 1,
    int pageSize = 5,
    String filter = "",
    String country = "us",
  }) async {
    var apiKey = dotenv.env['API_KEY'] ?? "";
    final queryParams = {
      'page': '$page',
      'pageSize': '$pageSize',
      'apiKey': apiKey,
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

Future<void> fetchArticles({
  required ValueNotifier<List<Article>> target,
  String filter = '',
  int pageSize = 5,
}) async {
  try {
    final data = await DataService().loadArticles(
      page: 1,
      pageSize: pageSize,
      filter: filter,
    );
    target.value = data;
  } catch (e) {
    // ignore: avoid_print
    print('Erro ao carregar artigos: $e');
  }
}
