import 'package:meta/meta.dart';

class Ingredient {
  final String name;
  final String code;
  final String img;
  final String descr;

  const Ingredient({
    @required this.name,
    @required this.code,
    @required this.img,
    @required this.descr,
  });

  factory Ingredient.fromJson(Map<String, dynamic> json) => Ingredient(
        name: json['name'],
        code: json['code'],
        img: json['img'],
        descr: json['descr'],
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Ingredient &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          code == other.code &&
          descr == other.descr &&
          img == other.img;

  @override
  int get hashCode => name.hashCode ^ code.hashCode ^ img.hashCode ^ descr.hashCode;
}
