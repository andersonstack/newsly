import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../interface/article.dart';
import '../components/card.dart';
import '../service/service.dart';

class Home extends HookWidget {
  final ValueNotifier<List<Article>> articlesTechnology;

  const Home({super.key, required this.articlesTechnology});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth <= 600;
    final screenHeight = MediaQuery.of(context).size.height;
    final currentIndex = useState(0);
    final searchNotice = useState<String>("");

    final List<Article> articles = useListenable(articlesTechnology).value;

    void filterArticles(String search) {
      if (search.isNotEmpty) {
        fetchArticles(target: articlesTechnology, pageSize: 100);
      } else {
        fetchArticles(
          target: articlesTechnology,
          pageSize: 10,
          filter: "technology",
        );
      }
    }

    final List<Article> filteredArticles = searchNotice.value.isEmpty
        ? articles
        : articles
              .where(
                (article) => article.titleArticle.toLowerCase().contains(
                  searchNotice.value.toLowerCase(),
                ),
              )
              .toList();

    return Scaffold(
      appBar: AppBar(title: const Text("Today's News")),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search Notice",
                suffixIcon: Icon(Icons.search),
                hintMaxLines: 2,
              ),
              onChanged: (value) {
                searchNotice.value = value;
                filterArticles(value);

                if (searchNotice.value.isEmpty) {
                  filterArticles(value);
                }
              },
            ),
          ),
          searchNotice.value.isEmpty
              ? articles.isEmpty
                    ? CircularProgressIndicator()
                    : isMobile
                    ? HomeMobile(
                        articles: articles,
                        screenHeight: screenHeight,
                        screenWidth: screenWidth,
                      )
                    : HomeDesktop(
                        articles: articles,
                        screenHeight: screenHeight,
                        screenWidth: screenWidth,
                      )
              : Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(8.0),
                    itemCount: filteredArticles.length,
                    itemBuilder: (context, index) {
                      return CardArticle(article: filteredArticles[index]);
                    },
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

class HomeMobile extends HookWidget {
  final List<Article> articles;
  final double screenHeight;
  final double screenWidth;

  const HomeMobile({
    super.key,
    required this.articles,
    required this.screenHeight,
    required this.screenWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        children: [
          Positioned(
            child: Image.network(articles[0].urlToImage, fit: BoxFit.cover),
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
    );
  }
}

class HomeDesktop extends HookWidget {
  final List<Article> articles;
  final double screenHeight;
  final double screenWidth;

  const HomeDesktop({
    super.key,
    required this.articles,
    required this.screenHeight,
    required this.screenWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Imagem em destaque
          SizedBox(
            width: screenWidth * 0.5,
            height: double.infinity,
            child: Image.network(articles[0].urlToImage, fit: BoxFit.cover),
          ),

          // Coluna de título + lista
          Expanded(
            child: Column(
              children: [
                // Texto de destaque
                Container(
                  height: screenHeight * 0.07,
                  width: double.infinity,
                  alignment: Alignment.center,
                  color: const Color(0xFF0077CC),
                  child: Text(
                    "Follow the latest technology news",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                // Lista de artigos
                Expanded(
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
