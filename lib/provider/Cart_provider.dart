import 'package:api_project/model/Cart_model.dart';
import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  final List<CartItem> _cartItems = [];

  List<CartItem> get cartItems => _cartItems;

  void addToCart(CartItem newItem) {
    _cartItems.add(newItem);
    notifyListeners();
  }

  void removeFromCart(int index) {
    _cartItems.removeAt(index);
    notifyListeners();
  }
}
