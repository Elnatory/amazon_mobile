import 'package:amazon_mobile/data/provider/app_provider.dart';
import 'package:amazon_mobile/domain/model/products.dart';
import 'package:amazon_mobile/presentation/layout/search_layout.dart';
import 'package:amazon_mobile/presentation/resources/cloud_firestore.dart';
import 'package:amazon_mobile/presentation/resources/color_manager.dart';
import 'package:amazon_mobile/presentation/resources/constants.dart';
import 'package:amazon_mobile/presentation/resources/utils.dart';
import 'package:amazon_mobile/presentation/screens/cart_view/cart_boxes.dart';
import 'package:amazon_mobile/presentation/screens/cart_view/cart_subtotal.dart';
import 'package:amazon_mobile/presentation/screens/checkout_view/checkout_screen.dart';
import 'package:amazon_mobile/presentation/screens/favourite_view/fav.dart';
import 'package:amazon_mobile/presentation/widgets/main_button.dart';
import 'package:amazon_mobile/presentation/widgets/product_widget.dart';
import 'package:amazon_mobile/presentation/widgets/products_listview.dart';
import 'package:amazon_mobile/presentation/widgets/user_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
     final CloudFirestoreClass cloudFirestore = CloudFirestoreClass();

  CloudFirestoreClass getCloudFirestore() {
    return cloudFirestore;
  }
    AppProvider appProvider = Provider.of<AppProvider>(
      context,
    );
    return Scaffold(
      backgroundColor: Colors.white,
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
                            List<int> quantities = List<int>.filled(
                              snapshot.data?.length ?? 0,
                              1,
                            );
                            return SizedBox(
                              height: 30,
                              child: Subtotal(
                                products: snapshot.data ?? [],
                                quantities: quantities,
                              ),
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
                            Icons.check_circle,
                            color: Color.fromARGB(255, 0, 123, 4),
                          ),
                          const SizedBox(
                            width: 6,
                          ),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Your order qualifies for FREE Shipping',
                                  style: TextStyle(
                                    color: Colors.teal[700],
                                    fontSize: 18,
                                  ),
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
                  padding: const EdgeInsets.only(
                    top: 8.0,
                    left: 8.0,
                    right: 8.0,
                    bottom: 0.0,
                  ),
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
                        int totalQuantity = Provider.of<AppProvider>(context)
                            .calculateTotalQuantity();
                        return CustomMainButton(
                          color: ColorManager.yellowColor,
                          isLoading: false,
                          onPressed: () async {
                            // await CloudFirestoreClass().buyAllItemsInCart();
                            //     Utils().showSnackBar(
                            //         context: context, content: "Done");
                            //     Future.delayed(Duration(seconds: 2), () {
                            //       Navigator.push(
                            //         context,
                            //         MaterialPageRoute(
                            // builder: (context) =>
                            //     Checkout(product: widget.singleProduct)),
                            //       );
                            //     }
                            //     );

                            // appProvider.clearBuyProduct();
                            ////////////////////////////////////////////////////
                            appProvider.addbuyProductCartList();
                            // appProvider.clearCartList();

                            print(
                                'Original List: ${appProvider.getCartProductList}');
                            print(
                                'Products List: ${appProvider.getBuyProductList}');

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Checkout(
                                  products: appProvider.getBuyProductList,
                                ),
                              ),
                            );

                            // appProvider.clearBuyProduct();
                          },
                          child: SizedBox(
                            width: 200,
                            child: Text(
                              "Proceed to Buy (${totalQuantity} item)",
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 18.0),
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ),
                
                Expanded(
  child: appProvider.getCartProductList.isEmpty
    ? Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 80,
          ),
          Text(
            'Your Cart is Empty!',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FavScreen(),
                ),
              );
            },
            child: Text(
              'Go to Wishlist',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 16,
              ),
            ),
          ),
          SizedBox(
            height: 100,
          ),
          FutureBuilder<List<Product>>(
            future: getCloudFirestore().getProducts(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                List<Product> products = snapshot.data!;
                List<Widget> productWidgets = products.map((product) {
                  return ProductWidget(product: product);
                }).toList();

                return Transform.translate(
                  offset: const Offset(0, -40),
                  child: ProductsShowcaseListView(
                    title: 'Products you may like',
                    products: products,
                  ),
                );
              }
            },
          ),
        ],
      ),
    )
    : ListView.builder(
      itemCount: appProvider.getCartProductList.length,
      itemBuilder: (context, index) {
        Product model = appProvider.getCartProductList[index];
        return CartItemWidget(product: model);
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