import 'package:amazon_mobile/data/provider/app_provider.dart';
import 'package:flutter/material.dart';
import 'package:amazon_mobile/domain/model/products.dart';
import 'package:amazon_mobile/presentation/resources/cloud_firestore.dart';
import 'package:amazon_mobile/presentation/resources/color_manager.dart';
import 'package:amazon_mobile/presentation/resources/utils.dart';
import 'package:amazon_mobile/presentation/widgets/poroduct_info.dart';
import 'package:amazon_mobile/presentation/widgets/rounded_button.dart';
import 'package:amazon_mobile/presentation/widgets/square_button.dart';
import 'package:provider/provider.dart';

class CartItemWidget extends StatefulWidget {
  final Product product;
  const CartItemWidget({Key? key, required this.product}) : super(key: key);

  @override
  _CartItemWidgetState createState() => _CartItemWidgetState();
}

class _CartItemWidgetState extends State<CartItemWidget> {
  int quantity = 1;
  double calculateTotalCost() {
    return (widget.product.price?.toDouble() ?? 0.0) * quantity;
  }

  @override
  void initState() {
    super.initState();
    quantity = widget.product.qty ?? 1;
    setState(() {
      quantity = widget.product.qty ?? 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    // final productCart =context.watch<userProvider>().user.cart[widget.index];
    Size screenSize = Utils().getScreenSize();
    return Container(
      padding: const EdgeInsets.all(8),
      height: screenSize.height / 3,
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
                        child: Image.network(widget.product.imageCover ?? ''),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(9.0),
                    child: ProductInformationWidget(
                      productName: widget.product.title ?? '',
                      cost: calculateTotalCost(),
                      discount:
                          widget.product.priceAfterDiscount?.toDouble() ?? 0.0,
                      sellerName: widget.product.brandName ?? '',
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
                  onPressed: () async {
                    if (quantity > 1) {
                      setState(() {
                        quantity--;
                      });
                      appProvider.updateQty(widget.product, quantity);

                      if (widget.product.id != null) {
                        await CloudFirestoreClass().removeProductFromCart(
                            productId: widget.product.id!);
                      } else {
                        print('Error: Invalid product ID');
                      }
                    }
                  },
                  color: ColorManager.backgroundColor,
                  dimension: 33,
                  child: const Icon(Icons.remove),
                ),
                CustomSquareButton(
                  onPressed: () {},
                  color: Colors.white,
                  dimension: 33,
                  child: Text(
                    quantity.toString(),
                    style: const TextStyle(
                      color: ColorManager.activeCyanColor,
                    ),
                  ),
                ),
                CustomSquareButton(
                  color: ColorManager.backgroundColor,
                  dimension: 33,
                  onPressed: () async {
                    setState(() {
                      quantity++;
                    });
                    appProvider.updateQty(widget.product, quantity);
                    await CloudFirestoreClass().addProductToCart(
                      product: Product(
                        createdAt: widget.product.createdAt,
                        description: widget.product.description,
                        id: widget.product.id,
                        imageCover: widget.product.imageCover,
                        images: widget.product.images,
                        price: widget.product.price,
                        priceAfterDiscount: widget.product.priceAfterDiscount,
                        quantity: quantity,
                        ratingsAverage: widget.product.ratingsAverage,
                        ratingsQuantity: widget.product.ratingsQuantity,
                        slug: widget.product.slug,
                        sold: widget.product.sold,
                        title: widget.product.title,
                        updatedAt: widget.product.updatedAt,
                        brandId: widget.product.brandId,
                        brandImage: widget.product.brandImage,
                        brandName: widget.product.brandName,
                        brandSlug: widget.product.brandSlug,
                        qty: 1,
                        isFavourite: widget.product.isFavourite,
                      ),
                    );
                  },
                  child: const Icon(Icons.add),
                ),
                const SizedBox(
                        width: 5,
                      ),
                CustomSimpleRoundedButton(
                        // onPressed: () async {
                        //   if (widget.product.id != null) {
                        //     await CloudFirestoreClass().removeProductFromCart(
                        //         productId: widget.product.id!);
                        //   } else {
                        //     print('Error: Invalid product ID');
                        //   }
                        // },
                        onPressed: () {
                          AppProvider appProvider =
                              Provider.of<AppProvider>(context, listen: false);
                          appProvider.removeCartProduct(widget.product);
                          print('Delete');
                        },
                        text: "Delete",
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      CustomSimpleRoundedButton(
                          onPressed: () {
                            // AppProvider appProvider =
                            //     Provider.of<AppProvider>(context,
                            //         listen: false);
                            // appProvider.addFavProduct(widget.product);
                            if (!appProvider.getfavProductList
                                .contains(widget.product)) {
                              appProvider.addFavProduct(widget.product);
                            } else {
                              appProvider.removeFavProduct(widget.product);
                            }
                          },
                          text: appProvider.getfavProductList
                                  .contains(widget.product)
                              ? "Remove from Wishlist"
                              : 'Save for later'),
              ],
            ),
          ),
//           const Expanded(
//   flex: 1,
//   child: Column(
//     mainAxisSize: MainAxisSize.min,
//     children: [
//       Align(
//         alignment: Alignment.centerLeft,
//         child: Text(
//           "See more like this",
//           style: TextStyle(
//             color: ColorManager.activeCyanColor,
//             fontSize: 12,
//           ),
//         ),
//       ),
//     ],
//   ),
// ),


        ],
      ),
    );
  }
}
