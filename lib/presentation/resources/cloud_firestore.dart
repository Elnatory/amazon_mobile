import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

import 'package:amazon_mobile/domain/model/category.dart' show Category;
import 'package:amazon_mobile/domain/model/products.dart' show Product;

class CloudFirestoreClass {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  double calculateTotalPrice(double price, int quantity) {
    return price * quantity;
  }

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
          .map((doc) => Category.fromMap(doc.data()))
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
          await firebaseFirestore.collection('products').get();

      List<Product> products =
          snapshot.docs.map((doc) => Product.fromJson(doc.data())).toList();

      return products;
    } catch (e) {
      print("Error fetching products: $e");
      return [];
    }
  }






// Future<void> addProductToCart({
//   required Product product,
//   required int newQuantity,
//   bool isPreview = false, // Add a parameter to indicate if it's a preview
// }) async {
//   if (isPreview) {
//     // Perform preview actions without updating Firestore
//     double previewTotalPrice = calculateTotalPrice(product.price?.toDouble() ?? 0.0, newQuantity);
//     print('Preview Product: ${product.title}, Quantity: $newQuantity, Preview Total Price: $previewTotalPrice');
//     return; // Exit the function without updating Firestore
//   }

//   final userUid = firebaseAuth.currentUser!.uid;
//   final existingProduct = await firebaseFirestore
//     .collection('cart')
//     .doc(userUid)
//     .collection('cart')
//     .where('id', isEqualTo: product.id)
//     .limit(1)
//     .get();

//   if (existingProduct.docs.isNotEmpty) {
//     final existingProductId = existingProduct.docs.first.id;

//     await firebaseFirestore
//       .collection('cart')
//       .doc(userUid)
//       .collection('cart')
//       .doc(existingProductId)
//       .update({
//         'quantity': newQuantity,
//         'totalPrice': calculateTotalPrice(product.price?.toDouble() ?? 0.0, newQuantity),
//       });

//     print('Updated Quantity: $newQuantity, Updated Total Price: ${calculateTotalPrice(product.price?.toDouble() ?? 0.0, newQuantity)}');
//   } else {
//     await firebaseFirestore
//       .collection('cart')
//       .doc(userUid)
//       .collection('cart')
//       .add({
//         ...product.toJson(),
//         'quantity': newQuantity,
//         'totalPrice': calculateTotalPrice(product.price?.toDouble() ?? 0.0, newQuantity),
//       });

//     print('Added Product: ${product.title}, Quantity: $newQuantity, Total Price: ${calculateTotalPrice(product.price?.toDouble() ?? 0.0, newQuantity)}');
//   }
// }

Future<void> addProductToCart({required Product product}) async {
    await firebaseFirestore
    .collection('cart')
    .doc(firebaseAuth.currentUser!.uid)
    .collection('cart')
    .add(product.toJson());
}








// Future<List<Product>> getCartProducts() async {
//   try {
//     QuerySnapshot<Map<String, dynamic>> snapshot = await firebaseFirestore
//         .collection('cart')
//         .doc(firebaseAuth.currentUser!.uid)
//         .collection('cart')
//         .get();

//     List<Product> cartProducts = snapshot.docs
//         .map((doc) => Product.fromJson(doc.data()))
//         .toList();

//     return cartProducts;
//   } catch (e) {
//     print("Error fetching cart products: $e");
//     return [];
//   }
// }

  Stream<List<Product>> getCartProductsStream() {
    return firebaseFirestore
        .collection('cart')
        .doc(firebaseAuth.currentUser!.uid)
        .collection('cart')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => Product.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    });
  }

// Future<void> removeProductFromCart({required String id}) async {
//   await firebaseFirestore
//       .collection('cart')
//       .doc(firebaseAuth.currentUser!.uid)
//       .collection('cart')
//       .doc(id)
//       .delete();
// }

// Future<void> removeProductFromCart({required String id}) async {
//   if (id.isNotEmpty) {
//     await firebaseFirestore
//         .collection('cart')
//         .doc(firebaseAuth.currentUser!.uid)
//         .collection('cart')
//         .doc(id)
//         .delete();
//   } else {
//     print('Error: Invalid id');
//   }
// }

// Future<void> removeProductFromCart({required String uid}) async {
//   try {
//     await firebaseFirestore
//         .collection('cart')
//         .doc(firebaseAuth.currentUser!.uid)
//         .collection('cart')
//         .where('uid', isEqualTo: uid)
//         .get()
//         .then((querySnapshot) {
//           for (var doc in querySnapshot.docs) {
//             doc.reference.delete();
//           }
//         });
//     print('Product with UID: $uid deleted successfully.');
//   } catch (e) {
//     print('Error removing product: $e');
//   }
// }

// Future<void> removeProductFromCart({required String documentId}) async {
//   try {
//     await firebaseFirestore
//         .collection('users')
//         .doc(firebaseAuth.currentUser!.uid)
//         .collection('cart')
//         .doc(documentId)
//         .delete();

//     print('Document with UID: $documentId deleted successfully.');
//   } catch (e) {
//     print('Error removing document: $e');
//   }
// }

  Future<String?> getDocumentIdByProductId(String productId) async {
    try {
      var querySnapshot = await firebaseFirestore
          .collection('cart')
          .doc(firebaseAuth.currentUser!.uid)
          .collection('cart')
          .where('id', isEqualTo: productId)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs.first.id;
      } else {
        return null;
      }
    } catch (e) {
      print('Error getting document ID: $e');
      return null;
    }
  }

  Future<void> removeProductFromCart({required String productId}) async {
    try {
      var querySnapshot = await firebaseFirestore
          .collection('cart')
          .doc(firebaseAuth.currentUser!.uid)
          .collection('cart')
          .where('id', isEqualTo: productId)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        var documentId = querySnapshot.docs.first.id;
        await firebaseFirestore
            .collection('cart')
            .doc(firebaseAuth.currentUser!.uid)
            .collection('cart')
            .doc(documentId)
            .delete();
        print('Product with ID: $productId deleted successfully.');
      } else {
        print('Error: Product with ID $productId not found in the cart.');
      }
    } catch (e) {
      print('Error removing product: $e');
    }
  }


//   Future<void> updateProductInCart({required String productId, required int newQuantity}) async {
//   await firebaseFirestore
//       .collection('cart')
//       .doc(firebaseAuth.currentUser!.uid)
//       .collection('cart')
//       .doc(productId)
//       .update({'quantity': newQuantity});
// }

// Future<void> updateProductInCart({
//     required String productId,
//     required int newQuantity,
//   }) async {
//     try {
//       await FirebaseFirestore.instance
//           .collection('cart')
//           .doc(productId)
//           .update({'quantity': newQuantity});
//     } catch (e) {
//       print('Error updating product quantity in cart: $e');
//     }
//   }



  Future buyAllItemsInCart() async {
    try {
      var querySnapshot = await firebaseFirestore
          .collection('cart')
          .doc(firebaseAuth.currentUser!.uid)
          .collection('cart')
          .get();

      for (var i = 0; i < querySnapshot.docs.length; i++) {
        Product product = Product.fromJson(querySnapshot.docs[i].data());
        addProductToOrders(product: product);
      }

      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs) {
          doc.reference.delete();
        }
        print('All items in cart bought successfully.');
      } else {
        print('Error: Cart is empty.');
      }
    } catch (e) {
      print('Error buying all items in cart: $e');
    }
  }

  Future<void> addProductToOrders({required Product product}) async {
    await firebaseFirestore
        .collection('orders')
        .doc(firebaseAuth.currentUser!.uid)
        .collection('orders')
        .add(product.toJson());
  }

  Future<void> addProductToWishlist({required Product product}) async {
    await firebaseFirestore
        .collection('wishlist')
        .doc(firebaseAuth.currentUser!.uid)
        .collection('wishlist')
        .add(product.toJson());
  }
}
