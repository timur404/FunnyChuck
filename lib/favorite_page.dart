import 'package:flutter/material.dart';

Set<String> favorite = <String>{};

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  FavoritePageState createState() => FavoritePageState();
}

class FavoritePageState extends State<FavoritePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final favoriteSet = favorite.map(
      (pair) {
        return ListTile(
          title: Text(pair),
        );
      },
    );
    final divided = favoriteSet.isNotEmpty
        ? ListTile.divideTiles(
            context: context,
            tiles: favoriteSet,
          ).toList()
        : <Widget>[];

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          body: ListView(
        children: divided,
      )),
    );
  }
}
