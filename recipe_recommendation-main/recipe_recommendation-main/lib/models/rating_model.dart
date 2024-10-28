import 'package:firebase_database/firebase_database.dart';

class RatingModel {
  String? _id;

  late String _name;
  late String _cost;
  late String _imagePath;
  late String _instructions;
  late String _feedback;
  late double _rating;

  //constructor for add
  RatingModel(
    this._name,
    this._cost,
    this._imagePath,
    this._instructions,
    this._feedback,
    this._rating,
  );

  //Constructor for edit
  RatingModel.withId(
    this._id,
    this._name,
    this._cost,
    this._imagePath,
    this._instructions,
    this._feedback,
    this._rating,
  );

  //getters
  String? get id => _id;

  String get name => _name;
  String get cost => _cost;
  String get feedback => _feedback;
  String get instructions => _instructions;
  double get rating => _rating;
  String get imagePath => _imagePath;

  //Setters

  set setLastName(String lastName) {
    _name = lastName;
  }

  set setImagePath(String imagePath) {
    _imagePath = imagePath;
  }

  set setPhone(String phone) {
    _cost = phone;
  }

  set setEmail(String email) {
    _feedback = email;
  }

  set setPassword(String pass) {
    _instructions = pass;
  }

  set setrating(double rating) {
    _rating = rating;
  }

//Converting snapshot back to class object
  RatingModel.fromSnapshot(DataSnapshot snapshot) {
    _id = snapshot.key;
    _id = (snapshot.value as dynamic)["id"];

    _name = (snapshot.value as dynamic)["name"];
    _cost = (snapshot.value as dynamic)["cost"];
    _instructions = (snapshot.value as dynamic)["instructions"];
    _feedback = (snapshot.value as dynamic)["feedback"];
    _rating = (snapshot.value as dynamic)["rating"];
  }

//Converting class object to JSON
  Map<String, dynamic> toJson() {
    return {
      "id": _id,
      "name": _name,
      "cost": _cost,
      "instructions": _instructions,
      "feedback": _feedback,
      "rating": _rating,
    };
  }
}
