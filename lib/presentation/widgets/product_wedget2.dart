import 'package:amazon_mobile/data/provider/app_provider.dart';
import 'package:amazon_mobile/domain/model/products.dart';
import 'package:amazon_mobile/presentation/screens/main_view/product_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductWidget2 extends StatelessWidget {
  final Product product;

  const ProductWidget2({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void _showSnackBar(BuildContext context, String message) {
      final snackBar = SnackBar(content: Text(message));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    double? discountPercentage;
    if (product.price != null && product.priceAfterDiscount != null) {
      discountPercentage =
          ((product.priceAfterDiscount! / product.price!) * 100);
    }

    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        height: 100.0,
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    product.images?.isNotEmpty ?? false
                        ? product.images!.last
                        : '',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.7),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: Text(
                    //     'EGP ${product.price ?? 0}',
                    //     style: TextStyle(
                    //       fontSize: 14.0,
                    //       color: product.priceAfterDiscount != null
                    //           ? Colors.grey
                    //           : Colors.white,
                    //       decoration: product.priceAfterDiscount != null
                    //           ? TextDecoration.lineThrough
                    //           : TextDecoration.none,
                    //     ),
                    //   ),
                    // ),
                    // if (product.priceAfterDiscount != null)
                    //   Padding(
                    //     padding: const EdgeInsets.all(8.0),
                    //     child: Text(
                    //       'EGP ${product.priceAfterDiscount ?? 0}',
                    //       style: const TextStyle(
                    //         fontSize: 14.0,
                    //         color: Colors.white,
                    //       ),
                    //     ),
                    //   ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: SizedBox(
                          width: 120.0, // Set the desired width
                          child: ElevatedButton(
                            onPressed: () {
                              AppProvider appProvider =
                                  Provider.of<AppProvider>(context,
                                      listen: false);
                              print('Before addCartProduct');
                              appProvider.addCartProduct(product);
                              _showSnackBar(context, 'Added to Cart');
                              appProvider.removeFavProduct(product);
                              print('After addCartProduct');
                            },
                            style: ElevatedButton.styleFrom(
                              primary: const Color.fromRGBO(255, 90, 34, 1.0),
                            ),
                            child: Text(
                              'Add to Cart',
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (product.priceAfterDiscount != null &&
                discountPercentage != null)
              Positioned(
                top: 4,
                left: 4,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    '${discountPercentage.toStringAsFixed(0)}% OFF',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
