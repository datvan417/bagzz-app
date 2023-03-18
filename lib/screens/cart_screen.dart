import '../models/cart.dart';
import '../screens/check_out.dart';
import '../widgets/cart_item.dart';
import '../widgets/handle_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  static const routeNamed = "/cart-screen";
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartData = Provider.of<Cart>(context);
    final listCartItem = cartData.items.values.toList();
    return Column(
      children: [
        const Divider(
          thickness: 2.0,
          height: 20.0,
          color: Colors.black,
          indent: 113.0,
          endIndent: 113.0,
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.4,
          margin: const EdgeInsets.only(top: 50.0, left: 27.0),
          child: ListView.builder(
            itemBuilder: (context, index) => CartItemWidget(
              attribute: listCartItem[index].attribute,
              productsId: cartData.items.keys.toList()[index],
              title: listCartItem[index].title,
              quantity: listCartItem[index].quantity,
              price: listCartItem[index].price,
              style: listCartItem[index].style,
              imagUrl: listCartItem[index].imageUrl,
              endIndent: 25.0,
            ),
            itemCount: cartData.itemCount,
          ),
        ),
        const SizedBox(height: 30.0),
        HandleButton(
          label: 'PROCEED TO BUY',
          textColor: Colors.white,
          backgroundColor: Colors.black,
          function: () {
            listCartItem.isNotEmpty
                ? Navigator.pushNamed(context, CheckOutScreen.routeName)
                : null;
          },
          fontSize: 16.0,
        )
      ],
    );
  }
}
