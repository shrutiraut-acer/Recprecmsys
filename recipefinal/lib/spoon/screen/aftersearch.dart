//import 'package:flutter/material.dart';
//import 'package:recipefinal/spoon/screen/recipedetails.dart';

import 'package:flutter/material.dart';
import 'package:recipefinal/spoon/screen/recipedetails.dart';

class AfterSearch extends StatefulWidget {
  final List listrecipe;

  const AfterSearch({super.key, required this.listrecipe});

  @override
  State<AfterSearch> createState() => _AfterSearchState();
}

class _AfterSearchState extends State<AfterSearch> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.deepOrange,
        centerTitle: true,
        title: Center(
            child: Text(
          "RECIPE",
          style: TextStyle(color: Colors.white),
        )),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(bottom: 10, left: 10, right: 10),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: widget.listrecipe.length,
                itemBuilder: (context, index) {
                  final recipe = widget.listrecipe[index];
                  return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  RecipeDetails(recipeId: recipe.id)),
                        );
                      },
                      child: ListTile(
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30)),
                              height: 150,
                              width: MediaQuery.of(context).size.width,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: Image.network(
                                  'https://spoonacular.com/recipeImages/${recipe.id}-636x393.jpg',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Text(
                              "${recipe.title} ",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 18),
                            ),
                            SizedBox(
                              height: 10,
                            )
                          ],
                        ),
                      ));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
