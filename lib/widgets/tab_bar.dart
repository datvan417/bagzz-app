import 'package:flutter/material.dart';
import '../models/bag.dart';

class TabBarWidget extends StatelessWidget {
  const TabBarWidget({
    super.key,
    required Bag bag,
    required TabController tabController,
  })  : _bag = bag,
        _tabController = tabController;

  final Bag _bag;
  final TabController _tabController;

  @override
  Widget build(BuildContext context) {
    TextStyle styleText = Theme.of(context).textTheme.displayMedium!.copyWith(
          fontSize: 14.0,
          color: const Color(0XFF5B5B5B),
          wordSpacing: 1.6,
          height: 1.6,
        );
    return TabBarView(
      controller: _tabController,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _bag.description,
              textAlign: TextAlign.justify,
              style: styleText,
            ),
            Container(
              margin: const EdgeInsets.only(top: 35.0, bottom: 5.0),
              child: Text(
                'Material & care',
                style: Theme.of(context).textTheme.displayMedium!.copyWith(
                    fontSize: 14.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ),
            ),
            Text(
              _bag.material,
              style: styleText,
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _bag.shippingInfo,
              textAlign: TextAlign.justify,
              style: styleText,
            ),
            Container(
              margin: const EdgeInsets.only(top: 25.0, bottom: 5.0),
              child: Text(
                'Return policy',
                style: Theme.of(context).textTheme.displayMedium!.copyWith(
                    fontSize: 14.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ),
            ),
            Text(
              _bag.policy,
              style: styleText,
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _bag.paymentsOptions,
              textAlign: TextAlign.justify,
              style: styleText,
            ),
          ],
        ),
      ],
    );
  }
}
