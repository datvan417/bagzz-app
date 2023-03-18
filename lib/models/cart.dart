import 'package:flutter/material.dart';

class CartItem {
  final String id;
  final String imageUrl;
  final String title;
  final int quantity;
  final String attribute;
  final String style;
  final double price;

  CartItem(this.imageUrl, this.id, this.title, this.quantity, this.attribute,
      this.style, this.price);
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void addItem(String imageUrl, String title, String attribute, String style,
      double price, String productsId) {
    if (_items.containsKey(productsId)) {
      (_items.update(
          productsId,
          (oldCartItem) => CartItem(
              oldCartItem.imageUrl,
              oldCartItem.id,
              oldCartItem.title,
              oldCartItem.quantity + 1,
              oldCartItem.attribute,
              oldCartItem.style,
              oldCartItem.price)));
    } else {
      _items.putIfAbsent(
        productsId,
        () => CartItem(
          imageUrl,
          DateTime.now().toString(),
          title,
          1,
          attribute,
          style,
          price,
        ),
      );
    }
    notifyListeners();
  }

  void reduceItem(String productsId) {
    if (_items[productsId]!.quantity > 1) {
      _items.update(
          productsId,
          (oldCartItem) => CartItem(
              oldCartItem.imageUrl,
              oldCartItem.id,
              oldCartItem.title,
              oldCartItem.quantity - 1,
              oldCartItem.attribute,
              oldCartItem.style,
              oldCartItem.price));
    } else {
      _items.remove(productsId);
    }
    notifyListeners();
  }

  void increaseItem(String productsId) {
    _items.update(
        productsId,
        (oldCartItem) => CartItem(
            oldCartItem.imageUrl,
            oldCartItem.id,
            oldCartItem.title,
            oldCartItem.quantity + 1,
            oldCartItem.attribute,
            oldCartItem.style,
            oldCartItem.price));
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
