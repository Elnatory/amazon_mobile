import 'package:amazon_mobile/presentation/resources/color_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  // AppProvider appProvider = Provider of <AppProvider>(context);
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: ColorManager.backgroundColor,
      body: Center(
        child: Text("Cart"),
      ),
    );
  }
}