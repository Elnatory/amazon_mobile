import 'package:amazon_mobile/domain/model/category.dart';
import 'package:amazon_mobile/presentation/screens/main_view/category_screen.dart';
import 'package:amazon_mobile/presentation/widgets/categories_list.dart';
import 'package:flutter/material.dart';

class CategoryShowcaseListView extends StatelessWidget {
  final String title;
  final List<Category> categories;

  const CategoryShowcaseListView({
    Key? key,
    required this.title,
    required this.categories,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> categoryWidgets = categories.map((category) {
      return CategoryWidget(category: category);
    }).toList();

    Size screenSize = MediaQuery.of(context).size;
    double height = screenSize.height / 4;
    double titleHeight = 25;

    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8),
      height: height,
      width: screenSize.width,
      color: Colors.transparent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            height: titleHeight,
            child: Row(
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 14),
                  child: Text(
                    "Show more",
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: height - (titleHeight + 26),
            width: screenSize.width,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: categoryWidgets,
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryWidget extends StatelessWidget {
  final Category category;

  const CategoryWidget({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CategoryProductsPage(category: category),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.all(8.0),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.2,
          height: 200.0,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(category.image),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}

