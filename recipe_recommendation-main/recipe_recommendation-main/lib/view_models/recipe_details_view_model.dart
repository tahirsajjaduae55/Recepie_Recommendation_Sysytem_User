import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:recipe_recomendation/app/index.dart';

import '../presentation/common/app_button.dart';
import '../presentation/common/textfield_widget.dart';

class RecipeDetailsViewModel extends ChangeNotifier {
  void showCustomModalBottomSheet(
    BuildContext context,
    String name,
    String cost,
    String instructions,
    String imagePath,
    String userName,
    String emaail,
  ) {
    TextEditingController feedBackCtrl = TextEditingController();
    // double? newRating;

    String ratingAsString = '0.0';
    bool isLoading = false;
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 500.h,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 16.0),
              TextfieldWidget(
                hintText: 'Your feedback ',
                controller: feedBackCtrl,
                onChange: (newValue) {
                  ratingAsString = analyzeReview(newValue);
                },
              ),
              10.spaceY,
              IgnorePointer(
                child: RatingBar.builder(
                  initialRating: double.parse(ratingAsString),
                  itemSize: 40,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    // // newRating = rating;
                    ratingAsString = rating.toString();
                    notifyListeners(); // Convert to a string with one decimal place
                  },
                ),
              ),
              const SizedBox(height: 16.0),
              isLoading
                  ? const SpinKitCircle(
                      color: Colors.red,
                      size: 20,
                    )
                  : AppButton(
                      onPress: () async {
                        isLoading = true;
                        notifyListeners();
                        String feedback = feedBackCtrl.text;

                        if (feedBackCtrl.text.isEmpty) {
                          Utils.toastMessage(
                              'Please Provide a feedback with rating');
                        } else {
                          final user = FirebaseAuth.instance.currentUser;
                          if (user != null) {
                            final recipeDetails = {
                              'name': name,
                              'cost': cost,
                              'instructions': instructions,
                              'imagePath': imagePath,
                              'rating': ratingAsString,
                              'feedback': feedback,
                              'userName': userName,
                              'email': emaail,
                            };

                            final DatabaseReference recipeRef = FirebaseDatabase
                                .instance
                                .ref()
                                .child('recipe_ratings');

                            await recipeRef.push().set(recipeDetails);
                            Get.back();
                          }
                          isLoading = false;
                          notifyListeners();
                        }
                        // Save the user's rating, feedback, and recipe details to Firebase Realtime Database
                      },
                      text: ('Submit'),
                    ),
            ],
          ),
        );
      },
    );
  }

  String analyzeReview(String review) {
    // This is a simplified example. You might want to expand and customize the list of negative and positive words.
    List<String> negativeWords = [
      'bad',
      'poor',
      'not good',
      'unpleasant',
      'terrible',
      'awful',
      'horrible',
      'disappointing',
      'mediocre',
      'lousy',
      'inferior',
      'abysmal',
      'dismal',
      'unappealing',
      'negative',
      'displeasing',
      'subpar',
      'flawed',
      'deficient',
      'unsatisfactory',
      'unimpressive',
      'unfavorable',
      'unfortunate',
      'displeasing',
      'problematic',
    ];

    List<String> positiveWords = [
      'good',
      'excellent',
      'awesome',
      'fantastic',
      'outstanding',
      'wonderful',
      'superb',
      'terrific',
      'marvelous',
      'splendid',
      'exceptional',
      'delightful',
      'fabulous',
      'positive',
      'satisfying',
      'impressive',
      'pleasing',
      'exemplary',
      'commendable',
      'stellar',
      'superior',
      'amazing',
      'great',
      'phenomenal',
    ];

    // Convert the review to lowercase for case-insensitive matching
    review = review.toLowerCase();

    // Check for the presence of negative words
    if (negativeWords.any((word) => review.contains(word))) {
      return '1.0';
    }

    // Check for the presence of positive words
    if (positiveWords.any((word) => review.contains(word))) {
      return '5.0';
    }

    // Default to a neutral rating if no clear sentiment is detected
    return '3.0';
  }
}
