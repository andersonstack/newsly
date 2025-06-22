import 'package:flutter/material.dart';
import '../components/card.dart';
import '../interface/article.dart';
import '../components/text_btn.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class NoticesPages extends HookWidget {
  final ValueNotifier<List<Article>> articles;

  const NoticesPages({super.key, required this.articles});

  @override
  Widget build(BuildContext context) {
    final List<String> filters = [
      'Technology',
      'Business',
      'Science',
      'Entertainment',
    ];
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 781;
    final currentArticles = useListenable(articles).value;

    return Scaffold(
      appBar: AppBar(title: const Text("Today's News")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: filters.map((btn) => TextBtn(text: btn)).toList(),
            ),
          ),
          Expanded(
            child: currentArticles.isNotEmpty
                ? isMobile
                      ? ListView.builder(
                          itemCount: articles.value.length,
                          itemBuilder: (context, index) {
                            final article = articles.value[index];
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
                            final article = articles.value[index];
                            return CardArticle(article: article);
                          },
                        )
                : const LinearProgressIndicator(),
          ),
        ],
      ),
    );
  }
}
