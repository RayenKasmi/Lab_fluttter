import 'package:json_annotation/json_annotation.dart';

part 'quote.g.dart';

@JsonSerializable()
class Quote {
  final String text;
  final String author;

  Quote({required this.text, required this.author});

  Quote.fromJSON(Map<String, dynamic> map) // MAP -> Object
      : text = map['q'] ?? '',
        author = map['a'] ?? '';

  factory Quote.fromJson(Map<String, dynamic> json) => Quote(
        text: json['q'] as String? ?? '',
        author: json['a'] as String? ?? '',
      );

  Map<String, dynamic> toJson() => _$QuoteToJson(this);
}
