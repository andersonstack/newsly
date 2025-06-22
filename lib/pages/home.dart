import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../components/text_btn.dart';

class Home extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final List<String> filters = [
      'Technology',
      'Of the World',
      'Movies',
      'Series',
    ];
    final currentIndex = useState(0); // controla o botão ativo

    return Scaffold(
      appBar: AppBar(title: const Text("Today's News")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: const TextField(
              decoration: InputDecoration(
                hintText: "Search Notice",
                suffixIcon: Icon(Icons.search),
                hintMaxLines: 2,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: filters.map((btn) => TextBtn(text: btn)).toList(),
            ),
          ),
          Container(width: double.infinity, height: 500, color: Colors.amber),
          Row(
            children: [
              Container(
                width: 400,
                height: 300,
                color: const Color.fromARGB(255, 255, 38, 0),
              ),
              Container(
                width: 150,
                height: 200,
                color: const Color.fromARGB(255, 15, 0, 223),
              ),
            ],
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
