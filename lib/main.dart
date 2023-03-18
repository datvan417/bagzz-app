import 'package:bagzz/screens/all_bag.dart';

import '../models/orders.dart';
import '../screens/payment_complete.dart';
import '../screens/user_screen.dart';
import '../screens/check_out.dart';
import '../screens/my_orders_screen.dart';
import '../models/cart.dart';
import '../screens/cart_screen.dart';
import '../screens/edit_bags.dart';
import '../models/bag.dart';
import '../screens/detail_item_screen.dart';
import '../screens/search_screen.dart';
import '../screens/home_screen.dart';
import '../screens/tab_screen.dart';
import '../models/list_bag.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ListBagProvider()),
        ChangeNotifierProvider(create: (_) => BagProvider()),
        ChangeNotifierProvider(create: (_) => Cart()),
        ChangeNotifierProvider(create: (_) => Orders()),
      ],
      child: MaterialApp(
        home: const TabScreen(),
        theme: ThemeData(
          primaryColor: Colors.white,
          textTheme: const TextTheme(
            titleLarge: TextStyle(
              fontSize: 22.0,
              fontFamily: 'PlayfairDisplay',
              fontWeight: FontWeight.w700,
            ),
            displayMedium: TextStyle(
              fontFamily: 'WorkSans',
              fontSize: 20.0,
              fontWeight: FontWeight.w400,
            ),
            displaySmall: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 14.0,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
          colorScheme:
              ColorScheme.fromSwatch().copyWith(secondary: Colors.black),
        ),
        routes: {
          HomePage.routeName: (context) => TabScreen(),
          DetailItemScreen.routeName: (context) => DetailItemScreen(),
          SearchScreen.routeName: (context) => SearchScreen(),
          CartScreen.routeNamed: (context) => CartScreen(),
          EditProduct.routeName: (context) => EditProduct(),
          CheckOutScreen.routeName: (context) => CheckOutScreen(),
          MyOrdersScreen.routeName: (context) => MyOrdersScreen(),
          PaymentComplete.routeName: (context) => PaymentComplete(),
          UserScreen.routeName: (context) => UserScreen(),
          AllBagScreen.routeName: (context) => AllBagScreen(),
        },
      ),
    );
  }
}
