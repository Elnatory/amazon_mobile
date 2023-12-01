import 'package:amazon_mobile/domain/model/products.dart';
import 'package:amazon_mobile/presentation/layout/search_layout.dart';
import 'package:amazon_mobile/presentation/layout/search_layout2.dart';
import 'package:amazon_mobile/presentation/resources/cloud_firestore.dart';
import 'package:amazon_mobile/presentation/resources/color_manager.dart';
import 'package:amazon_mobile/presentation/widgets/banner.dart';
import 'package:amazon_mobile/presentation/widgets/categories_list.dart';
import 'package:amazon_mobile/presentation/widgets/product_widget.dart';
import 'package:amazon_mobile/presentation/widgets/products_listview.dart';
import 'package:amazon_mobile/presentation/widgets/user_details.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  set query(String query) {}

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final CloudFirestoreClass cloudFirestore = CloudFirestoreClass();

  CloudFirestoreClass getCloudFirestore() {
    return cloudFirestore;
  }

  ScrollController controller = ScrollController();
  double offset = 0;
  late Future<List<Product>> featuredProducts;

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      setState(() {
        offset = controller.position.pixels;
      });
    });

    // Initialize the future in initState
    featuredProducts = getCloudFirestore().getProducts();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.backgroundColor,
      appBar: SearchBarWidget(
        onChanged: (value) => setState(() {
          widget.query = value;
        }),
        query: '',
        isReadOnly: false,
        hasBackButton: false,
      ),
      body: ListView(
        controller: controller,
        children: [
          UserDetailsBar(
            offset: offset,
          ),
          const CategoriesList(),
          const AdBannerWidget(),
          // Use the FutureBuilder here
          FutureBuilder<List<Product>>(
            future: featuredProducts,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                List<Product> products = snapshot.data!;
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

          // Inside the empty Column
          Column(
            children: [
              SizedBox(height: 16),
              Text(
                'Featured Products',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              // Use the FutureBuilder here
              FutureBuilder<List<Product>>(
                future: featuredProducts,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    List<Product> products = snapshot.data!;
                    return GridView.builder(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 8.0,
                        mainAxisSpacing: 8.0,
                      ),
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        return ProductWidget(product: products[index]);
                      },
                    );
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
