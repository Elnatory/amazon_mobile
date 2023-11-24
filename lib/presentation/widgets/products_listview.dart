import 'package:amazon_mobile/domain/model/products.dart';
import 'package:amazon_mobile/presentation/resources/color_manager.dart';
import 'package:amazon_mobile/presentation/resources/utils.dart';
import 'package:amazon_mobile/presentation/widgets/product_widget.dart';
import 'package:flutter/material.dart';

class ProductsShowcaseListView extends StatelessWidget {
  final String title;
  final List<Product> products;

  const ProductsShowcaseListView({
    Key? key,
    required this.title,
    required this.products,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> productWidgets = products.map((product) {
      return ProductWidget(product: product);
    }).toList();

    Size screenSize = Utils().getScreenSize();
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
                    style: TextStyle(color: ColorManager.activeCyanColor),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: height - (titleHeight + 26),
            width: screenSize.width,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: productWidgets,
            ),
          ),
        ],
      ),
    );
  }
}
