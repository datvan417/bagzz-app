import '../widgets/text_button_add.dart';
import '../widgets/handle_button.dart';
import '../widgets/app_bar.dart';
import '../models/bag.dart';
import '../models/list_bag.dart';
import '../widgets/tab_bar.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class DetailItemScreen extends StatefulWidget {
  static const routeName = '/detail-item-screen';
  const DetailItemScreen({super.key});

  @override
  State<DetailItemScreen> createState() => _DetailItemScreenState();
}

class _DetailItemScreenState extends State<DetailItemScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget iconButton() {
    return IconButton(
        padding: const EdgeInsets.only(left: 5.0, right: 5.0),
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(Icons.arrow_back, size: 30.0));
  }

  @override
  Widget build(BuildContext context) {
    final _listBagData = Provider.of<ListBagProvider>(context, listen: false);
    final _idBag = (ModalRoute.of(context)!.settings.arguments
        as Map<String, String>)['bagId'];
    final _bag = _listBagData.findBag(_idBag!);

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: appBar(context, iconButton()),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12.0),
              height: MediaQuery.of(context).size.height * 0.36,
              child: Row(
                children: [
                  Expanded(
                    child: (!_bag.imageUrl.startsWith('http') &&
                            !_bag.imageUrl.startsWith('https'))
                        ? Image.asset(
                            _bag.imageUrl,
                            fit: BoxFit.fitWidth,
                          )
                        : Image.network(
                            _bag.imageUrl,
                            fit: BoxFit.fitWidth,
                          ),
                  ),
                  const SizedBox(
                    width: 15.0,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Consumer<BagProvider>(
                          builder: (context, _bagItem, child) => Container(
                            margin: const EdgeInsets.only(left: 130.0),
                            child: IconButton(
                              color: Colors.black,
                              onPressed: () =>
                                  _bagItem.updateFavoriteBagHomeScreen(_bag),
                              icon: Icon(
                                _bag.isFavorite
                                    ? Icons.favorite
                                    : Icons.favorite_border_outlined,
                                size: 28,
                              ),
                            ),
                          ),
                        ),
                        Text(
                          _bag.title,
                          style: const TextStyle(
                            fontFamily: 'PlayfairDisplay',
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(
                          height: 4.0,
                        ),
                        Text(
                          _bag.attribute,
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(fontSize: 16.0, color: Colors.black),
                        ),
                        Text(
                          _bag.style,
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(
                                  fontSize: 14.0,
                                  color: const Color(0xFF848484)),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 9.0, bottom: 15.0),
                          child: Text(
                            '\$${_bag.price.toStringAsFixed(0)}',
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium!
                                .copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black),
                          ),
                        ),
                        HandleButton(
                            label: 'BUY NOW',
                            textColor: Colors.white,
                            backgroundColor: Colors.black,
                            fontSize: 14.0,
                            function: () {}),
                        TextButtonAddItem(
                          bagItem: _bag,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.6 -
                  appBar(context, iconButton()).preferredSize.height -
                  MediaQuery.of(context).padding.top,
              child: Column(
                children: [
                  SizedBox(
                    height: 40.0,
                    child: TabBar(
                        controller: _tabController,
                        indicatorSize: TabBarIndicatorSize.tab,
                        unselectedLabelColor: Colors.grey,
                        indicatorColor: Colors.black,
                        labelStyle: Theme.of(context)
                            .textTheme
                            .displayMedium!
                            .copyWith(
                                fontSize: 14.0, fontWeight: FontWeight.w700),
                        isScrollable: true,
                        tabs: const [
                          Tab(
                            text: 'Description',
                          ),
                          Tab(
                            text: 'Shipping info',
                          ),
                          Tab(
                            text: 'Payment options',
                          ),
                        ]),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(
                        left: 12.0,
                        right: 12.0,
                        top: 25.0,
                      ),
                      child: TabBarWidget(
                        bag: _bag,
                        tabController: _tabController,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
