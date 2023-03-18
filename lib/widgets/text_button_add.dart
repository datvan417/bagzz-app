import '../models/bag.dart';
import '../models/cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TextButtonAddItem extends StatelessWidget {
  final Bag bagItem;
  const TextButtonAddItem({required this.bagItem, super.key});

  @override
  Widget build(BuildContext context) {
    var cartData = Provider.of<Cart>(context);
    return TextButton(
      onPressed: () {
        cartData.addItem(
          bagItem.imageUrl,
          bagItem.title,
          bagItem.attribute,
          bagItem.style,
          bagItem.price,
          bagItem.id,
        );
      },
      child: Container(
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.black, width: 1.0),
          ),
        ),
        child: Text(
          'ADD TO CART',
          style: Theme.of(context).textTheme.displayMedium!.copyWith(
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
        ),
      ),
    );
  }
}
