import 'package:amazon_mobile/data/provider/app_provider.dart';
import 'package:amazon_mobile/domain/model/products.dart';
import 'package:amazon_mobile/presentation/layout/search_layout2.dart';
import 'package:amazon_mobile/presentation/resources/cloud_firestore.dart';
import 'package:amazon_mobile/presentation/resources/color_manager.dart';
import 'package:amazon_mobile/presentation/screens/order_view/order_screen.dart';
import 'package:amazon_mobile/presentation/widgets/main_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Checkout extends StatefulWidget {
  final Product? product;
  final List<Product>? products;
  const Checkout({super.key, this.product, this.products});
  set query(String query) {}

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  int groupValue = 1;
  @override
  Widget build(BuildContext context) {
    print('Received Products: ${widget.products}');
    final CloudFirestoreClass cloudFirestore = CloudFirestoreClass();
    AppProvider appProvider = Provider.of<AppProvider>(
      context,
    );
    print("Original List: ${appProvider.getBuyProductList}");
    return Scaffold(
      backgroundColor: ColorManager.backgroundColor,
      appBar: SearchBarWidget2(
        onChanged: (value) => setState(() {
          widget.query = value;
        }),
        query: '',
        isReadOnly: false,
        hasBackButton: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: lightBackgroundaGradient,
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
            width: MediaQuery.of(context)
                .size
                .width, // Set the width to the screen width
            padding: const EdgeInsets.all(4.0),
            child: Text(
              'Checkout Page',
              style: TextStyle(
                color: Colors.grey[900],
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
            const SizedBox(
              height: 36.0,
            ),
            Container(
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(
                  color: ColorManager.activeCyanColor,
                  width: 3.0,
                ),
              ),
              width: double.infinity,
              child: Row(
                children: [
                  Radio(
                    value: 1,
                    groupValue: groupValue,
                    onChanged: (value) {
                      setState(() {
                        groupValue = value!;
                      });
                    },
                  ),
                  Icon(Icons.attach_money_sharp),
                  const SizedBox(
                    width: 12.0,
                  ),
                  const Text(
                    "Cach on Delivery",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 5.0,
            ),
            Container(
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(
                  color: ColorManager.activeCyanColor,
                  width: 3.0,
                ),
              ),
              width: double.infinity,
              child: Row(
                children: [
                  Radio(
                    value: 2,
                    groupValue: groupValue,
                    onChanged: (value) {
                      setState(() {
                        groupValue = value!;
                      });
                    },
                  ),
                  const Icon(Icons.money),
                  const SizedBox(
                    width: 12.0,
                  ),
                  const Text(
                    "Pay Online",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24.0),
            CustomMainButton(
              color: ColorManager.yellowColor,
              isLoading: false,
              onPressed: () async {
                // appProvider.getBuyProductList.clear();

                if (widget.product != null) {
                  appProvider.addbuyProduct(widget.product!);
                }

                // bool value = await cloudFirestore.uploadOrderProductFirebase(
                //     appProvider.getBuyProductList,
                //     appProvider,
                //     context,
                //     groupValue == 1 ? "Cash on Delivery" : "Paid");
                // appProvider.clearBuyProduct();
                // if (value) {
                //   Future.delayed(Duration(seconds: 2), () {
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(builder: (context) => OrderScreen()),
                //     );
                //   });
                //   appProvider.clearCart();
                //   appProvider.clearFavourite();
                //   // appProvider.resetQuantity();
                //   Navigator.push(
                //     context,
                //     MaterialPageRoute(builder: (context) => OrderScreen()),
                //   );
                // }

                if (appProvider.getBuyProductList.isNotEmpty) {
                  bool value = await cloudFirestore.uploadOrderProductFirebase(
                    appProvider.getBuyProductList,
                    appProvider,
                    context,
                    groupValue == 1 ? "Cash on Delivery" : "Paid",
                  );

                  if (value) {
                    print("Navigation Start");
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => OrderScreen()),
                    ).then((result) {
                      print("Navigation Completed with result: $result");
                    }).catchError((error) {
                      print("Navigation Error: $error");
                    });
                    print("Navigation End");
                    appProvider.clearBuyProduct();
                    appProvider.clearCart();
                    appProvider.clearFavourite();
                    // appProvider.resetQuantity();
                  }
                } else {
                  print("Error: The product list is empty!");
                }
              },
              child: const SizedBox(
                width: 100,
                child: Text(
                  "Continue",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
