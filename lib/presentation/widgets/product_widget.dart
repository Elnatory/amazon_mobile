import 'package:amazon_mobile/domain/model/products.dart';
import 'package:flutter/material.dart';

class ProductWidget extends StatelessWidget {
  final Product product;

  const ProductWidget({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double? discountPercentage;
    if (product.price != null && product.priceAfterDiscount != null) {
      discountPercentage =
          ((product.priceAfterDiscount! / product.price!) * 100);
    }

    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                children: [
                  Container(
                    width: 100.0,
                    height: 100.0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        product.imageCover ?? '',
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  if (product.priceAfterDiscount != null && discountPercentage != null)
                    Positioned(
                      top: 4,
                      left: 4,
                      child: Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          '${discountPercentage.toStringAsFixed(0)}% OFF',
                          style: TextStyle(
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
            Padding(
              padding: const EdgeInsets.all(1.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'EGP ${product.price ?? 0}',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: product.priceAfterDiscount != null
                          ? Colors.grey
                          : Colors.black,
                      decoration: product.priceAfterDiscount != null
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                  if (product.priceAfterDiscount != null)
                    Text(
                      'EGP ${product.priceAfterDiscount ?? 0}',
                      style: TextStyle(
                        fontSize: 14.0,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
