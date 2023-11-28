import 'package:amazon_mobile/domain/model/products.dart';
import 'package:amazon_mobile/presentation/layout/search_layout.dart';
import 'package:amazon_mobile/presentation/resources/cloud_firestore.dart';
import 'package:amazon_mobile/presentation/resources/color_manager.dart';
import 'package:amazon_mobile/presentation/resources/constants.dart';
import 'package:amazon_mobile/presentation/resources/utils.dart';
import 'package:amazon_mobile/presentation/screens/cart_view/cart_boxes.dart';
import 'package:amazon_mobile/presentation/screens/cart_view/cart_subtotal.dart';
import 'package:amazon_mobile/presentation/widgets/main_button.dart';
import 'package:amazon_mobile/presentation/widgets/user_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //==========================================================appBar: AppBar
      appBar: SearchBarWidget(
        hasBackButton: false,
        isReadOnly: true,
        onChanged: (String value) {},
        query: '',
      ),
      body: Center(
        child: Stack(
          children: [
            Column(
              children: [
                const SizedBox(
                  height: AppBarHeight / 2,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: StreamBuilder(
                        stream: CloudFirestoreClass().getCartProductsStream(),
                        builder:
                            (context, AsyncSnapshot<List<Product>> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return SizedBox(
                              height: 30,
                              child: CircularProgressIndicator(),
                            );
                          } else {
                            return SizedBox(
                              height: 30,
                              child: Subtotal(products: snapshot.data ?? []),
                            );
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.check_circle_outline,
                            color: Colors.green,
                          ),
                          const SizedBox(
                            width: 6,
                          ),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Your order qualifies for free delivery',
                                  style: TextStyle(
                                      color: Colors.teal[900],
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                Row(
                                  children: [
                                    const Text(
                                      'Choose this option at checkout.',
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        // Handle the 'See details' button tap
                                      },
                                      child: Text(
                                        'See details',
                                        style: TextStyle(
                                          color: Colors.blue[900],
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: StreamBuilder(
                    stream: CloudFirestoreClass().getCartProductsStream(),
                    builder: (context, AsyncSnapshot<List<Product>> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CustomMainButton(
                          child: const Text("Loading"),
                          color: ColorManager.yellowColor,
                          isLoading: true,
                          onPressed: () {},
                        );
                      } else {
                        return CustomMainButton(
                          color: ColorManager.yellowColor,
                          isLoading: false,
                          onPressed: () async {
                            // Implement your buy functionality here
                            Utils().showSnackBar(
                                context: context, content: "Done");
                          },
                          child: Text(
                            "Proceed to buy (${snapshot.data!.length}) items",
                            style: const TextStyle(color: Colors.black),
                          ),
                        );
                      }
                    },
                  ),
                ),
                Expanded(
                  child: StreamBuilder(
                    stream: CloudFirestoreClass().getCartProductsStream(),
                    builder: (context, AsyncSnapshot<List<Product>> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Container();
                      } else {
                        return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            Product model = snapshot.data![index];
                            return CartItemWidget(product: model);
                          },
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
            const UserDetailsBar(
              offset: 0,
            ),
          ],
        ),
      ),
    );
  }
}
