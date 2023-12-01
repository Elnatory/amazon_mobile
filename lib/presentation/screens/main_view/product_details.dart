import 'package:amazon_mobile/data/provider/app_provider.dart';
import 'package:amazon_mobile/domain/model/products.dart';
import 'package:amazon_mobile/presentation/layout/search_layout2.dart';
import 'package:amazon_mobile/presentation/resources/cloud_firestore.dart';
import 'package:amazon_mobile/presentation/resources/color_manager.dart';
import 'package:amazon_mobile/presentation/resources/utils.dart';
import 'package:amazon_mobile/presentation/screens/checkout_view/checkout_screen.dart';
import 'package:amazon_mobile/presentation/screens/favourite_view/fav.dart';
import 'package:amazon_mobile/presentation/widgets/product_widget.dart';
import 'package:amazon_mobile/presentation/widgets/products_listview.dart';
import 'package:amazon_mobile/presentation/widgets/rating_stars.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';

class ProductDetails extends StatefulWidget {
  final Product singleProduct;

  const ProductDetails({Key? key, required this.singleProduct})
      : super(key: key);
  set query(String query) {}

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  bool isFavorited = false;
  final CloudFirestoreClass cloudFirestore = CloudFirestoreClass();

  CloudFirestoreClass getCloudFirestore() {
    return cloudFirestore;
  }

  int qty = 1;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  void _showSnackBar(BuildContext context, String message) {
  final snackBar = SnackBar(content: Text(message));
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(
      context,
    );
    double? discountPercentage;
    if (widget.singleProduct.price != null &&
        widget.singleProduct.priceAfterDiscount != null) {
      discountPercentage = ((widget.singleProduct.priceAfterDiscount! /
              widget.singleProduct.price!) *
          100);
    }
    Size screenSize = Utils().getScreenSize();
    return Scaffold(
      backgroundColor: ColorManager.text,
      appBar: SearchBarWidget2(
        onChanged: (value) => setState(() {
          widget.query = value;
        }),
        query: '',
        isReadOnly: false,
        hasBackButton: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        '${widget.singleProduct.ratingsAverage ?? 0.0}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      Row(
                        children: [
                          RatingStars(
                            rating: widget.singleProduct.ratingsAverage ?? 0.0,
                            size: 25.0,
                          ),
                          const SizedBox(width: 8.0),
                        ],
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => FavScreen()),
                      );
                    },
                    icon: Icon(
                      Icons.local_grocery_store_sharp,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              Text(
                widget.singleProduct.title ?? '',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8.0),
              Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  CarouselSlider(
                    options: CarouselOptions(
                      height: 400,
                      enlargeCenterPage: true,
                    ),
                    items: widget.singleProduct.images
                            ?.map((image) => Image.network(
                                  image,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                ))
                            .toList() ??
                        [],
                  ),
                  Positioned(
                    left: 4.0,
                    bottom: 4.0,
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          widget.singleProduct.isFavourite =
                              !(widget.singleProduct.isFavourite ?? false);

                          AppProvider appProvider =
                              Provider.of<AppProvider>(context, listen: false);

                          if (widget.singleProduct.isFavourite!) {
                            appProvider.addFavProduct(widget.singleProduct);
                            _showSnackBar(context, 'Added to Favorites');
                          } else {
                            appProvider.removeFavProduct(widget.singleProduct);
                            _showSnackBar(context, 'Removed from Favorites');
                          }
                        });
                      },
                      icon: Icon(
                        appProvider.getfavProductList
                                    .contains(widget.singleProduct) ??
                                false
                            ? Icons.favorite_rounded
                            : Icons.favorite_border_rounded,
                        color: widget.singleProduct.isFavourite ?? false
                            ? Colors.red
                            : null,
                      ),
                    ),
                  ),
                  Positioned(
                    right: 4.0,
                    top: 4.0,
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.share_outlined),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              if (widget.singleProduct.priceAfterDiscount != null &&
                  discountPercentage != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          '- ${discountPercentage.toStringAsFixed(0)}%',
                          style: const TextStyle(
                            fontSize: 25.0,
                            color: Colors.red,
                          ),
                        ),
                        const SizedBox(width: 8.0),
                        Text(
                          ' EGP ${widget.singleProduct.priceAfterDiscount ?? 0}.00',
                          style: const TextStyle(fontSize: 25.0),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'List Price: EGP ${widget.singleProduct.price ?? 0}.00',
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  ],
                )
              else
                Text(
                  'EGP ${widget.singleProduct.price ?? 0}.00',
                  style: const TextStyle(
                    fontSize: 25.0,
                  ),
                ),
              const SizedBox(height: 8.0),
              Text(
                'Details: ${widget.singleProduct.description ?? ''}',
                style: const TextStyle(fontSize: 15.0),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CupertinoButton(
                    onPressed: () {
                      if (qty > 1) {
                        setState(() {
                          qty--;
                        });
                      }
                      appProvider.increaseQuantity(qty);
                    },
                    padding: EdgeInsets.zero,
                    child: const CircleAvatar(
                      backgroundColor: Colors.orange,
                      child: Icon(
                        Icons.remove,
                        color: ColorManager.text,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12.0),
                  Text(qty.toString(), style: const TextStyle(fontSize: 20)),
                  const SizedBox(width: 12.0),
                  CupertinoButton(
                    onPressed: () {
                      setState(() {
                        qty++;
                      });
                      appProvider.increaseQuantity(qty);
                    },
                    padding: EdgeInsets.zero,
                    child: const CircleAvatar(
                      backgroundColor: Colors.orange,
                      child: Icon(
                        Icons.add,
                        color: ColorManager.text,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 35),
              Container(
                color: Colors.white,
                child: FutureBuilder<List<Product>>(
                  future: getCloudFirestore().getProducts(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
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
                          title: 'Shop by Products',
                          products: products,
                        ),
                      );
                    }
                  },
                ),
              ),
              
            ],
          ),
        ),
      ),
      persistentFooterButtons: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                // await CloudFirestoreClass().addProductToCart(
                //     product: widget.singleProduct, newQuantity: qty);
                // await CloudFirestoreClass().addProductToCart(
                //     product: widget.singleProduct);
                AppProvider appProvider =
                    Provider.of<AppProvider>(context, listen: false);
                print('Before addCartProduct');
                Product product = widget.singleProduct.copyWith(qty: qty);
                appProvider.addCartProduct(product);
                print('After addCartProduct');
                // FlutterToast.showToast(
                //     msg: "Added To Cart",
                //     toastLength: Toast.LENGTH_SHORT,
                //     gravity: ToastGravity.BOTTOM,
                //     timeInSecForIosWeb: 1,
                //     backgroundColor: ColorManager.text,
                //     textColor: Colors.white,
                //     fontSize: 16.0);
                Utils()
                    .showSnackBar(context: context, content: "Added To Cart");
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.orange,
                backgroundColor: Colors.white,
                side: const BorderSide(color: Colors.orange),
              ),
              child: const Text('ADD TO CART'),
            ),
            const SizedBox(width: 24.0),
            SizedBox(
              height: 38,
              width: 140,
              child: ElevatedButton(
                onPressed: () async {
                  // await CloudFirestoreClass()
                  //     .addProductToOrders(product: widget.singleProduct);
                  // Get.to(FavScreen());
                  Product product = widget.singleProduct.copyWith(qty: qty);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Checkout(product: product)),
                  );
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.orange,
                  side: const BorderSide(color: Colors.orange),
                ),
                child: const Text('BUY'),
              ),
            )
          ],
        ),
      ],
    );
  }
}
