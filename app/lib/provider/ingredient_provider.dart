import 'dart:convert';

import 'package:drinky/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:drinky/model/ingredient.dart';
import 'package:flutter/services.dart';

class IngredientProvider with ChangeNotifier {
  IngredientProvider() {
    loadIngredients().then((ingredients) {
      _ingredients = ingredients;
      notifyListeners();
    });
  }

  List<Ingredient> _ingredients = [];

  List<Ingredient> get ingredients => _ingredients;

  Future loadIngredients() async {
    final data = await rootBundle.loadString('assets/ingredient_codes.json');
    final ingredientsJson = json.decode(data);

    return ingredientsJson.keys.map<Ingredient>((code) {
      final json = ingredientsJson[code];
      final newJson = json..addAll({'code': code.toLowerCase()});

      return Ingredient.fromJson(newJson);
    }).toList()
      ..sort(Utils.ascendingSort);
  }
}
