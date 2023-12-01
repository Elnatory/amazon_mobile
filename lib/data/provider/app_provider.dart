import 'package:amazon_mobile/domain/model/products.dart';
import 'package:flutter/material.dart';

class AppProvider with ChangeNotifier {
  // Cart Work==================================================================

  final List<Product> _cartProductList = [];

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

  final List<Product> _favProductList = [];

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
    for (Product element in _cartProductList) {
      double price =
          (element.priceAfterDiscount ?? element.price ?? 0).toDouble();
      total += price * (element.qty ?? 0);
    }
    return total;
  }

  // Update Qty=================================================================

  void updateQty(Product product, int qty) {
    int index = _cartProductList.indexOf(product);
    _cartProductList[index].qty = qty;
    notifyListeners();
  }

  // Total Qty==================================================================

  int calculateTotalQuantity() {
    int totalQuantity = 0;
    for (Product product in _cartProductList) {
      totalQuantity += product.qty ?? 0;
    }
    return totalQuantity;
  }

  // Clear Cart=================================================================

  void clearCart() {
    _cartProductList.clear();
    notifyListeners();
  }

  // Clear Favourite============================================================

  void clearFavourite() {
    _favProductList.clear();
    notifyListeners();
  }

  // Buy Products===============================================================

  final List<Product> _buyProductList = [];

void addbuyProduct(Product product) {
  print('Adding product: $product');
  _buyProductList.add(product);
  notifyListeners();
}

void addbuyProductCartList() {
  print('Adding products from cart to buy product list: $_cartProductList');
  
  // Remove null entries from _cartProductList before adding to _buyProductList
  _buyProductList.addAll(_cartProductList.where((product) => product != null));
  
  print('Updated Buy Product List: $_buyProductList');
  notifyListeners();
}

void clearCartList() {
  _cartProductList.clear();
  notifyListeners();
}

void clearBuyProduct() {
  _buyProductList.clear();
  notifyListeners();
}

List<Product> get getBuyProductList {
  print('Returning Buy Product List: $_buyProductList');
  return _buyProductList;
}


  // int _currentQuantity = 1;

  // int get currentQuantity => _currentQuantity;

  // void increaseQuantity() {
  //   _currentQuantity++;
  //   print('Current Quantity: $_currentQuantity');
  //   notifyListeners();
  // }

  // void resetQuantity() {
  //   _currentQuantity = 1;
  //   notifyListeners();
  // }


  int _currentQuantity = 1;

  int get currentQuantity => _currentQuantity;

  void increaseQuantity(int customQuantity) {
    _currentQuantity = customQuantity;
    notifyListeners();
}




}
