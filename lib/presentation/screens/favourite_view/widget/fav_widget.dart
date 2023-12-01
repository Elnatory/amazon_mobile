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

class FavItemWidget extends StatefulWidget {
  final Product product;
  const FavItemWidget({Key? key, required this.product}) : super(key: key);

  @override
  _FavItemWidgetState createState() => _FavItemWidgetState();
}

class _FavItemWidgetState extends State<FavItemWidget> {
  int quantity = 1;
  double calculateTotalCost() {
    return (widget.product.price?.toDouble() ?? 0.0) * quantity;
  }

  // @override
  // void initState() {
  //   super.initState();
  //   quantity = widget.product.qty ?? 1;
  //   setState(() {
  //     quantity = widget.product.qty ?? 1;
  //   });
  // }
  int qty = 1;
  @override
  Widget build(BuildContext context) {
    void _showSnackBar(BuildContext context, String message) {
      final snackBar = SnackBar(content: Text(message));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    Provider.of<AppProvider>(context);
    // final productCart =context.watch<userProvider>().user.cart[widget.index];
    Size screenSize = Utils().getScreenSize();
    return Container(
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
            flex: 2,
            child: GestureDetector(
              onTap: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: screenSize.width / 2,
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Center(
                        child: Image.network(widget.product.imageCover ?? ''),
                      ),
                    ),
                  ),
                  const SizedBox(
                      width: 8.0), // Add some space between image and title
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: ProductInformationWidget(
                        productName: widget.product.title ?? '',
                        cost: calculateTotalCost(),
                        discount:
                            widget.product.priceAfterDiscount?.toDouble() ??
                                0.0,
                        sellerName: widget.product.brandName ?? '',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all( 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      CustomSimpleRoundedButton(
                        onPressed: () {
                          AppProvider appProvider =
                              Provider.of<AppProvider>(context, listen: false);
                          appProvider.removeFavProduct(widget.product);
                          print('Delete');
                          _showSnackBar(context, 'Deleted from Favorites');
                        },
                        text: "Delete",
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      CustomSimpleRoundedButton(
                        onPressed: () {
                          AppProvider appProvider =
                              Provider.of<AppProvider>(context, listen: false);
                          print('Before addCartProduct');
                          Product product = widget.product.copyWith(qty: qty);
                          appProvider.addCartProduct(product);
                          _showSnackBar(context, 'Added to Cart');
                          appProvider.removeFavProduct(widget.product);
                          print('After addCartProduct');
                        },
                        text: "Add To Cart",
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
