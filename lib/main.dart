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
    ValueNotifier<List<Article>> articles = ValueNotifier([]);

    useEffect(() {
      Future<void> fetchData() async {
        try {
          final data = await DataService().loadArticles(page: 1);
          articles.value = data;
        } catch (e) {
          // ignore: avoid_print
          print("Erro ao carregar artigos iniciais: $e");
        }
      }

      fetchData();
    });

    return MaterialApp(
      theme: MyTheme().themeDefault(),
      initialRoute: '/home',
      routes: {
        '/home': (context) => Home(articlesTechnology: articles),
        '/notices': (context) => NoticesPages(articles: articles),
      },
    );
  }
}
