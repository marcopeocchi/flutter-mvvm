import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'quote.g.dart';

// Modello

@JsonSerializable()
class Quote extends Equatable {
  final String? quote;

  const Quote({this.quote});

  factory Quote.empty() => const Quote();

  factory Quote.fromJson(Map<String, dynamic> json) => _$QuoteFromJson(json);
  Map<String, dynamic> toJson() => _$QuoteToJson(this);

  @override
  List<Object?> get props => [quote];

  bool get isEmpty => this == Quote.empty();
  bool get isNotEmpty => this != Quote.empty();
}
