import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../interface/article.dart';
import 'package:url_launcher/url_launcher.dart';

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
    final screenSize = MediaQuery.of(context).size;
    final isWide = screenSize.width >= 781;

    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Título
            Text(
              article.titleArticle,
              style: Theme.of(context).textTheme.titleMedium,
              maxLines: isWide ? null : 2,
              overflow: isWide ? TextOverflow.visible : TextOverflow.ellipsis,
            ),

            // Imagem
            if (article.urlToImage.isNotEmpty)
              AspectRatio(
                aspectRatio: 16 / 9,
                child: Image.network(
                  article.urlToImage,
                  width: double.infinity,
                  fit: BoxFit.contain,
                ),
              ),

            // Editora e data
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
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

            // Autor
            Text(article.autor, style: Theme.of(context).textTheme.labelLarge),

            // Descrição
            Text(
              article.description,
              style: Theme.of(context).textTheme.bodyMedium,
              maxLines: isWide ? null : 3,
              overflow: isWide ? TextOverflow.visible : TextOverflow.ellipsis,
            ),

            // Conteúdo
            Text(
              article.content,
              style: Theme.of(context).textTheme.bodySmall,
              maxLines: isWide ? null : 4,
              overflow: isWide ? TextOverflow.visible : TextOverflow.ellipsis,
            ),

            SizedBox(height: 15),
            // Botão
            Align(
              alignment: Alignment.centerLeft,
              child: ElevatedButton.icon(
                onPressed: () => _launchURL(article.urlToNotice),
                icon: const Icon(Icons.link),
                label: const Text("Ler notícia completa"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
