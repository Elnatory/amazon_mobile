import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

import 'package:amazon_mobile/domain/model/category.dart' show Category;
import 'package:amazon_mobile/domain/model/products.dart' show Product;

class CloudFirestoreClass {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<void> uploadNameAndEmailToDatabase(
      {required String name, required String email}) async {
    String formattedTimestamp =
        DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
    await firebaseFirestore
        .collection("users")
        .doc(firebaseAuth.currentUser!.uid)
        .set({
      "name": name,
      "email": email,
      "createdAt": formattedTimestamp,
    });
  }

  Future<Map<String, dynamic>> getNameAndEmail() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> userDoc = await firebaseFirestore
          .collection("users")
          .doc(firebaseAuth.currentUser!.uid)
          .get();

      if (userDoc.exists) {
        Map<String, dynamic> userData = userDoc.data()!;
        return {
          "name": userData['name'],
          "email": userData['email'],
          "createdAt":userData['createdAt'],
        };
      } else {
        return {
          "name": '',
          "email": '',
        };
      }
    } catch (e) {
      print("Error fetching user data: $e");
      return {
        "name": '',
        "email": '',
      };
    }
  }

  Future<List<Category>> getCategories() async {
    try {
      QuerySnapshot<Map<String, dynamic>> categoriesSnapshot =
          await firebaseFirestore.collection("categories").get();

      List<Category> categoriesList = categoriesSnapshot.docs
          .map((doc) => Category.fromMap(doc.data() as Map<String, dynamic>))
          .toList();

      return categoriesList;
    } catch (e) {
      print("Error fetching categories: $e");
      return [];
    }
  }

Future<List<Product>> getProducts() async {
    try {
        QuerySnapshot<Map<String, dynamic>> snapshot =
            await firebaseFirestore.collection('extras').get();

        List<Product> products = snapshot.docs
            .map((doc) => Product.fromJson(doc.data() as Map<String, dynamic>))
            .toList();

        return products;
    } catch (e) {
        print("Error fetching products: $e");
        return [];
    }
}

}
