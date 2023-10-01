import 'package:drinky/model/drink.dart';
import 'package:flutter/material.dart';

class DrinkDetailPage extends StatelessWidget {
  final Drink drink;

  const DrinkDetailPage({Key? key, required this.drink}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    List<String> doses = [];
    doses = drink.doses.split(",");

    return Container(
      constraints: BoxConstraints.expand(),
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/bg-menu.png"),
              fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(drink.name),
          elevation: 0.0,
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "${drink.name}",
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.black,
                  ),
                ),
              SizedBox(
                height: 2,
              ),
                Text(
                  "Categoria: ${drink.category}",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Hero(
                        tag: drink.code,
                          child: Image.asset(
                              'assets/images/drinks/' + drink.name + '.png',
                              height: 150,
                              width: 150,
                              fit: BoxFit.contain
                          ),
                        ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Column(children: [
                          Text("Ingredienti",
                              style: TextStyle(
                                fontSize: 22,
                                color: Colors.black,
                              ),
                              ),
                          SizedBox(
                            width: 160,
                            child: Text("${drink.ingredients}",
                                overflow: TextOverflow.clip,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                                textAlign: TextAlign.center),
                          ),
                        ]),
                      ),
                    ]),
                SizedBox(
                  height: 30.0,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    //color: Colors.red,
                    child: Text(
                      "Storia",
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                Text("${drink.story}",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.left),
                SizedBox(
                  height: 20.0,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    child: Text(
                      "Dosi",
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: null,
                  child:
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: doses.length,
                    itemBuilder: (context, index) {
                      var dose = doses[index];
                      return ListTile(
                          minLeadingWidth: 0,
                          contentPadding: EdgeInsets.only(left: 0.0, right: 0.0),
                          visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                          leading: Icon(Icons.arrow_forward_ios_sharp, color: Colors.black),
                        title: Text(
                          dose,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        )
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    child: Text(
                      "Preparazione",
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                Text("${drink.preparation}",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.left),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
