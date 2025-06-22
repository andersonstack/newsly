import 'package:flutter/material.dart';
import '../components/card.dart';
import '../interface/article.dart';

class NoticesPages extends StatelessWidget {
  final ValueNotifier<List<Map<String, dynamic>>> articles;

  const NoticesPages({super.key, required this.articles});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Today's News")),
      body: articles.value.isNotEmpty
          ? ListView.builder(
              itemCount: articles.value.length,
              itemBuilder: (context, index) {
                final article = Article.fromJson(articles.value[index]);
                return CardArticle(article: article);
              },
            )
          : const Center(child: Text("Sem notícias")),
    );
  }
}
