// ignore: depend_on_referenced_packages
import 'package:connectivity_plus/connectivity_plus.dart';
// ignore: depend_on_referenced_packages
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
// ignore: depend_on_referenced_packages
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';
import 'favorite_page.dart';
import 'joke.dart';

FirebaseDatabase database = FirebaseDatabase.instance;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

Future<String?> connection() async {
  try {
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.mobile) {
      return ("Internet connection is from Mobile data");
    } else if (result == ConnectivityResult.wifi) {
      return ("internet connection is from wifi");
    } else if (result == ConnectivityResult.none) {
      return ("No internet connection");
    }
  } catch (e) {
    if (kDebugMode) {
      print(e);
      await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
    }
  }
  return null;
}

class HomePageState extends State<HomePage> {
  late Future<Joke> joke;
  late Future<String?> connected;

  void getNewJoke() {
    joke = newJoke();
    joke.then((joke) => setState(() {}));
  }

  @override
  void initState() {
    super.initState();
    connected = connection();
    getNewJoke();
  }

  void favoriteAdd() async {
    Joke likedjoke = await joke;
    setState(() {
      joke = newJoke();
      favorite.add(likedjoke.value);
      connected = connection();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox.expand(
          child: GestureDetector(
            onPanUpdate: (details) {
              if (details.delta.dx > 20) {
                getNewJoke();
              }
              if (details.delta.dx < -20) {
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
                          IconButton(
                              icon: const Icon(Icons.thumb_up_alt_rounded),
                              iconSize: 30.0,
                              onPressed: () => favoriteAdd()),
                          Container(
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                                colors: [
                                  Colors.blue,
                                  Colors.red,
                                ],
                              ),
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            child: FloatingActionButton.extended(
                              backgroundColor: Colors.transparent,
                              elevation: 10,
                              onPressed: getNewJoke,
                              label: const Text("Nice, next",
                                  style: TextStyle(
                                      fontSize: 20,
                                      decorationColor: Colors.black)),
                            ),
                          )
                        ]))),
          ),
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
