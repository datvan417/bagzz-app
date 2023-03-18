import '../screens/detail_item_screen.dart';
import '../models/list_bag.dart';
import '../widgets/favorite_bag.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllBagScreen extends StatefulWidget {
  static const routeName = '\all-bag';
  const AllBagScreen({super.key});

  @override
  State<AllBagScreen> createState() => _AllBagScreenState();
}

class _AllBagScreenState extends State<AllBagScreen> {
  @override
  Widget build(BuildContext context) {
    final _bagData = Provider.of<ListBagProvider>(context).items;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.7,
        iconTheme: const IconThemeData(),
        backgroundColor: Colors.white,
        title: Text(
          'Bagzz',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: _bagData.length,
          itemBuilder: (_, index) => GestureDetector(
            onTap: () => Navigator.pushNamed(
                context, DetailItemScreen.routeName,
                arguments: {'bagId': _bagData[index].id}),
            child: FavoriteBagWidget(
              bagData: _bagData[index],
              widget: Container(),
            ),
          ),
        ),
      ),
    );
  }
}
