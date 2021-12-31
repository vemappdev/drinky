import 'package:drinky/model/ingredient.dart';
import 'package:flutter/material.dart';

class IngredientListTileWidget extends StatelessWidget {
  final Ingredient ingredient;
  final bool isSelected;
  final ValueChanged<Ingredient> onSelectedIngredient;

  const IngredientListTileWidget({
    Key key,
    @required this.ingredient,
    @required this.isSelected,
    @required this.onSelectedIngredient,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectedColor = Theme.of(context).primaryColor;
    final style = isSelected
        ? TextStyle(
            fontSize: 18,
            color: selectedColor,
            fontWeight: FontWeight.bold,
          )
        : TextStyle(fontSize: 18);

    return GestureDetector(
      onTap: () => onSelectedIngredient(ingredient),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 2),
                    Image.asset(
                        'assets/images/bottles/' + ingredient.name + '.png',
                        height: 120, width: 80, fit: BoxFit.contain),
                    ListTile(
                      onTap: () => onSelectedIngredient(ingredient),
                      //leading:
                      title: Text(
                        ingredient.name,
                        style: style,
                      ),
                      trailing: isSelected
                          ? Icon(Icons.check, color: style.color)
                          : Icon(Icons.add),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
