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
    Provider.of<AppProvider>(context);
    // final productCart =context.watch<userProvider>().user.cart[widget.index];
    Size screenSize = Utils().getScreenSize();
    return Container(
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
              onTap: () {},
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
            child: Padding(
              padding: const EdgeInsets.only(top: 5),
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
                          // showMessage("Product deleted from favourite");
                        },
                        text: "Delete",
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      CustomSimpleRoundedButton(
                          onPressed: () {
                            AppProvider appProvider = Provider.of<AppProvider>(
                                context,
                                listen: false);
                            print('Before addCartProduct');
                            Product product = widget.product.copyWith(qty: qty);
                            appProvider.addCartProduct(product);
                            appProvider.removeFavProduct(widget.product);
                            print('After addCartProduct');
                          },
                          text: "Add To Cart"),
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
