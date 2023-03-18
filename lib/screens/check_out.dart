import '../screens/payment_complete.dart';
import '../models/orders.dart';
import '../widgets/cart_item.dart';
import '../models/cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({super.key});
  static const routeName = '/check-out';

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context, listen: false);
    final productId = cart.items.keys.toList();
    final cartItem = cart.items.values.toList();
    final total = cart.totalAmount;
    return Scaffold(
      appBar: _appBar(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Delivery To',
                style: Theme.of(context).textTheme.displaySmall!.copyWith(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              listTile('Name', 'Tran Nguyen Dat Van'),
              listTile('Address', 'Ho Chi Minh'),
              listTile('Phone', '+84 01234567'),
              Padding(
                padding: const EdgeInsets.only(top: 70.0, bottom: 19.0),
                child: Text(
                  'My Order',
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall!
                      .copyWith(fontSize: 24.0, fontWeight: FontWeight.w500),
                ),
              ),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 1,
                  minHeight: 60.0,
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => CartItemWidget(
                    imagUrl: cartItem[index].imageUrl,
                    title: cartItem[index].title,
                    productsId: productId[index],
                    quantity: cartItem[index].quantity,
                    price: cartItem[index].price,
                    attribute: cartItem[index].attribute,
                    style: cartItem[index].style,
                    endIndent: 5.0,
                  ),
                  itemCount: cartItem.length,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: ListTile(
                  leading: Text(
                    'Total',
                    style: Theme.of(context)
                        .textTheme
                        .displaySmall!
                        .copyWith(fontSize: 24.0, fontWeight: FontWeight.w500),
                  ),
                  trailing: Text(
                    '\$${total.toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        fontSize: 24.0,
                        fontWeight: FontWeight.w500,
                        color: const Color(0XFF424242)),
                  ),
                ),
              ),
              Center(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.06,
                  width: MediaQuery.of(context).size.width * 0.75,
                  child: ElevatedButton(
                    onPressed: () {
                      Provider.of<Orders>(context, listen: false)
                          .addOrder(cartItem, total)
                          .then((_) => cart.clear())
                          .then((_) => Navigator.pushReplacementNamed(
                              context, PaymentComplete.routeName));
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: const BorderSide(color: Colors.black),
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                    ),
                    child: Text(
                      'Pay \$${total.toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                          fontSize: 22.0, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  ListTile listTile(String title, String subtitle) {
    return ListTile(
      visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
      contentPadding: EdgeInsets.zero,
      title: Text(
        title,
        style: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w500,
          fontFamily: 'Montserrat',
          fontStyle: FontStyle.normal,
          color: const Color(0XFF424242).withOpacity(0.6),
        ),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w400,
          fontFamily: 'Montserrat',
          fontStyle: FontStyle.normal,
          color: Color(0XFF424242),
        ),
      ),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      titleSpacing: 0,
      iconTheme: const IconThemeData(color: Colors.black),
      elevation: 1,
      backgroundColor: Colors.white,
      title: Text(
        'Check out',
        style: Theme.of(context)
            .textTheme
            .displaySmall!
            .copyWith(fontWeight: FontWeight.w600, fontSize: 18.0),
      ),
    );
  }
}
