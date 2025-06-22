import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../interface/article.dart';
import 'package:url_launcher/url_launcher.dart';

// final String editora;
// final String titleArticle;
// final String autor;
// final String description;
// final String urlToNotice;
// final String urlToImage;
// final String datePublished;
// final String content;

class CardArticle extends HookWidget {
  final Article article;

  const CardArticle({super.key, required this.article});

  Future<void> _launchURL(String url) async {
    if (!await canLaunchUrl(Uri.parse(url))) {
      throw 'Não foi possível abrir $url';
    }
    await launchUrl(Uri.parse(url));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        spacing: 10,
        children: [
          Text(
            article.titleArticle,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Image.network(article.urlToImage),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                article.editora,
                style: Theme.of(context).textTheme.labelMedium,
              ),
              Text(
                article.datePublished,
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ],
          ),
          Text(article.autor, style: Theme.of(context).textTheme.labelLarge),
          Text(
            article.description,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          Text(article.content, style: Theme.of(context).textTheme.bodySmall),
          ElevatedButton.icon(
            onPressed: () => _launchURL(article.urlToNotice),
            icon: const Icon(Icons.link),
            label: Text(
              'Ler notícia completa',
              style: Theme.of(context).textTheme.labelSmall,
            ),
          ),
        ],
      ),
    );
  }
}
