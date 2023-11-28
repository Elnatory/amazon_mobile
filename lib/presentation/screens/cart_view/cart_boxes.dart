import 'package:amazon_mobile/domain/model/products.dart';
import 'package:amazon_mobile/presentation/resources/cloud_firestore.dart';
import 'package:amazon_mobile/presentation/resources/color_manager.dart';
import 'package:amazon_mobile/presentation/resources/utils.dart';
import 'package:amazon_mobile/presentation/widgets/poroduct_info.dart';
import 'package:amazon_mobile/presentation/widgets/rounded_button.dart';
import 'package:amazon_mobile/presentation/widgets/square_button.dart';
import 'package:flutter/material.dart';

class CartItemWidget extends StatelessWidget {
  final Product product;
  const CartItemWidget({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    return Container(
      padding: const EdgeInsets.all(22),
      height: screenSize.height / 2,
      width: screenSize.width,
      decoration: const BoxDecoration(
        color: ColorManager.backgroundColor,
        border: Border(
          bottom: BorderSide(color: Colors.grey, width: 1),
        ),
      ),
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: GestureDetector(
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //       builder: (context) =>
                //           ProductScreen(productModel: product)),
                // );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: screenSize.width / 3,
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Center(
                        child: Image.network(product.imageCover ?? ''),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(9.0),
                    child: ProductInformationWidget(
                      productName: product.title ?? '',
                      cost: product.price?.toDouble() ?? 0.0,
                      discount: product.priceAfterDiscount?.toDouble() ?? 0.0,
                      sellerName: product.brandName ?? '',
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              children: [
                CustomSquareButton(
                    onPressed: () {},
                    color: ColorManager.backgroundColor,
                    dimension: 40,
                    child: const Icon(Icons.remove)),
                CustomSquareButton(
                    onPressed: () {},
                    color: Colors.white,
                    dimension: 40,
                    child: const Text(
                      "0",
                      style: TextStyle(
                        color: ColorManager.activeCyanColor,
                      ),
                    )),
                CustomSquareButton(
                  color: ColorManager.backgroundColor,
                  dimension: 40,
                  onPressed: () {},
                  child: const Icon(Icons.add),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      CustomSimpleRoundedButton(
                        onPressed: () async {
                          if (product.id != null) {
                            await CloudFirestoreClass()
                                .removeProductFromCart(productId: product.id!);
                          } else {
                            print('Error: Invalid product ID');
                          }
                        },
                        text: "Delete",
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      CustomSimpleRoundedButton(
                          onPressed: () {}, text: "Save for later"),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "See more like this",
                        style: TextStyle(
                            color: ColorManager.activeCyanColor, fontSize: 12),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
