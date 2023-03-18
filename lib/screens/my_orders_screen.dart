import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../models/orders.dart';
import '../widgets/order_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyOrdersScreen extends StatefulWidget {
  static const routeName = '/my-order';
  const MyOrdersScreen({super.key});

  @override
  State<MyOrdersScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> {
  var _isLoading = true;
  var _initState = true;

  @override
  void didChangeDependencies() {
    if (_initState) {
      Provider.of<Orders>(context).fetchAndSetOrders().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _initState = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(),
        centerTitle: true,
        title: Text(
          'Order History',
          style: Theme.of(context)
              .textTheme
              .displaySmall!
              .copyWith(fontWeight: FontWeight.w600, fontSize: 18.0),
        ),
        backgroundColor: Colors.white,
        elevation: 0.8,
      ),
      body: _isLoading
          ? const SpinKitSpinningLines(color: Colors.black)
          : Consumer<Orders>(
              builder: (context, orderData, _) => ListView.builder(
                itemBuilder: (_, index) =>
                    OrderItemWidget(orderData: orderData.orders[index]),
                itemCount: orderData.orders.length,
              ),
            ),
    );
  }
}
