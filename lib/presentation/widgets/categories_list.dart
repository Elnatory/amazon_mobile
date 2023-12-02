import 'package:amazon_mobile/domain/model/category.dart';
import 'package:amazon_mobile/presentation/resources/cloud_firestore.dart';
// import 'package:amazon_mobile/presentation/resources/color_manager.dart';
import 'package:amazon_mobile/presentation/resources/constants.dart';
import 'package:flutter/material.dart';

class CategoriesList extends StatefulWidget {
  const CategoriesList({Key? key}) : super(key: key);

  @override
  State<CategoriesList> createState() => _CategoriesListState();
}

class _CategoriesListState extends State<CategoriesList> {
  CloudFirestoreClass cloudFirestoreClass = CloudFirestoreClass();
  List<Category>? categories;

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    try {
      List<Category> fetchedCategories =
          await cloudFirestoreClass.getCategories();
      setState(() {
        categories = fetchedCategories;
      });
      print('Fetched Categories:');
      for (var category in categories!) {
        print('ID: ${category.id}, Name: ${category.name}');
      }
    } catch (e) {
      print('Error fetching categories: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppBarHeight,
      width: double.infinity,
      color: const Color.fromARGB(255, 254, 244, 181),
      child: categories != null
          ? ListView.builder(
              itemCount: categories!.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                if (index < categoryLogos.length) {
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.network(
                            categoryLogos2[
                                index],
                            height: 45, 
                            width: 45,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            categories![index].name,
                            style: const TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  return Container();
                }
              },
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
