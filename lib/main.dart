import 'package:flutter/material.dart';
import 'home_page.dart';
import 'favorite_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  static const String _title = 'Timur wants an interview at Yandex.Pro';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: _title,
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _index = 0;

  @override
  void initState() {
    super.initState();
    _index = 0;
  }

  void onChanged(int i) {
    setState(() {
      _index = i;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Timur wants to make you laugh'),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Colors.blue,
                Colors.red,
              ],
            )),
          ),
        ),
        body: _pages(_index),
        bottomNavigationBar: BottomMenu(
          page: _index,
          onChanged: onChanged,
        ),
        floatingActionButton: IconButton(
          icon: const Icon(Icons.info_outline_rounded),
          iconSize: 30.0,
          onPressed: () => showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: const Text('The developer'),
              content: const Text(
                  'Timur Kharin A.K.A. @tim404 from Innopolis University'),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'Good job'),
                  child: const Text('Good job'),
                ),
              ],
            ),
          ),
        ));
  }

  Widget _pages(int i) {
    switch (i) {
      case 0:
        return const HomePage();
      case 1:
        return const FavoritePage();
    }
    throw Exception('Unknown page');
  }
}

class BottomMenu extends StatelessWidget {
  final int page;
  final ValueChanged<int>? onChanged;

  const BottomMenu({
    Key? key,
    required this.page,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: page,
      onTap: onChanged,
      items: const [
        BottomNavigationBarItem(
            icon: Icon(
              Icons.mail_rounded,
              color: Colors.blue,
            ),
            label: 'Main'),
        BottomNavigationBarItem(
            icon: Icon(Icons.favorite_rounded, color: Colors.redAccent),
            label: 'Favourite'),
      ],
    );
  }
}
