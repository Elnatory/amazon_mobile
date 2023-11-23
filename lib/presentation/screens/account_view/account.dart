import 'package:amazon_mobile/domain/model/products.dart';
import 'package:amazon_mobile/presentation/resources/cloud_firestore.dart';
import 'package:amazon_mobile/presentation/resources/color_manager.dart';
import 'package:amazon_mobile/presentation/widgets/product_widget.dart';
import 'package:amazon_mobile/presentation/widgets/products_listview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Account extends StatefulWidget {
  Account({Key? key}) : super(key: key);

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  final CloudFirestoreClass cloudFirestore = CloudFirestoreClass();

  CloudFirestoreClass getCloudFirestore() {
    return cloudFirestore;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.backgroundColor,
      body: FutureBuilder<List<Product>>(
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

            return ProductsShowcaseListView(
              title: 'Shop by Products',
              products: products,
            );
          }
        },
      ),
    );
  }
}
