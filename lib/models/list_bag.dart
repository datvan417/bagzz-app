import 'dart:convert';
import '../models/bag.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class ListBagProvider with ChangeNotifier {
  List<Bag> _listBag = [
    // Bag(
    //   id: 'us1',
    //   title: 'Artsy',
    //   attribute: 'Wallet with chain',
    //   style: 'Style #36252 0YK0G 1000',
    //   price: 564,
    //   description:
    //       'As in handbags, the double ring and bar design defines the wallet shape, highlighting the front flap closure which is tucked inside the hardware. Completed with an organizational interior, the black leather wallet features a detachable chain.',
    //   shippingInfo:
    //       'Pre-order, Made to Order and DIY items will ship on the estimated date noted on the product description page. These items will ship through Premium Express once they become available.',
    //   paymentsOptions:
    //       'We accepts the following forms of payment for online purchases:\n \nPayPal may not be used to purchase Made to Order Décor or DIY items.\n \nThe full transaction value will be charged to your credit card after we have verified your card details, received credit authorisation, confirmed availability and prepared your order for shipping. For Made To Order, DIY, personalised and selected Décor products, payment will be taken at the time the order is placed.',
    //   imageUrl: 'assets/images/bags_images/Artsy.png',
    //   material:
    //       'All products are made with carefully selected materials. Please handle with care for longer product life.\n- Protect from direct light, heat and rain. Should it become wet, dry it immediately with a soft cloth\n- Store in the provided flannel bag or box\n- Clean with a soft, dry cloth',
    //   policy:
    //       'Returns may be made by mail or in store. The return window for online purchases is 30 days (10 days in the case of beauty items) from the date of delivery. You may return products by mail using the complimentary prepaid return label included with your order, and following the return instructions provided in your digital invoice.',
    //   isFavorite: false,
    // ),
    // Bag(
    //   id: 'us2',
    //   title: 'Berkely',
    //   attribute: 'Wallet with chain',
    //   style: 'Style #36252 0YK0G 1000',
    //   price: 564,
    //   description:
    //       'As in handbags, the double ring and bar design defines the wallet shape, highlighting the front flap closure which is tucked inside the hardware. Completed with an organizational interior, the black leather wallet features a detachable chain.',
    //   shippingInfo:
    //       'Pre-order, Made to Order and DIY items will ship on the estimated date noted on the product description page. These items will ship through Premium Express once they become available.',
    //   paymentsOptions:
    //       'We accepts the following forms of payment for online purchases:\n \nPayPal may not be used to purchase Made to Order Décor or DIY items.\n \nThe full transaction value will be charged to your credit card after we have verified your card details, received credit authorisation, confirmed availability and prepared your order for shipping. For Made To Order, DIY, personalised and selected Décor products, payment will be taken at the time the order is placed.',
    //   imageUrl: 'assets/images/bags_images/Berkely.png',
    //   material:
    //       'All products are made with carefully selected materials. Please handle with care for longer product life.\n- Protect from direct light, heat and rain. Should it become wet, dry it immediately with a soft cloth\n- Store in the provided flannel bag or box\n- Clean with a soft, dry cloth',
    //   policy:
    //       'Returns may be made by mail or in store. The return window for online purchases is 30 days (10 days in the case of beauty items) from the date of delivery. You may return products by mail using the complimentary prepaid return label included with your order, and following the return instructions provided in your digital invoice.',
    //   isFavorite: false,
    // ),
    // Bag(
    //   id: 'us3',
    //   title: 'Capucinus',
    //   attribute: 'Wallet with chain',
    //   style: 'Style #36252 0YK0G 1000',
    //   price: 564,
    //   description:
    //       'As in handbags, the double ring and bar design defines the wallet shape, highlighting the front flap closure which is tucked inside the hardware. Completed with an organizational interior, the black leather wallet features a detachable chain.',
    //   shippingInfo:
    //       'Pre-order, Made to Order and DIY items will ship on the estimated date noted on the product description page. These items will ship through Premium Express once they become available.',
    //   paymentsOptions:
    //       'We accepts the following forms of payment for online purchases:\n \nPayPal may not be used to purchase Made to Order Décor or DIY items.\n \nThe full transaction value will be charged to your credit card after we have verified your card details, received credit authorisation, confirmed availability and prepared your order for shipping. For Made To Order, DIY, personalised and selected Décor products, payment will be taken at the time the order is placed.',
    //   imageUrl: 'assets/images/bags_images/Capucinus.png',
    //   material:
    //       'All products are made with carefully selected materials. Please handle with care for longer product life.\n- Protect from direct light, heat and rain. Should it become wet, dry it immediately with a soft cloth\n- Store in the provided flannel bag or box\n- Clean with a soft, dry cloth',
    //   policy:
    //       'Returns may be made by mail or in store. The return window for online purchases is 30 days (10 days in the case of beauty items) from the date of delivery. You may return products by mail using the complimentary prepaid return label included with your order, and following the return instructions provided in your digital invoice.',
    //   isFavorite: false,
    // ),
    // Bag(
    //   id: 'us4',
    //   title: 'Monogram',
    //   attribute: 'Wallet with chain',
    //   style: 'Style #36252 0YK0G 1000',
    //   price: 564,
    //   description:
    //       'As in handbags, the double ring and bar design defines the wallet shape, highlighting the front flap closure which is tucked inside the hardware. Completed with an organizational interior, the black leather wallet features a detachable chain.',
    //   shippingInfo:
    //       'Pre-order, Made to Order and DIY items will ship on the estimated date noted on the product description page. These items will ship through Premium Express once they become available.',
    //   paymentsOptions:
    //       'We accepts the following forms of payment for online purchases:\n \nPayPal may not be used to purchase Made to Order Décor or DIY items.\n \nThe full transaction value will be charged to your credit card after we have verified your card details, received credit authorisation, confirmed availability and prepared your order for shipping. For Made To Order, DIY, personalised and selected Décor products, payment will be taken at the time the order is placed.',
    //   imageUrl: 'assets/images/bags_images/Monogram.png',
    //   material:
    //       'All products are made with carefully selected materials. Please handle with care for longer product life.\n- Protect from direct light, heat and rain. Should it become wet, dry it immediately with a soft cloth\n- Store in the provided flannel bag or box\n- Clean with a soft, dry cloth',
    //   policy:
    //       'Returns may be made by mail or in store. The return window for online purchases is 30 days (10 days in the case of beauty items) from the date of delivery. You may return products by mail using the complimentary prepaid return label included with your order, and following the return instructions provided in your digital invoice.',
    //   isFavorite: false,
    // ),
  ];

  List<Bag> get items {
    return [..._listBag];
  }

  List<Bag> get itemsHomePage {
    return [
      ...[
        _listBag[0],
        _listBag[1],
        _listBag[2],
        _listBag[3],
      ]
    ];
  }

  Bag findBag(String id) {
    return _listBag.firstWhere((element) => element.id == id);
  }

  //get data from firebase
  Future<void> fetchAndSetBag() async {
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
      _listBag = loadedData;
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  //create data in Firebase
  Future<void> addBag(Bag bagItem) async {
    final url =
        Uri.parse('https://bagzz-app-default-rtdb.firebaseio.com/bags.json');
    try {
      final respone = await http.post(
        url,
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
          'isFavorite': bagItem.isFavorite
        }),
      );

      final newBag = Bag(
        id: jsonDecode(respone.body)['name'],
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
      );
      _listBag.add(newBag);
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> updateBag(String id, Bag bagItem) async {
    var bagIndex = _listBag.indexWhere((bag) => bag.id == id);
    if (bagIndex >= 0) {
      var url = Uri.parse(
          'https://bagzz-app-default-rtdb.firebaseio.com/bags/$id.json');
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
            'isFavorite': bagItem.isFavorite
          }));
      _listBag[bagIndex] = bagItem;
      notifyListeners();
    } else {
      print('error...');
    }
  }

  Future<void> removeBag(String id) async {
    final url = Uri.parse(
        'https://bagzz-app-default-rtdb.firebaseio.com/bags/$id.json');
    final bagIndex = _listBag.indexWhere((bag) => bag.id == id);
    if (bagIndex >= 0) {
      await http.delete(url);
      _listBag.removeAt(bagIndex);
      notifyListeners();
    } else {
      print('error...');
    }
  }

  Future<void> clearFavorite(List<Bag> favoriteBags) async {
    try {
      favoriteBags.forEach((bagItem) async {
        var url = Uri.parse(
            'https://bagzz-app-default-rtdb.firebaseio.com/bags/${bagItem.id}.json');
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
              'isFavorite': false,
            }));
      });
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }
}
