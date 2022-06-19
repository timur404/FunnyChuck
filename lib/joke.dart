// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';
// ignore_for_file: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'dart:convert';
part 'joke.g.dart';

@JsonSerializable()
class Joke {
  final String value;
  Joke(this.value);
  factory Joke.fromJson(Map<String, dynamic> json) => _$JokeFromJson(json);
  Map<String, dynamic> toJson() => _$JokeToJson(this);
}

Future<Joke> newJoke() async {
  final newJoke =
      await http.get(Uri.parse('https://api.chucknorris.io/jokes/random'));
  if (newJoke.statusCode == 200) {
    return Joke.fromJson(jsonDecode(newJoke.body));
  } else {
    throw Exception("Chuck made a mistake and don't want to make fun for you");
  }
}
