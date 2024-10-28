import '../../../app/index.dart';
import '../../common/app_bar_widget.dart';

class RecipeDetailsView extends StatelessWidget {
  final String name;
  final String cost;
  final String image; // This will be replaced with the constructed URL
  final double rating;
  final String instructions;
  final String feedback;

  const RecipeDetailsView(
    this.name,
    this.cost,
    this.image, // Keep this parameter if you still need to pass it for other uses
    this.instructions,
    this.feedback,
    this.rating, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Construct the image URL using the name parameter
    String imageUrl = 'https://recepie-recomm-flask.onrender.com/images/$image';

    return Scaffold(
      appBar: buildAppBarWidget(
        title: 'Recipe Details',
        appbarColor: ColorManager.red,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: ColorManager.grey,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // Use the new image URL here
                    Image.network(
                      imageUrl, // Updated to use the constructed imageUrl
                      width: double.infinity,
                      height: 150,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey,
                          child: const Icon(Icons.error, color: Colors.red),
                        );
                      },
                    ),
                    10.spaceY,
                    Container(
                      height: 50.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        color: ColorManager.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: ColorManager.orange,
                                ),
                                5.spaceX,
                                Text(
                                  '$rating',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: ColorManager.black,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.money,
                                  color: ColorManager.black,
                                ),
                                5.spaceX,
                                Text(
                                  cost,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: ColorManager.black,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    10.spaceY,
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    10.spaceY,
                    Utils.popinSemBoldText(
                      'Instructions',
                      fontSize: 18.sp,
                    ),
                    Utils.popinSemBoldText(instructions),
                    10.spaceY,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
