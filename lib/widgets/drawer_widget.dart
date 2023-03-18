import '../screens/user_screen.dart';
import '../screens/home_screen.dart';
import '../screens/my_orders_screen.dart';
import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15.0, bottom: 10.0),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 25.0,
                child: Image.network(
                  'https://i.pinimg.com/736x/4d/f9/c8/4df9c80da22c9e8b62ef4008061d4dfc.jpg',
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(
                'Tran Nguyen Dat Van',
                style: Theme.of(context)
                    .textTheme
                    .displayMedium!
                    .copyWith(color: Colors.black, fontSize: 16.0),
              ),
              subtitle: Text(
                ' van180302@gmail.com',
                style: Theme.of(context).textTheme.displayMedium!.copyWith(
                      color: const Color(0xFF535763),
                      fontSize: 14.0,
                    ),
              ),
            ),
          ),
          const Divider(
            thickness: 2.0,
            color: Colors.grey,
          ),
          ListTile(
            leading: const Icon(
              Icons.home,
              color: Colors.black,
              size: 27.0,
            ),
            title: Text(
              'Home',
              style: Theme.of(context)
                  .textTheme
                  .displayMedium!
                  .copyWith(color: Colors.black, fontWeight: FontWeight.w600),
            ),
            onTap: () =>
                Navigator.pushReplacementNamed(context, HomePage.routeName),
          ),
          ListTile(
            leading: const Icon(
              Icons.edit,
              color: Colors.black,
              size: 27.0,
            ),
            title: Text(
              'Edit Product',
              style: Theme.of(context)
                  .textTheme
                  .displayMedium!
                  .copyWith(color: Colors.black, fontWeight: FontWeight.w600),
            ),
            onTap: () => Navigator.pushNamed(context, UserScreen.routeName),
          ),
          ListTile(
            leading: const Icon(
              Icons.wallet,
              color: Colors.black,
              size: 27.0,
            ),
            title: Text(
              'My Orders',
              style: Theme.of(context)
                  .textTheme
                  .displayMedium!
                  .copyWith(color: Colors.black, fontWeight: FontWeight.w600),
            ),
            onTap: () => Navigator.pushNamed(context, MyOrdersScreen.routeName),
          ),
        ],
      ),
    );
  }
}
