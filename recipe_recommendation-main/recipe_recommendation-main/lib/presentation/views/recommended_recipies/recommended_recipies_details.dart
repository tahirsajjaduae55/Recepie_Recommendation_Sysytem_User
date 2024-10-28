import 'package:recipe_recomendation/app/index.dart';
import 'package:recipe_recomendation/presentation/common/app_bar_widget.dart';

import '../../../view_models/recipe_details_view_model.dart';
import '../../common/config.dart';

class RecommendedRecipesDetails extends StatelessWidget {
  final String name;
  final String cost;
  final String instructions;
  final String imagePath;
  const RecommendedRecipesDetails({
    super.key,
    required this.name,
    required this.cost,
    required this.instructions,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<RecipeDetailsViewModel>(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorManager.orange,
        onPressed: () {
          viewModel.showCustomModalBottomSheet(
            context,
            name,
            cost,
            instructions,
            imagePath,
            box!.get('firstName'),
            box!.get('email'),
          );
        },
        child: Icon(
          Icons.star,
          color: ColorManager.white,
        ),
      ),
      appBar: buildAppBarWidget(
        title: 'Details',
        appbarColor: ColorManager.red,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Utils.popinBoldText(
                'Made it and Serve',
                fontSize: 20.sp,
                color: ColorManager.red,
              ),
              20.spaceY,
              Container(
                width: 1.sw,
                decoration: BoxDecoration(
                  color: ColorManager.grey,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 200.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Image.network(
                        imagePath,
                        width: 1.sw,
                        height: 200.h,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Utils.popinSemBoldText(
                            'Recipe Name',
                            fontSize: 16.sp,
                          ),
                          Utils.popinMedText(name),
                          Utils.popinSemBoldText(
                            'Net cost (RS)',
                            fontSize: 16.sp,
                          ),
                          Utils.popinRegText(cost),
                          Utils.popinSemBoldText(
                            'Cooking Instructions',
                            fontSize: 16.sp,
                          ),
                          Utils.popinMedText(instructions),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
