import 'package:flutter/material.dart';

class CategoryWidget extends StatelessWidget {
  final categoryData;
  const CategoryWidget({required this.categoryData, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 170,
      width: 224,
      child: Stack(
        children: [
          (!categoryData['image'].startsWith('http') &&
                  !categoryData['image'].startsWith('https'))
              ? Image.asset(
                  categoryData['image'],
                  fit: BoxFit.cover,
                )
              : Image.network(
                  categoryData['image'],
                  fit: BoxFit.cover,
                ),
          // Image.asset(
          //   categoryData['image'],
          //   fit: BoxFit.cover,
          // ),
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
              color: Colors.black,
              child: Text(
                categoryData['name'],
                style: const TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                  fontFamily: 'PlayfairDisplay',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
