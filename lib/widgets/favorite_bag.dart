import '../models/bag.dart';
import 'package:flutter/material.dart';

class FavoriteBagWidget extends StatelessWidget {
  const FavoriteBagWidget(
      {required this.bagData, required this.widget, super.key});
  final Bag bagData;
  final Widget widget;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.transparent,
      child: Column(
        children: [
          Row(
            children: [
              (!bagData.imageUrl.startsWith('http') &&
                      !bagData.imageUrl.startsWith('https'))
                  ? Image.asset(
                      bagData.imageUrl,
                      height: 100,
                      width: 100,
                    )
                  : Image.network(
                      bagData.imageUrl,
                      height: 100,
                      width: 100,
                    ),

              // Image.asset(
              //   bagData.imageUrl,
              //   height: 100,
              //   width: 100,
              // ),
              const SizedBox(width: 15.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    bagData.title,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontSize: 20.0),
                  ),
                  const SizedBox(height: 5.0),
                  Text(
                    bagData.attribute,
                    style: Theme.of(context)
                        .textTheme
                        .displayMedium!
                        .copyWith(fontSize: 16.0, color: Colors.black),
                  ),
                  Text(
                    bagData.style,
                    style: Theme.of(context).textTheme.displayMedium!.copyWith(
                        fontSize: 14.0, color: const Color(0xFF848484)),
                  ),
                  widget
                ],
              ),
            ],
          ),
          const Divider(
            height: 48.0,
            thickness: 1.0,
            color: Colors.black,
            endIndent: 5.0,
          ),
        ],
      ),
    );
  }
}
