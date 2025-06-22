import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import './service/service.dart';
import './styles/theme.dart';
import './pages/home.dart';
import './pages/notices.dart';
import './interface/article.dart';

void main() {
  runApp(MyApp());
}

// ignore: use_key_in_widget_constructors
class MyApp extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final articlesHome = useState<List<Article>>([]);
    final articlesNotices = useState<List<Article>>([]);

    Future<void> fetchArticles({
      required ValueNotifier<List<Article>> target,
      String filter = '',
    }) async {
      try {
        final data = await DataService().loadArticles(
          page: 1,
          pageSize: 5,
          filter: filter,
        );
        target.value = data;
      } catch (e) {
        print('Erro ao carregar artigos: $e');
      }
    }

    useEffect(() {
      fetchArticles(target: articlesHome, filter: "technology");
      fetchArticles(target: articlesNotices);
      return null;
    }, []);

    return MaterialApp(
      theme: MyTheme().themeDefault(),
      initialRoute: '/home',
      routes: {
        '/home': (context) => Home(articlesTechnology: articlesHome),
        '/notices': (context) => NoticesPages(articles: articlesNotices),
      },
    );
  }
}
