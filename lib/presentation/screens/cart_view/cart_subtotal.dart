import 'package:amazon_mobile/domain/model/products.dart';
import 'package:flutter/material.dart';

class Subtotal extends StatelessWidget {
  final List<Product> products;

  Subtotal({Key? key, required this.products}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double total = products.fold(0, (sum, product) {
      int productTotal = (product.priceAfterDiscount ?? product.price ?? 0) * ( 1);
      return sum + productTotal;
    });

    return Container(
      height: 50,
      child: Row(
        children: [
          Text(
            "Subtotal",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(width: 10),
          RichText(
            text: TextSpan(
              style: DefaultTextStyle.of(context).style,
              children: [
                TextSpan(
                  text: total.toStringAsFixed(2),
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: ' EGP',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
