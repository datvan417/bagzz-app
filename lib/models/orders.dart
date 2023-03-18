import 'dart:convert';

import '../models/cart.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class OrderItem {
  final String id;
  final List<CartItem> bags;
  final double amount;
  final DateTime date;

  OrderItem({
    required this.id,
    required this.bags,
    required this.amount,
    required this.date,
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> fetchAndSetOrders() async {
    final url =
        Uri.parse('https://bagzz-app-default-rtdb.firebaseio.com/orders.json');
    try {
      final response = await http.get(url);
      final loadedData = jsonDecode(response.body) as Map<String, dynamic>;
      List<OrderItem> loadedOrder = [];
      loadedData.forEach((orderId, orderData) {
        loadedOrder.insert(
            0,
            OrderItem(
              id: orderId,
              amount: orderData['amount'],
              date: DateTime.parse(orderData['date']),
              bags: (orderData['bags'] as List<dynamic>)
                  .map(
                    (temp) => CartItem(
                      temp['imageUrl'],
                      temp['id'],
                      temp['title'],
                      temp['quantity'],
                      temp['attribute'],
                      temp['style'],
                      temp['price'],
                    ),
                  )
                  .toList(),
            ));
      });
      _orders = loadedOrder;
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    print(cartProducts[0].quantity);
    final date = DateTime.now();
    try {
      final url = Uri.parse(
          'https://bagzz-app-default-rtdb.firebaseio.com/orders.json');
      final response = await http.post(
        url,
        body: jsonEncode({
          'bags': cartProducts
              .map((cartItem) => {
                    'id': cartItem.id,
                    'title': cartItem.title,
                    'attribute': cartItem.attribute,
                    'style': cartItem.style,
                    'price': cartItem.price,
                    'quantity': cartItem.quantity,
                    'imageUrl': cartItem.imageUrl,
                  })
              .toList(),
          'amount': total,
          'date': date.toIso8601String(),
        }),
      );

      final newOrder = OrderItem(
          id: jsonDecode(response.body)['name'],
          bags: cartProducts,
          amount: total,
          date: date);

      _orders.insert(0, newOrder);
    } catch (error) {
      print(error);
      rethrow;
    }
    notifyListeners();
  }
}
