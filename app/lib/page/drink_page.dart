import 'package:drinky/model/drink.dart';
import 'package:drinky/widget/search_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'drink_detail_page.dart';

class DrinkPage extends StatefulWidget {
  final List<Drink> drinks;

  const DrinkPage({
    Key? key,
    this.drinks = const [],
  }) : super(key: key);

  @override
  _DrinkPageState createState() => _DrinkPageState();
}

class _DrinkPageState extends State<DrinkPage> {
  var res;
  late List<Drink> allDrinks;
  String text = '';

  @override
  void initState() {
    super.initState();
    allDrinks = [];
    fetchData();
  }

  bool containsSearchText(Drink drink) {
    final name = drink.name;
    final textLower = text.toLowerCase();
    final drinkLower = name.toLowerCase();

    return drinkLower.contains(textLower);
  }

  fetchData() async {
    res = await rootBundle.loadString('assets/drink_codes.json');
    allDrinks = drinksFromJson(res);
    allDrinks.sort((a, b) => a.name.compareTo(b.name));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    fetchData();
    final drinks = allDrinks.where(containsSearchText).toList();
    final style = TextStyle(fontSize: 16);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: buildAppBar(),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              children: drinks.map((drink) {

                return GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DrinkDetailPage(drink: drink)),
                  ),
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
                                    'assets/images/drinks/' + drink.name + '.png',
                                    height: 120,
                                    width: 80,
                                    fit: BoxFit.contain
                                ),
                                ListTile(
                                  onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            DrinkDetailPage(drink: drink)),
                                  ),
                                  //leading:
                                  title: Text(
                                    drink.name,
                                    style: style,
                                  ),
                                  trailing: Icon(Icons.arrow_forward_outlined),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                );}).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildAppBar() {
    return AppBar(
      title: Text('Seleziona Drink'),
      backgroundColor: Color.fromRGBO(103, 185, 220, 1.0),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: SearchWidget(
          text: text,
          onChanged: (text) => setState(() => this.text = text),
          hintText: 'Cerca Drink'
        ),
      ),
    );
  }
}