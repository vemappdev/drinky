import 'dart:convert';

import 'package:meta/meta.dart';

List<Drink> drinksFromJson(String str) => List<Drink>.from(json.decode(str).map((x) => Drink.fromJson(x)));

class Drink {
  final String name;
  final String category;
  final String story;
  final String doses;
  final String img;
  final List<dynamic> codes;
  final String code;
  final String ingredients;
  final String preparation;

  const Drink({
    @required this.name,
    @required this.category,
    @required this.story,
    @required this.doses,
    @required this.img,
    @required this.codes,
    @required this.code,
    @required this.ingredients,
    @required this.preparation,
  });

  factory Drink.fromJson(Map<String, dynamic> json) => Drink(
    name: json['name'],
    img: json['img'],
    codes: json['codes'],
    code: json['code'],
    category: json['category'],
    story: json['story'],
    doses: json['doses'],
    ingredients: json['ingredients'],
    preparation: json['preparation'],
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Drink &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          category == other.category &&
          story == other.story &&
          doses == other.doses &&
          ingredients == other.ingredients &&
          preparation == other.preparation &&
          img == other.img &&
          code == other.code &&
          codes == other.codes;

  @override
  int get hashCode => name.hashCode ^ preparation.hashCode ^ category.hashCode ^ ingredients.hashCode ^ story.hashCode ^ doses.hashCode ^ img.hashCode ^ codes.hashCode ^ code.hashCode;
}
