import 'package:carousel_slider/carousel_slider.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:recipe_recomendation/app/index.dart';
import 'package:recipe_recomendation/presentation/common/app_button.dart';
import 'package:recipe_recomendation/presentation/utils/api_services.dart';
import 'package:recipe_recomendation/presentation/views/login/login_view.dart';
import 'package:recipe_recomendation/presentation/views/recipes_details/recipe_details.dart';
import 'package:recipe_recomendation/presentation/views/recommended_recipies/recommended_recipies.dart';

import '../../../models/user_model.dart';
import '../../common/config.dart';
import '../login/edit_profile_screen.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final DatabaseReference _userReference =
      FirebaseDatabase.instance.ref().child('Users');

  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? currentUser;
  var isLoading = false;
  var userData = [];
  List<Map<String, dynamic>> recipeDetails = [];
  List<UserModel> userModel = <UserModel>[];
  DatabaseReference starCountRef =
      FirebaseDatabase.instance.ref().child('ingridents');

  List<Map<String, dynamic>> ingredientsList = [];
  List<String> ingredientsName = [];

  String address = '';
  String name = '';

  @override
  void initState() {
    super.initState();
    print('object');
    getIngredients();
    currentUser = _auth.currentUser;

    getCurrentUser();
  }

  Widget listItem({required Map student}) {
    double rating = double.tryParse(student['rating']) ?? 0.0;
    String imageUrl =
        'https://recepie-recomm-flask.onrender.com/images/${student['imagePath']}'; // Fixed this line

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: InkWell(
        onTap: () {
          Get.to(
            RecipeDetailsView(
              student['name'],
              student['cost'],
              student['imagePath'],
              student['instructions'],
              student['feedback'],
              rating,
            ),
          );
        },
        child: Container(
          color: ColorManager.grey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                imageUrl,
                fit: BoxFit.fill,
                height: 200.h,
                width: 1.sw,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Utils.popinSemBoldText(
                        student['name'],
                        fontSize: 18.sp,
                      ),
                    ),
                    IgnorePointer(
                      child: RatingBar.builder(
                        itemSize: 20.sp,
                        initialRating: rating,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {
                          print(rating);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<RecipeViewModel>(context);
    // final List<String> ingredientsName = [
    //   "chicken",
    //   "rice",
    //   "onion",
    //   "garlic",
    //   "pasta",
    //   "tomato sauce",
    //   "ground beef",
    //   "onion",
    //   "garlic",
    //   "salmon",
    //   "lemon",
    //   "dill",
    //   "olive oil",
    //   "potato",
    //   "butter",
    //   "milk",
    //   "lettuce",
    //   "tomato",
    //   "cucumber",
    //   "onion",
    //   "olive oil",
    //   "beef",
    //   "onion",
    //   "bell pepper",
    //   "tomato",
    //   "cumin",
    //   "chicken",
    //   "tortilla",
    //   "lettuce",
    //   "cheese",
    //   "salsa",
    //   "rice",
    //   "beans",
    //   "avocado",
    //   "tomato",
    //   "cilantro",
    //   "egg",
    //   "cheese",
    //   "spinach",
    //   "tomato",
    //   "onion",
    //   "quinoa",
    //   "black beans",
    //   "corn",
    //   "bell pepper",
    //   "lime",
    //   "shrimp",
    //   "pasta",
    //   "garlic",
    //   "butter",
    //   "lemon",
    //   "salmon",
    //   "asparagus",
    //   "lemon",
    //   "olive oil",
    //   "chicken",
    //   "broccoli",
    //   "teriyaki sauce",
    //   "sesame seeds",
    //   "penne pasta",
    //   "cream",
    //   "parmesan cheese",
    //   "bacon",
    //   "peas",
    //   "ground turkey",
    //   "onion",
    //   "garlic",
    //   "chili powder",
    //   "beans",
    //   "potatoes",
    //   "bell pepper",
    //   "onion",
    //   "sausage",
    //   "eggs",
    //   "salmon",
    //   "cucumber",
    //   "yogurt",
    //   "dill",
    //   "lemon",
    //   "pasta",
    //   "broccoli",
    //   "garlic",
    //   "red pepper flakes",
    //   "olive oil",
    //   "chicken",
    //   "bell pepper",
    //   "onion",
    //   "pineapple",
    //   "rice",
    //   "ground beef",
    //   "onion",
    //   "bell pepper",
    //   "tomato",
    //   "pasta",
    //   "shrimp",
    //   "garlic",
    //   "butter",
    //   "parsley",
    //   "beef",
    //   "tortilla",
    //   "cheese",
    //   "lettuce",
    //   "salsa",
    //   "egg",
    //   "spinach",
    //   "mushroom",
    //   "onion",
    //   "cheese",
    //   "salmon",
    //   "lemon",
    //   "rosemary",
    //   "butter",
    //   "chicken",
    //   "teriyaki sauce",
    //   "pineapple",
    //   "bell pepper",
    //   "onion",
    //   "quinoa",
    //   "chicken",
    //   "black beans",
    //   "corn",
    //   "avocado",
    //   "pasta",
    //   "pesto sauce",
    //   "tomato",
    //   "mozzarella cheese",
    //   "basil",
    //   "shrimp",
    //   "avocado",
    //   "tomato",
    //   "onion",
    //   "cilantro",
    //   "chicken",
    //   "barbecue sauce",
    //   "corn",
    //   "black beans",
    //   "cilantro",
    //   "rice",
    //   "beef",
    //   "broccoli",
    //   "carrot",
    //   "pasta",
    //   "tomato sauce",
    //   "garlic",
    //   "olive oil",
    //   "basil",
    //   "salmon",
    //   "garlic",
    //   "lemon",
    //   "olive oil",
    //   "thyme",
    //   "chicken",
    //   "onion",
    //   "bell pepper",
    //   "tomato",
    //   "chili powder",
    //   "potatoes",
    //   "bacon",
    //   "cheddar cheese",
    //   "sour cream",
    //   "chives",
    //   "beef",
    //   "bell pepper",
    //   "onion",
    //   "mushrooms",
    //   "garlic",
    //   "pasta",
    //   "tomato sauce",
    //   "ground turkey",
    //   "garlic",
    //   "basil",
    //   "salmon",
    //   "garlic",
    //   "ginger",
    //   "sesame seeds",
    //   "pasta",
    //   "alfredo sauce",
    //   "bacon",
    //   "peas",
    //   "parmesan cheese",
    //   "shrimp",
    //   "garlic",
    //   "lemon",
    //   "butter",
    //   "parsley",
    //   "rice",
    //   "tofu",
    //   "broccoli",
    //   "carrot",
    //   "pasta",
    //   "marinara sauce",
    //   "mushroom",
    //   "onion",
    //   "basil",
    //   "salmon",
    //   "spinach",
    //   "lemon",
    //   "garlic",
    //   "olive oil",
    //   "chicken",
    //   "ranch dressing",
    //   "bacon",
    //   "cheese",
    //   "lettuce",
    //   "pasta",
    //   "pesto sauce",
    //   "chicken",
    //   "sun-dried tomato",
    //   "spinach",
    //   "shrimp",
    //   "pasta",
    //   "tomato",
    //   "garlic",
    //   "chili flakes",
    //   "beef",
    //   "potato",
    //   "carrot",
    //   "onion",
    //   "beef broth",
    //   "spaghetti",
    //   "garlic",
    //   "olive oil",
    //   "red pepper flakes",
    //   "parsley",
    //   "beef",
    //   "mushrooms",
    //   "onion",
    //   "sour cream",
    //   "butter",
    //   "chicken",
    //   "bell pepper",
    //   "onion",
    //   "black beans",
    //   "corn",
    //   "pasta",
    //   "pesto sauce",
    //   "pine nuts",
    //   "parmesan cheese",
    //   "basil",
    //   "salmon",
    //   "garlic",
    //   "ginger",
    //   "sesame seeds",
    //   "pasta",
    //   "alfredo sauce",
    //   "chicken",
    //   "peas",
    //   "mushrooms",
    //   "salmon",
    //   "garlic",
    //   "lemon",
    //   "butter",
    //   "parsley",
    //   "beef",
    //   "bell pepper",
    //   "onion",
    //   "hoisin sauce",
    //   "sesame seeds",
    //   "pasta",
    //   "garlic",
    //   "olive oil",
    //   "spinach",
    //   "parmesan cheese",
    //   "chicken",
    //   "lemon",
    //   "garlic",
    //   "oregano",
    //   "olive oil",
    //   "potatoes",
    //   "garlic",
    //   "butter",
    //   "chives",
    //   "sour cream",
    //   "shrimp",
    //   "garlic",
    //   "white wine",
    //   "lemon",
    //   "butter",
    //   "pasta",
    //   "tomato sauce",
    //   "ground turkey",
    //   "garlic",
    //   "basil",
    //   "salmon",
    //   "garlic",
    //   "ginger",
    //   "sesame seeds",
    //   "pasta",
    //   "alfredo sauce",
    //   "bacon",
    //   "peas",
    //   "parmesan cheese",
    //   "shrimp",
    //   "garlic",
    //   "lemon",
    //   "butter",
    //   "parsley",
    //   "rice",
    //   "tofu",
    //   "broccoli",
    //   "carrot",
    //   "salmon",
    //   "garlic",
    //   "lemon",
    //   "thyme",
    //   "butter",
    //   "chicken",
    //   "ginger",
    //   "sesame oil",
    //   "scallions",
    //   "beef",
    //   "bell pepper",
    //   "onion",
    //   "garlic",
    //   "hoisin sauce",
    //   "sesame seeds",
    //   "pasta",
    //   "garlic",
    //   "olive oil",
    //   "spinach",
    //   "parmesan cheese",
    //   "chicken",
    //   "lemon",
    //   "garlic",
    //   "thyme",
    //   "honey",
    //   "rice",
    //   "ground beef",
    //   "black beans",
    //   "bell pepper",
    //   "salsa",
    //   "pasta",
    //   "tomato sauce",
    //   "garlic",
    //   "red pepper flakes",
    //   "olives",
    //   "salmon",
    //   "garlic",
    //   "lemon",
    //   "butter",
    //   "bitter",
    //   "beef",
    //   "bell pepper",
    //   "onion",
    //   "ginger",
    //   "chicken",
    //   "lemon",
    //   "garlic",
    //   "paprika",
    //   "olive oil",
    //   "rice",
    //   "black beans",
    //   "corn",
    //   "bell pepper",
    //   "cumin",
    //   "shrimp",
    //   "garlic",
    //   "tomato",
    //   "basil",
    //   "white wine",
    //   "pasta",
    //   "alfredo sauce",
    //   "chicken",
    //   "peas",
    //   "mushrooms",
    //   "salmon",
    //   "garlic",
    //   "lemon",
    //   "butter",
    //   "pasta",
    //   "garlic",
    //   "olive oil",
    //   "sun-dried tomatoes",
    //   "spinach",
    //   "feta cheese",
    //   "pasta",
    //   "tomato sauce",
    //   "garlic",
    //   "basil",
    //   "mozzarella cheese",
    //   "salmon",
    //   "garlic",
    //   "lemon",
    //   "butter",
    //   "parsley",
    //   "beef",
    //   "bell pepper",
    //   "onion",
    //   "ginger",
    //   "teriyaki sauce",
    //   "sesame seeds",
    //   "pasta",
    //   "garlic",
    //   "olive oil",
    //   "cherry tomatoes",
    //   "basil",
    //   "chicken",
    //   "bell pepper",
    //   "onion",
    //   "garlic",
    //   "Cajun seasoning",
    //   "pasta",
    //   "garlic",
    //   "olive oil",
    //   "red pepper flakes",
    //   "parmesan cheese",
    //   "chicken",
    //   "lemon",
    //   "garlic",
    //   "thyme",
    //   "honey",
    //   "rice",
    //   "black-eyed peas",
    //   "ham",
    //   "onion",
    //   "garlic",
    //   "pasta",
    //   "tomato sauce",
    //   "garlic",
    //   "basil",
    //   "parmesan cheese",
    //   "salmon",
    //   "garlic",
    //   "lemon",
    //   "butter",
    //   "capers",
    //   "beef",
    //   "bell pepper",
    //   "onion",
    //   "hoisin sauce",
    //   "sesame seeds",
    //   "pasta",
    //   "garlic",
    //   "olive oil",
    //   "spinach",
    //   "parmesan cheese",
    //   "chicken",
    //   "lemon",
    //   "garlic",
    //   "thyme",
    //   "honey",
    //   "rice",
    //   "black beans",
    //   "corn",
    //   "cilantro",
    //   "lime",
    //   "pasta",
    //   "garlic",
    //   "olive oil",
    //   "sun-dried tomatoes",
    //   "spinach",
    //   "feta cheese",
    //   "pasta",
    //   "tomato sauce",
    //   "garlic",
    //   "red pepper flakes",
    //   "parmesan cheese",
    //   "chicken",
    //   "lemon",
    //   "garlic",
    //   "thyme",
    //   "honey",
    //   "rice",
    //   "black-eyed peas",
    //   "ham",
    //   "onion",
    //   "garlic",
    //   "pasta",
    //   "tomato sauce",
    //   "garlic",
    //   "basil",
    //   "parmesan cheese",
    //   "beef",
    //   "bell pepper",
    //   "onion",
    //   "ginger",
    //   "hoisin sauce",
    //   "sesame seeds",
    //   "pasta",
    //   "garlic",
    //   "olive oil",
    //   "spinach",
    //   "parmesan cheese",
    //   "chicken",
    //   "lemon",
    //   "garlic",
    //   "thyme",
    //   "honey",
    //   "rice",
    //   "black beans",
    //   "corn",
    //   "avocado",
    //   "pasta",
    //   "garlic",
    //   "olive oil",
    //   "cherry tomatoes",
    //   "basil",
    //   "salmon",
    //   "garlic",
    //   "lemon",
    //   "butter",
    //   "beef",
    //   "broccoli",
    //   "garlic",
    //   "sesame oil",
    //   "chicken",
    //   "lemon",
    //   "garlic",
    //   "rosemary",
    //   "olive oil",
    //   "pasta",
    //   "garlic",
    //   "olive oil",
    //   "spinach",
    //   "feta cheese",
    //   "pasta",
    //   "tomato sauce",
    //   "garlic",
    //   "basil",
    //   "mozzarella cheese",
    //   "salmon",
    //   "garlic",
    //   "lemon",
    //   "butter",
    //   "parsley",
    //   "beef",
    //   "bell pepper",
    //   "onion",
    //   "ginger",
    //   "hoisin sauce",
    //   "sesame seeds",
    //   "pasta",
    //   "garlic",
    //   "olive oil",
    //   "spinach",
    //   "parmesan cheese",
    //   "chicken",
    //   "lemon",
    //   "garlic",
    //   "thyme",
    //   "honey",
    //   "rice",
    //   "black beans",
    //   "corn",
    //   "bell pepper",
    //   "cumin",
    //   "shrimp",
    //   "garlic",
    //   "tomato",
    //   "basil",
    //   "white wine",
    //   "pasta",
    //   "alfredo sauce",
    //   "chicken",
    //   "peas",
    //   "mushrooms",
    //   "salmon",
    //   "garlic",
    //   "lemon",
    //   "butter",
    //   "parsley",
    //   "rice",
    //   "tofu",
    //   "broccoli",
    //   "carrot",
    //   "salmon",
    //   "garlic",
    //   "lemon",
    //   "thyme",
    //   "butter",
    //   "chicken",
    //   "ginger",
    //   "sesame oil",
    //   "scallions",
    //   "beef",
    //   "bell pepper",
    //   "onion",
    //   "garlic",
    //   "hoisin sauce",
    //   "sesame seeds",
    //   "shrimp",
    //   "garlic",
    //   "lemon",
    //   "parsley",
    //   "white wine",
    //   "chicken",
    //   "lemon",
    //   "garlic",
    //   "rosemary",
    //   "olive oil",
    //   "rice",
    //   "black beans",
    //   "corn",
    //   "bell pepper",
    //   "cumin",
    //   "shrimp",
    //   "garlic",
    //   "tomato",
    //   "basil",
    //   "white wine",
    //   "pasta",
    //   "alfredo sauce",
    //   "chicken",
    //   "peas",
    //   "mushrooms",
    //   "salmon",
    //   "garlic",
    //   "lemon",
    //   "butter",
    //   "parsley",
    //   "rice",
    //   "tofu",
    //   "broccoli",
    //   "carrot",
    //   "salmon",
    //   "garlic",
    //   "lemon",
    //   "thyme",
    //   "butter",
    //   "chicken",
    //   "ginger",
    //   "soy sauce",
    //   "sesame oil",
    //   "scallions",
    //   "beef",
    //   "bell pepper",
    //   "onion",
    //   "garlic",
    //   "hoisin sauce",
    //   "sesame seeds",
    //   "pasta",
    //   "garlic",
    //   "olive oil",
    //   "spinach",
    //   "parmesan cheese",
    //   "chicken",
    //   "lemon",
    //   "garlic",
    //   "thyme",
    //   "honey",
    //   "rice",
    //   "black beans",
    //   "corn",
    //   "cilantro",
    //   "lime",
    //   "pasta",
    //   "garlic",
    //   "olive oil",
    //   "sun-dried tomatoes",
    //   "spinach",
    //   "feta cheese",
    //   "pasta",
    //   "tomato sauce",
    //   "garlic",
    //   "basil",
    //   "mozzarella cheese",
    //   "salmon",
    //   "garlic",
    //   "lemon",
    //   "butter",
    //   "parsley",
    //   "beef",
    //   "bell pepper",
    //   "onion",
    //   "ginger",
    //   "hoisin sauce",
    //   "sesame seeds",
    //   "pasta",
    //   "garlic",
    //   "olive oil",
    //   "spinach",
    //   "parmesan cheese",
    //   "chicken",
    //   "lemon",
    //   "garlic",
    //   "thyme",
    //   "honey",
    //   "rice",
    //   "black-eyed peas",
    //   "ham",
    //   "onion",
    //   "garlic",
    //   "pasta",
    //   "tomato sauce",
    //   "garlic",
    //   "basil",
    //   "parmesan cheese",
    //   "beef",
    //   "bell pepper",
    //   "onion",
    //   "ginger",
    //   "hoisin sauce",
    //   "sesame seeds",
    //   "pasta",
    //   "garlic",
    //   "olive oil",
    //   "spinach",
    //   "parmesan cheese",
    //   "chicken",
    //   "lemon",
    //   "garlic",
    //   "thyme",
    //   "honey",
    //   "rice",
    //   "black beans",
    //   "corn",
    //   "avocado",
    //   "pasta",
    //   "garlic",
    //   "olive oil",
    //   "cherry tomatoes",
    //   "basil",
    //   "salmon",
    //   "garlic",
    //   "lemon",
    //   "butter",
    // ];

    ValueNotifier<List<String>> selectedIngredients =
        ValueNotifier<List<String>>([]);

    return Scaffold(
      drawer: Drawer(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Column(
                children: <Widget>[
                  40.spaceY,
                  ListTile(
                    tileColor: ColorManager.grey,
                    title: const Text('Name'),
                    subtitle: Text(
                      box!.get('firstName') ?? 'N/A',
                      style: TextStyleManager.popinsSemBold(),
                    ),
                  ),
                  ListTile(
                    tileColor: ColorManager.grey,
                    title: const Text('Email'),
                    subtitle: Text(
                      box!.get('email') ?? 'N/A',
                      style: TextStyleManager.popinsSemBold(),
                    ),
                  ),
                  ListTile(
                    tileColor: ColorManager.grey,
                    title: const Text('Contact'),
                    subtitle: Text(
                      box!.get('phone') ?? 'N/A',
                      style: TextStyleManager.popinsSemBold(),
                    ),
                  ),
                  SizedBox(
                    child: AppButton(
                      onPress: () {
                        Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const EditProfileScreen()))
                            .then((value) => setState(
                                  () {
                                    getCurrentUser();
                                  },
                                ));
                      },
                      text: "Edit Profile",
                    ),
                  ),
                  20.spaceY,
                  AppButton(
                      text: 'Logout',
                      onPress: () async {
                        await _auth.signOut().then((value) =>
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const LoginScreen())));
                      })
                ],
              ),
            ],
          ),
        ),
      ),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: ColorManager.red,
        title: Utils.popinSemBoldText(
          'Recipes',
          color: ColorManager.white,
          fontSize: 20.sp,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Utils.popinBoldText(
              'What Would you Like\nTo Cook Today?',
              fontSize: 22.sp,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: DropdownSearch<String>.multiSelection(
                    key: UniqueKey(),
                    items: ingredientsName,
                    popupProps: const PopupPropsMultiSelection.menu(
                      showSearchBox: true,
                    ),
                    onChanged: (selectedItems) {
                      selectedIngredients.value = selectedItems;
                    },
                    selectedItems: selectedIngredients.value,
                  ),
                ),
                10.spaceX,
                viewModel.isLoading
                    ? SpinKitDancingSquare(
                        color: ColorManager.primary,
                        size: 30.sp,
                      )
                    : Container(
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10.r),
                          shape: BoxShape.rectangle,
                        ),
                        child: IconButton(
                          visualDensity: VisualDensity.comfortable,
                          icon: const Icon(
                            Icons.search,
                            color: Colors.white, // Icon color
                          ),
                          onPressed: () async {
                            final selectedIngredientsList =
                                selectedIngredients.value.join(',');

                            if (selectedIngredientsList.isEmpty) {
                              Utils.snackBar(
                                  context, 'Select a ingrident to search');
                            } else {
                              await viewModel
                                  .fetchRecipes(selectedIngredientsList);
                              Get.to(const RecommendedRecipes());
                            }

                            // Handle the search button press
                          },
                        ),
                      ),
              ],
            ),
            10.spaceY,
            ProfessionalCarouselSlider(),
            5.spaceY,
            Utils.popinSemBoldText(
              'Recommendations',
              fontSize: 18.sp,
            ),
            5.spaceY,
            Expanded(
              child: FirebaseAnimatedList(
                shrinkWrap: true,
                query: FirebaseDatabase.instance
                    .ref()
                    .child('recipe_ratings')
                    .orderByChild('rating')
                    .equalTo('5.0'),
                itemBuilder: (BuildContext context, DataSnapshot snapshot,
                    Animation<double> animation, int index) {
                  Map student = snapshot.value as Map;
                  student['key'] = snapshot.key;

                  print(student);
                  double rating = double.tryParse(student['rating']) ?? 0.0;
                  if (rating == 5) {
                    return listItem(student: student);
                  } else {
                    return Container();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> getCurrentUser() async {
    _userReference.onValue.listen((DatabaseEvent event) {
      var snapshot = event.snapshot;

      userData.clear();
      userModel.clear();

      for (var data in snapshot.children) {
        userData.add(data.value);
      }

      setState(() {
        if (snapshot.exists && userData.isNotEmpty) {
          for (int x = 0; x < userData.length; x++) {
            if (userData[x]['id'] == currentUser!.uid.toString()) {
              String id = userData[x]['id'].toString();
              String firstName = userData[x]['firstName'];

              name = firstName;
              print(name);
              String password = userData[x]['password'];
              String phone = userData[x]['phone'];
              String email = userData[x]['email'];
              //Adding data to Hive
              box!.put("firstName", userData[x]['firstName']);

              box!.put("phone", userData[x]['phone']);

              box!.put("email", email);

              userModel.add(UserModel.withId(
                id,
                firstName,
                phone,
                email,
                password,
              ));
            }
            isLoading = true;
          }
        } else {
          isLoading = false;
        }
      });
    });
  }

  Future<void> getIngredients() async {
    starCountRef.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;

      if (data != null && data is Map) {
        Map<String, dynamic> ingredientsMap =
            Map<String, dynamic>.from(data.cast<String, dynamic>());
        List<Map<String, dynamic>> list = [];

        ingredientsMap.forEach((key, value) {
          list.add(Map<String, dynamic>.from(value));
        });

        setState(() {
          ingredientsList = list;
          ingredientsName =
              list.map((ingredient) => ingredient['name'] as String).toList();
        });
      }
    });
  }
}

class ProfessionalCarouselSlider extends StatelessWidget {
  final List<String> ingridientsName = [
    "Cheese",
    "Chicken ",
    "Salt",
    "Pepper",
    "Onion",
    "Paprika",
    "Carrots",
  ];

  ProfessionalCarouselSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        autoPlay: true,
        enlargeCenterPage: true,
        aspectRatio: 18 / 10, // Adjust the aspect ratio as needed
        viewportFraction: 0.8, // Adjust the visible item size
      ),
      items: ingridientsName.map((recipeName) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: 1.sw, // Screen width
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      AppImages.pic, // Replace with your recipe image
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 155.sp, // Adjust the image height
                    ),
                    SizedBox(height: 8.sp),
                    Text(
                      recipeName,
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}

class Recipe {
  final String name;

  Recipe(this.name);
}

class RecipeCard extends StatelessWidget {
  final String name;
  final String image;
  final double rating;
  final VoidCallback ontap;

  const RecipeCard(
    this.name,
    this.rating,
    this.image, {
    super.key,
    required this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    String imageUrl =
        'https://recepie-recomm-flask.onrender.com/images/$image'; // Fixed this line

    return InkWell(
      onTap: ontap,
      child: Card(
        margin: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Image.network(
              imageUrl,
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
            ListTile(
              title: Text(name),
              trailing: IgnorePointer(
                child: RatingBar.builder(
                  initialRating: rating,
                  itemSize: 20,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    // This won't be called since we're ignoring user interaction
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
