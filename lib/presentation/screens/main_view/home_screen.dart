import 'package:amazon_mobile/domain/model/category.dart';
import 'package:amazon_mobile/domain/model/products.dart';
import 'package:amazon_mobile/presentation/layout/search_layout.dart';
import 'package:amazon_mobile/presentation/layout/search_layout2.dart';
import 'package:amazon_mobile/presentation/resources/cloud_firestore.dart';
import 'package:amazon_mobile/presentation/resources/color_manager.dart';
import 'package:amazon_mobile/presentation/resources/constants.dart';
import 'package:amazon_mobile/presentation/widgets/banner.dart';
import 'package:amazon_mobile/presentation/widgets/categories_list.dart';
import 'package:amazon_mobile/presentation/widgets/category_listview.dart';
import 'package:amazon_mobile/presentation/widgets/product_wedget2.dart';
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
  late Future<List<Category>> featuredCategories = Future.value([]);


  @override
void initState() {
  super.initState();
  controller.addListener(() {
    setState(() {
      offset = controller.position.pixels;
    });
  });

  // Initialize the futures in initState
  featuredProducts = getCloudFirestore().getProducts();
  featuredCategories = getCloudFirestore().getCategories();
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
                return ProductsShowcaseListView(
                  title: 'Shop by Products',
                  products: products,
                );
              }
            },
          ),
          FutureBuilder<List<Category>>(
            future: featuredCategories,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                List<Category> category = snapshot.data!;
                return CategoryShowcaseListView(
                  title: 'Shop by Categories',
                  categories: category,
                );
              }
            },
          ),

          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Image.network("https://images-eu.ssl-images-amazon.com/images/G/42/Egypt-hq/2023/img/Outbound/XCM_Manual_1612368_5898276_1500x150_2X.jpg"),
          ),
          SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: Text(
              'Featured Products',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 5),
          // Use the FutureBuilder here
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: FutureBuilder<List<Product>>(
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
                      return ProductWidget2(product: products[index]);
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
