import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../interface/article.dart';
import '../components/card.dart';

class Home extends HookWidget {
  final ValueNotifier<List<Map<String, dynamic>>> articlesTechnology;

  const Home({super.key, required this.articlesTechnology});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final currentIndex = useState(0);

    final List<Map<String, dynamic>> articlesMap = articlesTechnology.value;
    final List<Article> articles = articlesMap
        .map((e) => Article.fromJson(e))
        .toList();

    return Scaffold(
      appBar: AppBar(title: const Text("Today's News")),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search Notice",
                suffixIcon: Icon(Icons.search),
                hintMaxLines: 2,
              ),
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                Positioned(
                  child: Image.network(
                    articles[0].urlToImage,
                    fit: BoxFit.cover,
                  ),
                ),

                // Lista de artigos
                Positioned(
                  top: screenHeight * 0.32,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: ListView.builder(
                    padding: const EdgeInsets.all(8.0),
                    itemCount: articles.length,
                    itemBuilder: (context, index) {
                      if (index != 0) {
                        return CardArticle(article: articles[index]);
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ),

                // Texto sobreposto em destaque
                Positioned(
                  top: screenHeight * 0.27,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: screenHeight * 0.05,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(color: Color(0xFF0077CC)),
                    child: Text(
                      "Follow the latest technology news",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex.value,
        onTap: (index) {
          currentIndex.value = index;
          if (index == 1) {
            Navigator.pushNamed(context, '/notices');
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_sharp),
            label: "Notices",
          ),
        ],
      ),
    );
  }
}
