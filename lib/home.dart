import 'dart:convert';
import 'dart:developer';
import 'dart:math';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';
import 'package:recipe_hub/model.dart';
import 'package:recipe_hub/recipeView.dart';
import 'package:recipe_hub/search.dart';


class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<RecipeModel> recipeList = <RecipeModel>[];
  bool isLoading = true;

  TextEditingController searchController = TextEditingController();

  Future<void> _refreshData() async {
    // Set isLoading to true to indicate that a refresh is in progress
    setState(() {
      isLoading = true;
    });

    // Clear the existing recipeList before fetching new data
    setState(() {
      recipeList.clear();
    });

    // Fetch new data
    await getRecipe(searchController.text);

    // Inform the RefreshIndicator that the refresh is complete
    // and set isLoading to false
    setState(() {
      isLoading = false;
    });

    return Future<void>.value();
  }

  List recipeListItem =["Paneer","Pizza","Cake","Ice Cream","Maggie","Manchurian","Dal","Chocolate"];
  late var itemName;
  final _random = Random();


  // var itemName = recipeListItem[_random.nextInt(recipeListItem.length)];


  List recipeCatList = [
    {
      "imgUrl": "https://images.unsplash.com/photo-1593560704563-f176a2eb61db",
      "heading": "Chilli Food"
    },
    {
      "imgUrl": "https://images.unsplash.com/photo-1593560704563-f176a2eb61db",
      "heading": "Chilli Food"
    },
    {
      "imgUrl": "https://images.unsplash.com/photo-1593560704563-f176a2eb61db",
      "heading": "Chilli Food"
    },
    {
      "imgUrl": "https://images.unsplash.com/photo-1593560704563-f176a2eb61db",
      "heading": "Chilli Food"
    },
    {
      "imgUrl": "https://images.unsplash.com/photo-1593560704563-f176a2eb61db",
      "heading": "Chilli Food"
    }
  ];
  getRecipe(String query) async {
    String url =
        "${dotenv.env['ENDPOINT']}?q=$query&app_id=${dotenv.env['APPID']}&app_key=${dotenv.env['APIKEY']}";
    Response response = await get(Uri.parse(url));
    Map data = jsonDecode(response.body);


    data["hits"].forEach((element) {
      RecipeModel recipeModel = RecipeModel();
      recipeModel = RecipeModel.fromMap(element["recipe"]);
      recipeList.add(recipeModel);
      // log(recipeList.toString());
      setState(() {
        isLoading = false;
      });
    });
    recipeList.forEach((Recipe) {

    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    for (int i = 0; i < 3; i++) {
      getRecipe(recipeListItem[_random.nextInt(recipeListItem.length)]);

    }
  }

  @override
  Widget build(BuildContext context) {



    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [Color(0xff213A50), Color(0xff071938)])),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                SafeArea(
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 24),
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      color: Colors.white,
                    ),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            if ((searchController.text).replaceAll(" ", "") ==
                                "") {
                              print("Blank Search");
                            } else {
                              Navigator.push(context,MaterialPageRoute(builder: (context)=>Search(searchController.text)));
                            }
                          },
                          child: Container(
                              margin: const EdgeInsets.fromLTRB(3, 0, 7, 0),
                              child: const Icon(
                                Icons.search,
                                color: Colors.blue,
                              )),
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: searchController,
                            onEditingComplete: () {
                              if ((searchController.text).replaceAll(" ", "") ==
                                  "") {
                                print("Blank Search");
                              } else {
                                Navigator.push(context,MaterialPageRoute(builder: (context)=>Search(searchController.text)));
                              }
                            },
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: "Let's Cook Something"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "WHAT DO YOU WANT TO COOK TODAY ?",
                        style: TextStyle(fontSize: 33, color: Colors.white),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Let's Cook Something New!",
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: RefreshIndicator(
                    onRefresh: _refreshData,
                    child: isLoading ? CircularProgressIndicator() : ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: recipeList.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>RecipeView(recipeList[index].appurl)));
                            },
                            child: Card(
                              margin: EdgeInsets.all(20),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              elevation: 0.0,
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      recipeList[index].appimgUrl,
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      height: 200,
                                    ),
                                  ),
                                  Positioned(
                                    left: 0,
                                    right: 0,
                                    bottom: 0,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 6, vertical: 10),
                                      decoration: const BoxDecoration(
                                        color: Colors.black26,
                                      ),
                                      child: Text(
                                        recipeList[index].applabel,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 17,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    right: 0,
                                    width: 80,
                                    height: 33,
                                    child: Container(
                                      alignment: Alignment.center,
                                      decoration: const BoxDecoration(
                                          color: Colors.white60,
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(10),
                                            bottomLeft: Radius.circular(10),
                                          )),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Icon(
                                            Icons.local_fire_department,
                                            size: 18,
                                          ),
                                          Text(
                                            recipeList[index]
                                                        .appcalories
                                                        .toString()
                                                        .length >=
                                                    6
                                                ? recipeList[index]
                                                    .appcalories
                                                    .toString()
                                                    .substring(0, 6)
                                                : recipeList[index]
                                                    .appcalories
                                                    .toString(),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                ),
                Container(
                  height: 100,
                  child: ListView.builder(
                    itemCount: recipeCatList.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Container(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>Search(recipeCatList[index]["heading"])));
                          },
                          child: Card(
                            margin: EdgeInsets.all(20),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                            elevation: 0.0,
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(18.0),
                                  child: Image.network(
                                    recipeCatList[index]["imgUrl"],
                                    fit: BoxFit.cover,
                                    width: 200,
                                    height: 250,
                                  ),
                                ),
                                Positioned(
                                    left: 0,
                                    right: 0,
                                    bottom: 0,
                                    top: 0,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 10),
                                      decoration:
                                          BoxDecoration(color: Colors.black26),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            recipeCatList[index]["heading"],
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 28),
                                          )
                                        ],
                                      ),
                                    ))
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
