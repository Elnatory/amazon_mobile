import 'package:amazon_mobile/presentation/layout/search_layout2.dart';
import 'package:amazon_mobile/presentation/screens/main_view/product_details.dart';
import 'package:flutter/material.dart';
import 'package:amazon_mobile/domain/model/category.dart';
import 'package:amazon_mobile/domain/model/products.dart';
import 'package:amazon_mobile/presentation/resources/cloud_firestore.dart';

class CategoryProductsPage extends StatefulWidget {
  final Category category;

  const CategoryProductsPage({
    Key? key,
    required this.category,
  }) : super(key: key);

  set query(String query) {}
  @override
  _CategoryProductsPageState createState() => _CategoryProductsPageState();
}

class _CategoryProductsPageState extends State<CategoryProductsPage> {
  final CloudFirestoreClass cloudFirestore = CloudFirestoreClass();
  late Future<List<Product>> categoryProducts;

  @override
  void initState() {
    super.initState();
    categoryProducts =
        cloudFirestore.getProductsForCategoryId(widget.category.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: SearchBarWidget2(
        onChanged: (value) => setState(() {
          widget.query = value;
        }),
        query: '',
        isReadOnly: false,
        hasBackButton: true,
      ),
      body: FutureBuilder<List<Product>>(
        future: categoryProducts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<Product> products = snapshot.data!;
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Number of columns in the grid
                crossAxisSpacing: 8.0, // Spacing between columns
                mainAxisSpacing: 8.0, // Spacing between rows
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                return ProductCard(product: products[index]);
              },
            );
          }
        },
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetails(singleProduct: product),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(product.imageCover ?? ''),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  product.title ?? 'No Title',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
