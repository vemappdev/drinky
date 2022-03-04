import 'dart:math';

import 'package:drinky/model/ingredient.dart';
import 'package:drinky/page/drink_page.dart';
import 'package:drinky/page/ingredient_page.dart';
import 'package:drinky/page/drink_detail_page.dart';
import 'package:drinky/provider/ingredient_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'model/drink.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final String title = 'Drinky';

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => IngredientProvider(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: title,
          theme: ThemeData(
              scaffoldBackgroundColor: Colors.white,
              primaryColor: Color.fromRGBO(103, 185, 220, 1.0),
              appBarTheme: AppBarTheme(
                  iconTheme: IconThemeData(color: Colors.black),
                  titleTextStyle:
                      TextStyle(color: Colors.black, fontSize: 18))),
          home: MainPage(),
        ),
      );
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Ingredient ingredient;
  List<Ingredient> ingredients = [];
  var res;

  @override
  Widget build(BuildContext context) => Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg-home.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.transparent,
          ),
          body: Padding(
            padding: EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                new Container(
                  child: new Image.asset(
                    'assets/images/logo.png',
                    height: MediaQuery.of(context).size.height * 0.479,
                    fit: BoxFit.fill,
                  ),
                ),
                buildRandomDrink(),
                buildMultipleDrink(),
                buildListDrink()
              ],
            ),
          ),
        ),
      );

  Widget buildRandomDrink() {
    final onTap = () async {
      res = await rootBundle.loadString('assets/drink_codes.json');
      final drinksTmp = drinksFromJson(res);

      final ingredients = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DrinkDetailPage(
                drink: drinksTmp[Random().nextInt(drinksTmp.length)])),
      );

      if (ingredients == null) return;

      setState(() => this.ingredients = ingredients);
    };

    return buildIngredientPicker(
        child: buildListTile(
            title: 'Mi sento fortunato :)',
            onTap: onTap,
            icons: Icons.wine_bar));
  }

  Widget buildMultipleDrink() {
    final onTap = () async {
      final ingredients = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => IngredientPage(
                  isMultiSelection: true,
                  ingredients: List.of(this.ingredients),
                )),
      );

      if (ingredients == null) return;

      setState(() => this.ingredients = ingredients);
    };

    return buildIngredientPicker(
        child: buildListTile(
            title: 'Cerca un drink con...', onTap: onTap, icons: Icons.search));
  }

  Widget buildListDrink() {
    final onTap = () async {
      final ingredients = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => DrinkPage()),
      );

      if (ingredients == null) return;

      setState(() => this.ingredients = ingredients);
    };

    return buildIngredientPicker(
        child: buildListTile(
            title: 'Lista dei Drink', onTap: onTap, icons: Icons.list));
  }

  Widget buildListTile({
    @required String title,
    @required VoidCallback onTap,
    @required IconData icons,
    Widget leading,
  }) {
    return ListTile(
      onTap: onTap,
      leading: leading,
      title: Text(
        title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(color: Colors.black, fontSize: 18),
      ),
      trailing: Icon(icons, color: Colors.black),
    );
  }

  Widget buildIngredientPicker({
    @required Widget child,
  }) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 12),
          Card(
            margin: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            child: child,
          ),
        ],
      );
}