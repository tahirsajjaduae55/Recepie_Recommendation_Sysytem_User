import 'package:firebase_database/firebase_database.dart';

class QuestionModel {
  late String _name;
  late String _cost;

  //constructor for add
  QuestionModel(
    this._name,
    this._cost,
  );

  //Constructor for edit
  QuestionModel.withId(
    this._name,
    this._cost,
  );

  //getters

  String get getName => _name;
  String get getCost => _cost;

  //Setters

  set setLastName(String lastName) {
    _name = lastName;
  }

  set setPhone(String phone) {
    _cost = phone;
  }

//Converting snapshot back to class object
  QuestionModel.fromSnapshot(DataSnapshot snapshot) {
    _name = (snapshot.value as dynamic)["name"];
    _cost = (snapshot.value as dynamic)["cost"];
  }

//Converting class object to JSON
  Map<String, dynamic> toJson() {
    return {
      "name": _name,
      "cost": _cost,
    };
  }
}
