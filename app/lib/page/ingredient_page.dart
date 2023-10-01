import 'package:drinky/model/ingredient.dart';
import 'package:drinky/provider/ingredient_provider.dart';
import 'package:drinky/utils.dart';
import 'package:drinky/widget/ingredient_listtile_widget.dart';
import 'package:drinky/widget/search_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'drink_list_page.dart';

class IngredientPage extends StatefulWidget {
  final bool isMultiSelection;
  final List<Ingredient> ingredients;

  const IngredientPage({
    Key? key,
    this.isMultiSelection = false,
    this.ingredients = const [],
  }) : super(key: key);

  @override
  _IngredientPageState createState() => _IngredientPageState();
}

class _IngredientPageState extends State<IngredientPage> {
  String text = '';
  List<Ingredient> selectedIngredients = [];

  @override
  void initState() {
    super.initState();

    selectedIngredients = widget.ingredients;
  }

  bool containsSearchText(Ingredient ingredient) {
    final name = ingredient.name;
    final textLower = text.toLowerCase();
    final ingredientLower = name.toLowerCase();

    return ingredientLower.contains(textLower);
  }

  List<Ingredient> getPrioritizedIngredients(List<Ingredient> ingredients) {
    final notSelectedIngredients = List.of(ingredients)
      ..removeWhere((ingredient) => selectedIngredients.contains(ingredient));

    return [
      ...List.of(selectedIngredients)..sort(Utils.ascendingSort),
      ...notSelectedIngredients,
    ];
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<IngredientProvider>(context);
    final allIngredients = getPrioritizedIngredients(provider.ingredients);
    final ingredients = allIngredients.where(containsSearchText).toList();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: buildAppBar(),
      ),
      body: Column(
        children: <Widget>[
          const SizedBox(height: 10),
          buildRowScrollableIngredientList(),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              children: ingredients.map((ingredient) {
                final isSelected = selectedIngredients.contains(ingredient);

                return IngredientListTileWidget(
                  ingredient: ingredient,
                  isSelected: isSelected,
                  onSelectedIngredient: selectIngredient
                );
              }).toList(),
            ),
          ),
          buildSelectButton(context),
        ],
      ),
    );
  }

  Widget buildAppBar() {
    return AppBar(
      title: Text('Seleziona Ingredienti'),
      backgroundColor: Color.fromRGBO(103, 185, 220, 1.0),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: SearchWidget(
          text: text,
          onChanged: (text) => setState(() => this.text = text),
          hintText: 'Cerca Ingredienti'
        ),
      ),
    );
  }

  Widget buildRowScrollableIngredientList() {
    if (selectedIngredients.length > 0) {
      return new Padding(
          padding: EdgeInsets.all(8),
          child: Container(
              height: 50.0,
              child: new ListView(
                scrollDirection: Axis.horizontal,
                children:
                    new List.generate(selectedIngredients.length, (int index) {
                  return ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: 50,
                    ),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          new Text(selectedIngredients.elementAt(index).name),
                          IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () => {
                                    selectIngredient(
                                        selectedIngredients.elementAt(index))
                                  })
                        ]),
                  );
                }),
              )));
    } else {
      return SizedBox(height: 1);
    }
  }

  Widget buildSelectButton(BuildContext context) {
    final label = selectedIngredients.length == 0
        ? 'Seleziona Ingredienti'
        : (selectedIngredients.length == 1
            ? 'Continua con ${selectedIngredients.length} ingrediente'
            : 'Continua con ${selectedIngredients.length} ingredienti');

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
      color: Color.fromRGBO(103, 185, 220, 1.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: StadiumBorder(),
          minimumSize: Size.fromHeight(40),
          backgroundColor: Colors.white,
        ),
        child: Text(
          label,
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
        onPressed: () {
          if (selectedIngredients.length == 0) {
            final snackBar = SnackBar(
              content: const Text('Seleziona almeno un ingrediente!'),
              action: SnackBarAction(
                label: 'Indietro',
                onPressed: () {
                  // Some code to undo the change.
                },
              ),
            );
            // Find the ScaffoldMessenger in the widget tree
            // and use it to show a SnackBar.
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    DrinkListPage(selectedIngredients: selectedIngredients),
              ),
            );
          }
        },
      ),
    );
  }

  void selectIngredient(Ingredient ingredient) {
    if (widget.isMultiSelection) {
      final isSelected = selectedIngredients.contains(ingredient);
      setState(() => isSelected
          ? selectedIngredients.remove(ingredient)
          : selectedIngredients.add(ingredient));
    } else {
      Navigator.pop(context, ingredient);
    }
  }
}
