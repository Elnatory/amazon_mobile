import 'package:amazon_mobile/data/provider/app_provider.dart';
import 'package:amazon_mobile/domain/model/products.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Subtotal extends StatelessWidget {
  final List<Product> products;
  final List<int> quantities; // Add list of quantities

  const Subtotal({Key? key, required this.products, required this.quantities})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(
      context,
    );
    double total = products.fold(0, (sum, product) {
      int index = products.indexOf(product);
      int quantity = quantities[index];

      double productTotal = (product.priceAfterDiscount ?? product.price ?? 0) *
          quantity.toDouble();
      return sum + productTotal;
    });

    return SizedBox(
      height: 50,
      child: Row(
        children: [
          const Text(
            "Subtotal",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 10),
          RichText(
            text: TextSpan(
              style: DefaultTextStyle.of(context).style,
              children: [
                TextSpan(
                  text: appProvider.totalPrice().toStringAsFixed(2),
                  style: const TextStyle(
                    fontSize: 25,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const TextSpan(
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
