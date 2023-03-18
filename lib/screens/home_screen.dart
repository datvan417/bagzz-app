import '../screens/all_bag.dart';
import '../data/image_data.dart';
import '../widgets/category_grid.dart';
import '../widgets/bag_item.dart';
import '../models/list_bag.dart';
import '../widgets/label_review.dart';
import '../widgets/handle_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home-screen';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final _gridCategory = [
      {
        'name': 'Handle bags',
        'image': gridCategoryImage[0],
      },
      {
        'name': 'Crossbody bags',
        'image': gridCategoryImage[1],
      },
      {
        'name': 'Shoulder bags',
        'image': gridCategoryImage[2],
      },
      {
        'name': 'Tote bag',
        'image': gridCategoryImage[3],
      },
    ];

    final _bagItem = Provider.of<ListBagProvider>(context).itemsHomePage;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
              child: const LabelReivew(),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.67,
              child: GridView.builder(
                itemCount: _bagItem.length,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.8,
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 15,
                ),
                itemBuilder: (context, index) => ChangeNotifierProvider.value(
                  value: _bagItem[index],
                  child: BagItem(),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 1.05,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: HandleButton(
                      label: 'CHECK All LATEST',
                      backgroundColor: Colors.white,
                      function: () {
                        Navigator.pushNamed(context, AllBagScreen.routeName);
                      },
                      textColor: Colors.black,
                      fontSize: 16.0,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                        top: 48.0, bottom: 24.0, left: 11.0),
                    child: Text(
                      'Shop by categories',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(fontSize: 24.0),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: GridView.builder(
                      itemCount: _bagItem.length,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.758,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 24,
                      ),
                      itemBuilder: (_, index) =>
                          CategoryWidget(categoryData: _gridCategory[index]),
                    ),
                  ),
                  Center(
                    child: HandleButton(
                      label: 'BROWSE ALL CATEGORIES',
                      backgroundColor: Colors.white,
                      function: () {},
                      textColor: Colors.black,
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
