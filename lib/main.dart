import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import './service/service.dart';
import './styles/theme.dart';
import './pages/home.dart';
import './pages/notices.dart';

void main() {
  runApp(MyApp());
}

// ignore: use_key_in_widget_constructors
class MyApp extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final articles = useState<List<Map<String, dynamic>>>([]);
    final isLoading = useState(true);
    final hasError = useState<String?>(null);

    useEffect(() {
      Future<void> fetchData() async {
        try {
          final data = await DataService().fetchNewsPappers();
          articles.value = data;
        } catch (e) {
          hasError.value = e.toString();
        } finally {
          isLoading.value = false;
        }
      }

      fetchData();
    }, []);

    return MaterialApp(
      theme: MyTheme().themeDefault(),
      initialRoute: '/home',
      routes: {
        '/home': (context) => Home(),
        '/notices': (context) => NoticesPages(articles: articles),
      },
    );
  }
}
