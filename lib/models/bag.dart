import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Bag with ChangeNotifier {
  final String id;
  final String title;
  final String attribute;
  final String style;
  final double price;
  final String description;
  final String shippingInfo;
  final String paymentsOptions;
  final String imageUrl;
  final String material;
  final String policy;
  bool isFavorite = false;

  Bag({
    required this.id,
    required this.title,
    required this.attribute,
    required this.style,
    required this.price,
    required this.description,
    required this.shippingInfo,
    required this.paymentsOptions,
    required this.imageUrl,
    required this.material,
    required this.policy,
    required this.isFavorite,
  });
}

class BagProvider with ChangeNotifier {
  List<Bag> favoriteBagItem = [];
  List<Bag> get favoriteBag {
    return [...favoriteBagItem];
  }

  Future<void> updateFavoriteBagHomeScreen(Bag bagItem) async {
    var url = Uri.parse(
        'https://bagzz-app-default-rtdb.firebaseio.com/bags/${bagItem.id}.json');
    if (bagItem.isFavorite) {
      bagItem.isFavorite = false;
      await http.patch(url,
          body: jsonEncode({
            'title': bagItem.title,
            'attribute': bagItem.attribute,
            'style': bagItem.style,
            'price': bagItem.price,
            'description': bagItem.description,
            'shippingInfo': bagItem.shippingInfo,
            'paymentsOptions': bagItem.paymentsOptions,
            'imageUrl': bagItem.imageUrl,
            'material': bagItem.material,
            'policy': bagItem.policy,
            'isFavorite': bagItem.isFavorite,
          }));

      final indexRemove =
          favoriteBagItem.indexWhere((element) => element.id == bagItem.id);
      favoriteBagItem.removeAt(indexRemove);
      notifyListeners();
    } else {
      bagItem.isFavorite = true;
      await http.patch(url,
          body: jsonEncode({
            'title': bagItem.title,
            'attribute': bagItem.attribute,
            'style': bagItem.style,
            'price': bagItem.price,
            'description': bagItem.description,
            'shippingInfo': bagItem.shippingInfo,
            'paymentsOptions': bagItem.paymentsOptions,
            'imageUrl': bagItem.imageUrl,
            'material': bagItem.material,
            'policy': bagItem.policy,
            'isFavorite': bagItem.isFavorite,
          }));

      favoriteBagItem.insert(
        0,
        Bag(
          id: bagItem.id,
          title: bagItem.title,
          attribute: bagItem.attribute,
          style: bagItem.style,
          price: bagItem.price,
          description: bagItem.description,
          shippingInfo: bagItem.shippingInfo,
          paymentsOptions: bagItem.paymentsOptions,
          imageUrl: bagItem.imageUrl,
          material: bagItem.material,
          policy: bagItem.policy,
          isFavorite: bagItem.isFavorite,
        ),
      );
    }
    notifyListeners();
  }

  void updateFavBagFavScreen(Bag bagItem, List<Bag> listBag) {
    final indexRemove =
        favoriteBagItem.indexWhere((element) => element.id == bagItem.id);
    favoriteBagItem.removeAt(indexRemove);
    final indexRm = listBag.indexWhere((element) => element.id == bagItem.id);
    listBag[indexRm].isFavorite = false;
    notifyListeners();
  }

  Future<void> fetchFavoriteData() async {
    var url =
        Uri.parse('https://bagzz-app-default-rtdb.firebaseio.com/bags.json');
    try {
      final response = await http.get(url);
      final extractedData = jsonDecode(response.body) as Map<String, dynamic>;
      List<Bag> loadedData = [];
      extractedData.forEach((bagId, bagItem) {
        loadedData.add(Bag(
            id: bagId,
            title: bagItem['title'],
            attribute: bagItem['attribute'],
            style: bagItem['style'],
            price: bagItem['price'],
            description: bagItem['description'],
            shippingInfo: bagItem['shippingInfo'],
            paymentsOptions: bagItem['paymentsOptions'],
            imageUrl: bagItem['imageUrl'],
            material: bagItem['material'],
            policy: bagItem['policy'],
            isFavorite: bagItem['isFavorite']));
      });
      List<Bag> listFavoriteBag = [];
      loadedData.forEach((bagItem) {
        if (bagItem.isFavorite == true) {
          listFavoriteBag.add(bagItem);
        }
      });
      favoriteBagItem = listFavoriteBag;
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  void clear() {
    favoriteBagItem = [];
    notifyListeners();
  }
}
