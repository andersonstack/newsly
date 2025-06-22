import 'package:flutter/material.dart';
import '../components/card.dart';
import '../interface/article.dart';

class NoticesPages extends StatelessWidget {
  final ValueNotifier<List<Map<String, dynamic>>> articles;

  const NoticesPages({super.key, required this.articles});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 781;

    return Scaffold(
      appBar: AppBar(title: const Text("Today's News")),
      body: articles.value.isNotEmpty
          ? isMobile
                ? ListView.builder(
                    itemCount: articles.value.length,
                    itemBuilder: (context, index) {
                      final article = Article.fromJson(articles.value[index]);
                      return CardArticle(article: article);
                    },
                  )
                : GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: 3 / 3,
                        ),
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
