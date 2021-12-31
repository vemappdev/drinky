import 'package:drinky/model/ingredient.dart';

class Utils {
  static int ascendingSort(Ingredient c1, Ingredient c2) =>
      c1.name.compareTo(c2.name);
}
