import '../models/cart.dart';
import '../models/bag.dart';
import '../models/list_bag.dart';
import '../widgets/handle_button.dart';
import '../widgets/favorite_bag.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteBag extends StatefulWidget {
  const FavoriteBag({super.key});

  @override
  State<FavoriteBag> createState() => _FavoriteBagState();
}

class _FavoriteBagState extends State<FavoriteBag> {
  @override
  Widget build(BuildContext context) {
    final _favoriteBag = Provider.of<BagProvider>(context);
    final listBag = Provider.of<ListBagProvider>(context, listen: false);
    final cartData = Provider.of<Cart>(context);
    final _favoriteBagData = _favoriteBag.favoriteBag;
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
            itemBuilder: (context, index) => FavoriteBagWidget(
              bagData: _favoriteBagData[index],
              widget: TextButton(
                onPressed: () => _favoriteBag
                    .updateFavoriteBagHomeScreen(_favoriteBagData[index]),
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(0),
                ),
                child: Container(
                  padding: const EdgeInsets.only(bottom: 4.0, right: 4.0),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.black, width: 2.0),
                    ),
                  ),
                  child: Text(
                    'REMOVE',
                    style: Theme.of(context).textTheme.displayMedium!.copyWith(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                  ),
                ),
              ),
            ),
            itemCount: _favoriteBag.favoriteBag.length,
          ),
        ),
        const SizedBox(height: 30.0),
        HandleButton(
          label: 'ADD ALL TO CART',
          textColor: Colors.white,
          backgroundColor: Colors.black,
          function: () => _favoriteBag.favoriteBag.forEach((bagItem) {
            cartData.addItem(
              bagItem.imageUrl,
              bagItem.title,
              bagItem.attribute,
              bagItem.style,
              bagItem.price,
              bagItem.id,
            );
            listBag.clearFavorite(_favoriteBagData).then((_) {
              Provider.of<ListBagProvider>(context, listen: false)
                  .fetchAndSetBag();
            });
            _favoriteBag.clear();
          }),
          fontSize: 16.0,
        )
      ],
    );
  }
}
