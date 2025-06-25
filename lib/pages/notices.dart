import 'package:flutter/material.dart';
import '../components/card.dart';
import '../interface/article.dart';
import '../components/text_btn.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../service/service.dart';

class NoticesPages extends HookWidget {
  final ValueNotifier<List<Article>> articles;

  NoticesPages({super.key, required this.articles});

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
    List<Article> currentArticles = useListenable(articles).value;
    final selectedFilter = useState<String>("");

    final isLoading = useState<bool>(false);
    final hasMore = useState<bool>(true);
    final scrollController = useScrollController();
    final page = useState<int>(1);

    void filterArticles(String filter) {
      selectedFilter.value = filter.toLowerCase();
      fetchArticles(target: articles, filter: selectedFilter.value);
    }

    void loadMores() async {
      if (isLoading.value || !hasMore.value) return;

      isLoading.value = true;
      try {
        final newItems = await DataService().loadArticles(
          page: page.value, // Use o valor do `useState` da página
          filter: selectedFilter.value,
        );

        if (newItems.isNotEmpty) {
          // ignore: avoid_print
          print("Carregando novas notícias");
          articles.value = [...articles.value, ...newItems];
          page.value += 1;
        } else {
          hasMore.value = false;
        }
      } catch (e) {
        // ignore: avoid_print
        print("Erro ao carregar mais dados $e");
        hasMore.value = false;
      } finally {
        isLoading.value = false;
      }
    }

    useEffect(() {
      void listenerScroll() {
        if (scrollController.position.pixels >=
                scrollController.position.maxScrollExtent * 0.25 &&
            !isLoading.value) {
          loadMores();
        }
      }

      scrollController.addListener(listenerScroll);

      return () {
        scrollController.removeListener(listenerScroll);
      };
    }, [scrollController]);

    return Scaffold(
      appBar: AppBar(title: const Text("Today's News")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 40,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: filters.length,
                itemBuilder: (context, index) {
                  final filter = filters[index];
                  return TextBtn(
                    text: filter,
                    function: () => filterArticles(filter),
                  );
                },
                separatorBuilder: (context, index) => SizedBox(width: 20),
              ),
            ),
          ),
          Expanded(
            child: currentArticles.isNotEmpty
                ? isMobile
                      ? ListView.builder(
                          controller: scrollController,
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
