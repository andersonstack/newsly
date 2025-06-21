import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import './service/service.dart';

void main() {
  runApp(MyApp());
}

// ignore: use_key_in_widget_constructors
class MyApp extends HookWidget {
  @override
  Widget build(BuildContext context) {
    useEffect(() {
      DataService().fetchNewsPappers();
      return null;
    });

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Today's News")),
        body: Column(
          children: [
            TextField(decoration: InputDecoration(hintText: "Search Notice")),
            Row(
              children: [
                Text("Technology"),
                Text("Of the World"),
                Text("Movies"),
                Text("Series"),
              ],
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
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(
              icon: Icon(Icons.list_sharp),
              label: "Notices",
            ),
          ],
        ),
      ),
    );
  }
}
