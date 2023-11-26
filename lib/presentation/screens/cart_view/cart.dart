import 'package:amazon_mobile/domain/model/products.dart';
import 'package:amazon_mobile/presentation/resources/cloud_firestore.dart';
import 'package:flutter/material.dart';
class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  final CloudFirestoreClass cloudFirestore = CloudFirestoreClass();

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping Cart'),
      ),
      body: FutureBuilder<List<Product>>(
        future: cloudFirestore.getCartProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            List<Product> cartProducts = snapshot.data!;
            if (cartProducts.isEmpty) {
              return const Center(
                child: Text('Your cart is empty.'),
              );
            }

            return ListView.builder(
              itemCount: cartProducts.length,
              itemBuilder: (context, index) {
                Product product = cartProducts[index];
                return ListTile(
                  title: Text(product.title ?? ''),
                  subtitle: Text('Price: EGP ${product.price ?? 0}.00'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      if (product.id != null) {
                        print('Delete button pressed for product ID: ${product.id}');
                        CloudFirestoreClass().removeProductFromCart(uid: product.id!);
                      } else {
                        print('Product ID is null');
                      }
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}