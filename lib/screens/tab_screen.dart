import 'package:bagzz/models/bag.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../models/list_bag.dart';
import '../screens/cart_screen.dart';
import '../widgets/drawer_widget.dart';
import '../widgets/app_bar.dart';
import '../screens/home_screen.dart';
import '../screens/search_screen.dart';
import '../widgets/list_favorite_bag.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  int _indexPage = 0;
  void _selectedPage(int index) {
    if (index <= 1) {
      setState(() {
        _indexPage = index;
      });
    } else {
      showModalBottomSheet(
        isScrollControlled:
            true, //true mới có thể tăng giam chieu cao cua modal bottom sheet
        context: context, backgroundColor: Colors.white.withOpacity(0.88),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(40.0),
          ),
        ),
        builder: (context) => SizedBox(
          height: MediaQuery.of(context).size.height * 0.6,
          child: index == 2 ? const FavoriteBag() : const CartScreen(),
        ),
      ).then((_) {
        setState(() {
          Provider.of<ListBagProvider>(context, listen: false).fetchAndSetBag();
        });
      });
    }
  }

  final List<Widget> listPage = [
    const HomePage(),
    const SearchScreen(),
  ];
  var _initState = true;
  var _isLoading;

  @override
  void didChangeDependencies() {
    if (_initState) {
      _isLoading = true;
      Provider.of<BagProvider>(context).fetchFavoriteData();
      Provider.of<ListBagProvider>(context).fetchAndSetBag().then((_) {
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
    return SafeArea(
      child: Scaffold(
        drawer: const DrawerWidget(),
        appBar: AppBar(
          centerTitle: false,
          titleSpacing: 0,
          iconTheme: const IconThemeData(color: Colors.black),
          elevation: 0,
          backgroundColor: Colors.white,
          title: Text(
            'bagzz',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          actions: [
            CircleAvatar(
              backgroundColor: Colors.white,
              radius: 25.0,
              child: Image.network(
                'https://i.pinimg.com/736x/4d/f9/c8/4df9c80da22c9e8b62ef4008061d4dfc.jpg',
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12.0),
          ],
        ),
        body: _isLoading
            ? const SpinKitSpinningLines(color: Colors.black)
            : SizedBox(
                height: (MediaQuery.of(context).size.height -
                    appBar(context, const Icon(Icons.menu))
                        .preferredSize
                        .height -
                    MediaQuery.of(context).padding.top),
                child: listPage[_indexPage]),
        extendBody: true,
        bottomNavigationBar: DotNavigationBar(
          currentIndex: _indexPage,
          onTap: _selectedPage,
          dotIndicatorColor: Colors.black,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              blurRadius: 4,
              offset: const Offset(3, 7),
            )
          ],
          items: [
            DotNavigationBarItem(icon: FaIcon(FontAwesomeIcons.house)),
            DotNavigationBarItem(icon: FaIcon(FontAwesomeIcons.search)),
            DotNavigationBarItem(icon: FaIcon(FontAwesomeIcons.solidHeart)),
            DotNavigationBarItem(icon: FaIcon(FontAwesomeIcons.basketShopping)),
          ],
        ),
      ),
    );
  }
}
