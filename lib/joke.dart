import 'package:json_annotation/json_annotation.dart';
part 'joke.g.dart';

@JsonSerializable()
class Joke {
  final String value;
  Joke(this.value);
  factory Joke.fromJson(Map<String, dynamic> json) => _$JokeFromJson(json);
  Map<String, dynamic> toJson() => _$JokeToJson(this);
}
