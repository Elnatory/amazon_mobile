import 'package:amazon_mobile/domain/model/products.dart';
import 'package:flutter/material.dart';

class AppProvider with ChangeNotifier {
  // Cart Work==================================================================

  List<Product> _cartProductList = [];

  void addCartProduct(Product product) {
    _cartProductList.add(product);
    notifyListeners();
  }

  void removeCartProduct(Product product) {
    _cartProductList.remove(product);
    notifyListeners();
  }

  List<Product> get getCartProductList => _cartProductList;

  // Favourite==================================================================

  List<Product> _favProductList = [];

  void addFavProduct(Product product) {
    _favProductList.add(product);
    notifyListeners();
  }

  void removeFavProduct(Product product) {
    _favProductList.remove(product);
    notifyListeners();
  }

  List<Product> get getfavProductList => _favProductList;

  // Total Price================================================================

  double totalPrice() {
    double total = 0.0;
    _cartProductList.forEach((element) {
      total += (element.price ?? 0) * (element.qty ?? 0);
    });
    return total;
  }

  void updateQty(Product product, int qty) {
    int index = _cartProductList.indexOf(product);
    _cartProductList[index].qty = qty;
    notifyListeners();
  }
}
