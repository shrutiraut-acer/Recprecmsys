//import 'dart:convert';
//import 'package:flutter/foundation.dart';
//import 'package:flutter/material.dart';
//import 'package:http/http.dart' as http;
//import 'package:recipefinal/model/recipe_model.dart';
//import 'package:recipefinal/page.dart';

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:recipefinal/model/recipe_model.dart';
import 'package:http/http.dart' as http;
import 'package:recipefinal/page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<RecipeModel> recipesList = <RecipeModel>[];
  TextEditingController searchController = TextEditingController();

  getRecipe(String query) async {
    String url =
        "https://api.edamam.com/search?q=$query&app_id=2c6e15f3&app_key=be322c8daf264f0cbaee26dcdc3472f4&from=0&to=20&calories=591-722&health=alcohol-free";
    var response = await http.get(Uri.parse(url));
    Map json = jsonDecode(response.body);
    print(response.body);

    json['hits'].forEach((e) {
      RecipeModel rm = RecipeModel(
        url: e['recipe']['url'],
        source: e['recipe']['source'],
        image: e['recipe']['image'],
        label: e['recipe']['label'],
      );

      setState(() {
        recipesList.add(rm);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
              gradient:
                  LinearGradient(colors: [Colors.orange, Colors.deepOrange])),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: const Row(
                    mainAxisAlignment: kIsWeb
                        ? MainAxisAlignment.start
                        : MainAxisAlignment.center,
                    children: [
                      Text(
                        "S H R U",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        " R E C I P E",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  "What will you cook today?",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                    "Just Enter Ingredients you have and we will show the best recipe for you...",
                    style: TextStyle(fontSize: 15, color: Colors.white)),
                SizedBox(
                  height: 30,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: searchController,
                          decoration: InputDecoration(
                              hintText: "Enter Ingredients",
                              hintStyle: TextStyle(fontSize: 18)),
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      InkWell(
                        onTap: () {
                          if (searchController.text.isNotEmpty) {
                            print("not empty");
                            getRecipe(searchController.text);
                          } else {
                            print("empty");
                          }
                        },
                        child: Container(
                          child: Icon(Icons.search),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height,
                  child: GridView.builder(
                      physics: ScrollPhysics(),
                      shrinkWrap: true,
                      primary: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        childAspectRatio: 1.2,
                        mainAxisSpacing: 15,
                      ),
                      itemCount: recipesList.length,
                      itemBuilder: (context, i) {
                        final x = recipesList[i];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        PageInfo(url: x.url.toString())));
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: NetworkImage(x.image.toString()))),
                              child: Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(10.0),
                                    width: double.infinity,
                                    height: 50,
                                    color: Colors.black.withOpacity(0.5),
                                    child: Text(
                                      x.label.toString(),
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 22),
                                    ),
                                  )
                                ],
                              )),
                        );
                      }),
                )
              ],
            ),
          ),
        ),
      ],
    ));
  }
}
