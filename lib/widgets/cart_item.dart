import '../models/cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartItemWidget extends StatelessWidget {
  const CartItemWidget({
    super.key,
    required this.imagUrl,
    required this.title,
    required this.productsId,
    required this.quantity,
    required this.price,
    required this.attribute,
    required this.style,
    required this.endIndent,
  });
  final String imagUrl;
  final String title;
  final String productsId;
  final int quantity;
  final double price;
  final String attribute;
  final String style;
  final double endIndent;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              Column(
                children: [
                  (!imagUrl.startsWith('http') && !imagUrl.startsWith('https'))
                      ? Image.asset(
                          imagUrl,
                          width: 100,
                          height: 100,
                        )
                      : Image.network(
                          imagUrl,
                          fit: BoxFit.fitWidth,
                          width: 100,
                          height: 100,
                        ),
                  Row(
                    children: [
                      iconChangeQuantity(
                          Icons.remove,
                          () => Provider.of<Cart>(context, listen: false)
                              .reduceItem(productsId)),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 5),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1.5),
                        ),
                        child: Text(
                          quantity.toStringAsFixed(0),
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                        ),
                      ),
                      iconChangeQuantity(
                          Icons.add,
                          () => Provider.of<Cart>(context, listen: false)
                              .increaseItem(productsId)),
                    ],
                  )
                ],
              ),
              const SizedBox(width: 15.0),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0, bottom: 5.0),
                    child: Text(
                      title,
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(fontSize: 20.0),
                    ),
                  ),
                  Text(
                    attribute,
                    style: Theme.of(context)
                        .textTheme
                        .displayMedium!
                        .copyWith(fontSize: 16.0, color: Colors.black),
                  ),
                  const SizedBox(height: 2.0),
                  Text(
                    style,
                    style: Theme.of(context).textTheme.displayMedium!.copyWith(
                        fontSize: 14.0, color: const Color(0xFF848484)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 27.0),
                    child: Text(
                      '\$${(price * quantity).toStringAsFixed(2)}',
                      style:
                          Theme.of(context).textTheme.displayMedium!.copyWith(
                                fontWeight: FontWeight.w700,
                                fontSize: 18.0,
                                color: Colors.black,
                              ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Divider(
            height: 48.0,
            thickness: 1.0,
            color: Colors.black,
            endIndent: 5,
          ),
        ],
      ),
    );
  }

  Container iconChangeQuantity(IconData icon, Function fct) {
    return Container(
      color: Colors.black,
      child: IconButton(
        padding: const EdgeInsets.all(4.0),
        constraints: const BoxConstraints(),
        onPressed: fct as Function(),
        icon: Icon(
          icon,
          color: Colors.white,
        ),
      ),
    );
  }
}
