import 'dart:math';
import '../models/orders.dart';
import 'package:flutter/material.dart';

class OrderItemWidget extends StatefulWidget {
  const OrderItemWidget({required this.orderData, super.key});
  final OrderItem orderData;

  @override
  State<OrderItemWidget> createState() => _OrderItemWidgetState();
}

class _OrderItemWidgetState extends State<OrderItemWidget> {
  var _expand = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          ListTile(
            contentPadding: const EdgeInsets.all(10.0),
            leading: CircleAvatar(
              backgroundColor: const Color(0XFFDFB23F),
              radius: 30.0,
              child: Text(
                '\$${widget.orderData.amount.toStringAsFixed(0)}',
                style: Theme.of(context).textTheme.displaySmall!.copyWith(
                      fontSize: 16.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ),
            title: Text('Order \$${widget.orderData.id}'),
            trailing: IconButton(
              onPressed: () {
                setState(() {
                  _expand = !_expand;
                });
              },
              icon: const Icon(
                Icons.expand_more,
                size: 40,
                color: Color(0XFFDFB23F),
              ),
            ),
          ),
          if (_expand)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
              height: min(widget.orderData.bags.length * 20.0 + 10, 100),
              child: ListView(
                children: widget.orderData.bags
                    .map(
                      (prod) => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            prod.title,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${prod.quantity}x \$${prod.price}',
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.grey,
                            ),
                          )
                        ],
                      ),
                    )
                    .toList(),
              ),
            )
        ],
      ),
    );
  }
}
