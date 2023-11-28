import 'package:amazon_mobile/domain/model/products.dart';
import 'package:amazon_mobile/presentation/layout/search_layout2.dart';
import 'package:amazon_mobile/presentation/resources/cloud_firestore.dart';
import 'package:amazon_mobile/presentation/resources/color_manager.dart';
import 'package:amazon_mobile/presentation/resources/utils.dart';
import 'package:amazon_mobile/presentation/widgets/product_widget.dart';
import 'package:amazon_mobile/presentation/widgets/products_listview.dart';
import 'package:amazon_mobile/presentation/widgets/rating_stars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    double? discountPercentage;
    if (widget.singleProduct.price != null &&
        widget.singleProduct.priceAfterDiscount != null) {
      discountPercentage = ((widget.singleProduct.priceAfterDiscount! /
              widget.singleProduct.price!) *
          100);
    }

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
            crossAxisAlignment: CrossAxisAlignment.start,
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
                  RatingStars(
                    rating: widget.singleProduct.ratingsAverage ?? 0.0,
                    size: 25.0,
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
                  Image.network(
                    widget.singleProduct.imageCover ?? '',
                    width: double.infinity,
                    fit: BoxFit.cover,
                    height: 400,
                  ),
                  Positioned(
                    left: 4.0,
                    bottom: 4.0,
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          isFavorited = !isFavorited;
                        });
                      },
                      icon: Icon(
                        isFavorited
                            ? Icons.favorite_rounded
                            : Icons.favorite_border_rounded,
                        color: isFavorited ? Colors.red : null,
                      ),
                    ),
                  ),
                  Positioned(
                    right: 4.0,
                    top: 4.0,
                    child: IconButton(
                      onPressed: () {
                        
                      },
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
                await CloudFirestoreClass()
                    .addProductToCart(product: widget.singleProduct);
                Utils()
                    .showSnackBar(context: context, content: "Added To Cart");
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.orange, backgroundColor: Colors.white,
                side: const BorderSide(color: Colors.orange),
              ),
              child: const Text('ADD TO CART'),
            ),
            const SizedBox(width: 24.0),
            SizedBox(
              height: 38,
              width: 140,
              child: ElevatedButton(
                onPressed: () {
                  
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Colors.orange,
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
