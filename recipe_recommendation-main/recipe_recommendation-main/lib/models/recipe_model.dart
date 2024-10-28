class RecipeModel {
  String? message;
  List<Response>? response;

  RecipeModel({this.message, this.response});

  RecipeModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['response'] != null) {
      response = <Response>[];
      json['response'].forEach((v) {
        response!.add(Response.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (response != null) {
      data['response'] = response!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Response {
  String? cookingInstruction;
  String? imagePath;
  int? netPrice;
  String? recipeName;

  Response(
      {this.cookingInstruction,
      this.imagePath,
      this.netPrice,
      this.recipeName});

  Response.fromJson(Map<String, dynamic> json) {
    cookingInstruction = json['cooking_instruction'];
    imagePath = json['image_path'];
    netPrice = json['net_price'];
    recipeName = json['recipe_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cooking_instruction'] = cookingInstruction;
    data['image_path'] = imagePath;
    data['net_price'] = netPrice;
    data['recipe_name'] = recipeName;
    return data;
  }
}
