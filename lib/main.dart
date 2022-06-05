import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'joke.dart';

Future<Joke> newJoke() async {
  final newJoke =
      await http.get(Uri.parse('https://api.chucknorris.io/jokes/random'));
  if (newJoke.statusCode == 200) {
    return Joke.fromJson(jsonDecode(newJoke.body));
  } else {
    throw Exception("Chuck made a mistake and don't want to make fun for you");
  }
}

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  static const String _title = 'Funny Chuck';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      home: MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  late Future<Joke> joke;

  void getNewJoke() {
    joke = newJoke();
    joke.then((joke) => setState(() {}));
  }

  @override
  void initState() {
    super.initState();
    getNewJoke();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Funny Chuck :)'),
          backgroundColor: Colors.orange,
        ),
        body: GestureDetector(
          onHorizontalDragUpdate: (details) {
            if (details.delta.dx > 10) {
              getNewJoke();
            }
            if (details.delta.dx < -10) {
              getNewJoke();
            }
          },
          child: Center(
              child: SafeArea(
                  left: true,
                  top: true,
                  right: true,
                  bottom: true,
                  minimum: const EdgeInsets.all(10.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                            padding: const EdgeInsets.fromLTRB(
                                20.0, 30.0, 20.0, 30.0),
                            child: FutureBuilder<Joke>(
                              future: joke,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Text(snapshot.data!.value,
                                      textAlign: TextAlign.justify,
                                      style: const TextStyle(fontSize: 20));
                                }
                                return const CircularProgressIndicator();
                              },
                            )),
                        FloatingActionButton.extended(
                          focusColor: Colors.black,
                          backgroundColor: Colors.orange,
                          elevation: 10,
                          onPressed: getNewJoke,
                          label: const Text("Nice, next",
                              style: TextStyle(
                                  fontSize: 20, decorationColor: Colors.black)),
                        ),
                      ]))),
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
}

class BottomBarScreen extends StatefulWidget {
  const BottomBarScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MyBottomBarScreenState();
  }
}

class MyBottomBarScreenState extends State<BottomBarScreen> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _widgetOptions = <Widget>[
    const Text(
      'Index 0: Joke',
      style: optionStyle,
    ),
    const Text(
      'Index 1: Favorite',
      style: optionStyle,
    ),
    const Text(
      'Index 2: Contacts',
      style: optionStyle,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BottomNavigationBar Sample'),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Business',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'School',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
