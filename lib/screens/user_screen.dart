import '../models/list_bag.dart';
import '../screens/edit_bags.dart';
import '../widgets/drawer_widget.dart';
import '../widgets/favorite_bag.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserScreen extends StatelessWidget {
  static const routeName = '\\user-screen';
  const UserScreen({super.key});

  Future<void> _refreshPage(BuildContext context) async {
    Provider.of<ListBagProvider>(context, listen: false).fetchAndSetBag();
  }

  @override
  Widget build(BuildContext context) {
    final bagData = Provider.of<ListBagProvider>(context).items;
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
      drawer: const DrawerWidget(),
      body: RefreshIndicator(
        onRefresh: () => _refreshPage(context),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListView.builder(
            itemCount: bagData.length,
            itemBuilder: (_, index) => FavoriteBagWidget(
              bagData: bagData[index],
              widget: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: const Size(50, 30),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      alignment: Alignment.centerLeft,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, EditProduct.routeName,
                          arguments: bagData[index].id);
                    },
                    child: const Text(
                      'Edit',
                      style: TextStyle(color: Colors.blue, fontSize: 16.0),
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: const Size(110, 30),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      alignment: Alignment.centerRight,
                    ),
                    onPressed: () {
                      Provider.of<ListBagProvider>(context, listen: false)
                          .removeBag(bagData[index].id);
                    },
                    child: const Text(
                      'Remove',
                      style: TextStyle(color: Colors.red, fontSize: 16.0),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, EditProduct.routeName);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
