import 'package:amazon_mobile/domain/model/products.dart';
import 'package:amazon_mobile/presentation/layout/search_layout.dart';
import 'package:amazon_mobile/presentation/resources/cloud_firestore.dart';
import 'package:amazon_mobile/presentation/screens/main_view/product_details.dart';
import 'package:amazon_mobile/presentation/widgets/product_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class SearchScreen extends StatefulWidget {
  String query;

  SearchScreen({Key? key, required this.query}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final CloudFirestoreClass cloudFirestore = CloudFirestoreClass();

  CloudFirestoreClass getCloudFirestore() {
    return cloudFirestore;
  }

  late List<Product> allProducts;
  late List<Product> filteredProducts;

  @override
  void initState() {
    super.initState();
    allProducts = [];
    filteredProducts = [];

    // Fetch all products
    getCloudFirestore().getProducts().then((products) {
      setState(() {
        allProducts = products;
        filterProducts();
      });
    });
  }

  void filterProducts() {
    // If the query is empty, don't display any products
    if (widget.query.isEmpty) {
      filteredProducts = [];
    } else {
      // Filter products based on the query
      filteredProducts = allProducts
          .where((product) => product.title!
              .toLowerCase()
              .startsWith(widget.query.toLowerCase()))
          .toList();
    }
  }

  @override
  void didUpdateWidget(covariant SearchScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.query != widget.query) {
      filterProducts();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchBarWidget(
        isReadOnly: false,
        hasBackButton: true,
        query: '',
        onChanged: (newQuery) {
          setState(() {
            widget.query = newQuery;
            filterProducts();
          });
        },
      ),
      backgroundColor: Colors.white,
      body: ListView.builder(
        itemCount: filteredProducts.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(filteredProducts[index].title!),
            onTap: () {
              Get.to(() => ProductDetails(
                    singleProduct: filteredProducts[index],
                  ));
            },
          );
        },
      ),
    );
  }
}
