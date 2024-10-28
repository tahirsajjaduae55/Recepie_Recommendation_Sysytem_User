import 'package:recipe_recomendation/app/index.dart';
import 'package:recipe_recomendation/presentation/views/recommended_recipies/recommended_recipies_details.dart';

import '../../common/app_bar_widget.dart';
import '../../utils/api_services.dart';

class RecommendedRecipes extends StatelessWidget {
  const RecommendedRecipes({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<RecipeViewModel>(context);
    return Scaffold(
      appBar: buildAppBarWidget(
        appbarColor: ColorManager.red,
        title: 'Recommended Recipies',
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Utils.popinSemBoldText(
              viewModel.recipeModel!.response!.isEmpty
                  ? 'Recipe not found !!!'
                  : 'Here are some\nRecommended recipes',
              fontSize: 16.sp,
            ),
            20.spaceY,
            Expanded(
              child: viewModel.recipeModel!.response!.isEmpty
                  ? const Text('no recipe found')
                  : ListView.separated(
                      shrinkWrap: true,
                      itemCount: viewModel.recipeModel!.response!.length,
                      itemBuilder: (BuildContext context, int index) {
                        final recipe = viewModel.recipeModel!.response![index];
                        final imageUrl = recipe.imagePath;
                        print('this is image link: $imageUrl');

                        return ListTile(
                          onTap: () {
                            viewModel.selectRecipe(recipe.recipeName!);
                            Get.to(
                              RecommendedRecipesDetails(
                                name: recipe.recipeName!,
                                cost: recipe.netPrice.toString(),
                                instructions: recipe.cookingInstruction!,
                                imagePath:
                                    'https://recepie-recomm-flask.onrender.com/images/$imageUrl',
                              ),
                            );
                          },
                          tileColor: ColorManager.grey,
                          title: Text(recipe.recipeName ?? ''),
                          leading: Image.network(
                            'https://recepie-recomm-flask.onrender.com/images/$imageUrl',
                            fit: BoxFit.cover,
                            height: 40.h,
                            width: 50.w,
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return 10.spaceY;
                      },
                    ),
            )
          ],
        ),
      ),
    );
  }
}
