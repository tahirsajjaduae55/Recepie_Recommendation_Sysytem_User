import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../models/recipe_model.dart';

class RecipeViewModel with ChangeNotifier {
  TextEditingController ingredientsController = TextEditingController();
  RecipeModel? recipeModel;
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<void> setLoading(bool value) async {
    // Use Future.delayed to schedule the state update
    await Future.delayed(Duration.zero);

    _isLoading = value;
    notifyListeners();
  }

  Future<void> fetchRecipes(String ingredients) async {
    setLoading(true);
    // final url = Uri.parse(
    //     'https://reciepe-recommendation.onrender.com/recommend_recipes');
    final url = Uri.parse(
        'https://recepie-recomm-flask.onrender.com/recommend_recipes');
    final Map<String, String> headers = {"Content-type": "application/json"};
    final Map<String, String> data = {"ingredients": ingredients};
    final String jsonData = json.encode(data);

    final response = await http.post(
      url,
      headers: headers,
      body: jsonData,
    );

    if (response.statusCode == 200) {
      setLoading(false);
      final jsonResponse = json.decode(response.body);
      print(jsonResponse);
      recipeModel = RecipeModel.fromJson(jsonResponse);
      notifyListeners();
    } else {
      recipeModel = null;
      setLoading(false);
    }
    notifyListeners();
    setLoading(false);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    ingredientsController.dispose();
  }

  final DatabaseReference _databaseReference =
      FirebaseDatabase.instance.ref().child('user_recipe_data');

  List<String> selectedRecipes = [];
  Map<String, int> recipeVisitCount = {};

  void selectRecipe(String recipeName) {
    // Increase visit count for the selected recipe
    recipeVisitCount[recipeName] = (recipeVisitCount[recipeName] ?? 0) + 1;

    if (!selectedRecipes.contains(recipeName)) {
      selectedRecipes.add(recipeName);
    }

    // Save data to Firebase
    _saveDataToFirebase();

    notifyListeners();
  }

  void _saveDataToFirebase() {
    _databaseReference.child('selectedRecipes').set(selectedRecipes);

    // Save visit count for each recipe individually
    recipeVisitCount.forEach((recipeName, visitCount) {
      _databaseReference
          .child('recipeVisitCount')
          .child(recipeName)
          .set(visitCount);
    });
  }
}
