import 'package:amazon_mobile/data/provider/app_provider.dart';
import 'package:amazon_mobile/domain/model/products.dart';
import 'package:amazon_mobile/presentation/layout/search_layout.dart';
import 'package:amazon_mobile/presentation/layout/search_layout2.dart';
import 'package:amazon_mobile/presentation/resources/cloud_firestore.dart';
import 'package:amazon_mobile/presentation/resources/color_manager.dart';
import 'package:amazon_mobile/presentation/resources/constants.dart';
import 'package:amazon_mobile/presentation/resources/utils.dart';
import 'package:amazon_mobile/presentation/screens/cart_view/cart_boxes.dart';
import 'package:amazon_mobile/presentation/screens/cart_view/cart_subtotal.dart';
import 'package:amazon_mobile/presentation/screens/favourite_view/widget/fav_widget.dart';
import 'package:amazon_mobile/presentation/widgets/main_button.dart';
import 'package:amazon_mobile/presentation/widgets/user_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavScreen extends StatefulWidget {
  const FavScreen({super.key});
  set query(String query) {}
  @override
  State<FavScreen> createState() => _FavScreenState();
}

class _FavScreenState extends State<FavScreen> {
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(
      context,
    );
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
      body: appProvider.getfavProductList.isEmpty
          ? Center(
              child: Text(
                'No Favourite Products',
                style: TextStyle(
                  color: ColorManager.primary,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : Column(
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
                .width,
            padding: const EdgeInsets.all(4.0),
            child: Text(
              'Saved Items',
              style: TextStyle(
                color: Colors.grey[900],
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
                Expanded(
                  child: ListView.builder(
                    itemCount: appProvider.getfavProductList.length,
                    padding: const EdgeInsets.all(12),
                    itemBuilder: (context, index) {
                      return FavItemWidget(
                        product: appProvider.getfavProductList[index],
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
