import 'package:amazon_mobile/presentation/resources/color_manager.dart';
import 'package:amazon_mobile/presentation/resources/utils.dart';
import 'package:amazon_mobile/presentation/widgets/cost.dart';
import 'package:flutter/material.dart';

class ProductInformationWidget extends StatelessWidget {
  final String productName;
  final double cost;
  final double? discount;
  final String sellerName;

  const ProductInformationWidget({
    Key? key,
    required this.productName,
    required this.cost,
    this.discount,
    required this.sellerName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    SizedBox spaceThingy = const SizedBox(
      height: 7,
    );
    
    double percentageDiscount = (discount != null && discount! > 0)
        ? ((cost - discount!) / cost) * 100
        : 0.0;

    return SizedBox(
      width: screenSize.width / 2,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              productName,
              maxLines: 2,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
                letterSpacing: 0.9,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          spaceThingy,
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 7),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (discount != null)
                    RichText(
                      text: TextSpan(
                        children: [
                          // TextSpan(
                          //   text: 'EGP ',
                          //   style: TextStyle(
                          //     color: Colors.red,
                          //     fontSize: 12,
                          //     decoration: TextDecoration.lineThrough,
                          //   ),
                          // ),
                          // TextSpan(
                          //   text: cost.toStringAsFixed(2),
                          //   style: TextStyle(
                          //     color: Colors.red,
                          //     fontSize: 12,
                          //     decoration: TextDecoration.lineThrough,
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  CostWidget(color: Colors.black, cost: cost),
                  if (discount != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${discount!.toStringAsFixed(2)} EGP',
                            style: const TextStyle(
                              color: Colors.red,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            '- ${percentageDiscount.toStringAsFixed(2)}% off',
                            style: const TextStyle(
                              color: Colors.green,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
          spaceThingy,
          Align(
            alignment: Alignment.centerLeft,
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Sold by ",
                    style: TextStyle(color: Colors.grey[700], fontSize: 14),
                  ),
                  TextSpan(
                    text: sellerName,
                    style: const TextStyle(
                      color: ColorManager.activeCyanColor,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
