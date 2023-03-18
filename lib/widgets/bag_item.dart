import '../screens/detail_item_screen.dart';
import '../models/bag.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BagItem extends StatelessWidget {
  const BagItem({super.key});

  @override
  Widget build(BuildContext context) {
    final _bagData = Provider.of<Bag>(context, listen: false);
    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      color: const Color(0xffF1F1F1),
      child: Stack(children: [
        Positioned(
          top: 0,
          right: 0,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Consumer<BagProvider>(
              builder: (context, _bagItem, child) => IconButton(
                color: Colors.black,
                onPressed: () {
                  _bagItem.updateFavoriteBagHomeScreen(_bagData);
                },
                icon: Icon(
                  _bagData.isFavorite
                      ? Icons.favorite
                      : Icons.favorite_border_outlined,
                  size: 28,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          left: 30,
          right: 30,
          bottom: 18,
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, DetailItemScreen.routeName,
                  arguments: {'bagId': _bagData.id});
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                (!_bagData.imageUrl.startsWith('http') &&
                        !_bagData.imageUrl.startsWith('https'))
                    ? Image.asset(
                        _bagData.imageUrl,
                        fit: BoxFit.cover,
                        width: 100,
                        height: 100,
                      )
                    : Image.network(
                        _bagData.imageUrl,
                        fit: BoxFit.cover,
                        width: 100,
                        height: 100,
                      ),
                Padding(
                  padding: const EdgeInsets.only(top: 11, bottom: 16),
                  child: Text(
                    _bagData.title,
                    style: const TextStyle(
                      fontFamily: 'PlayfairDisplay',
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const Text(
                  'SHOP NOW',
                  style: TextStyle(
                    fontFamily: 'WorkSans',
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Divider(
                  color: Colors.black,
                  thickness: 2,
                  indent: 20,
                  endIndent: 20,
                  height: 4.0,
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
