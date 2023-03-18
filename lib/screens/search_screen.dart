import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  static const routeName = '/search-screen';
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        IconButton(
          icon: const Icon(
            Icons.close,
            size: 25,
          ),
          padding: EdgeInsets.all(15.0),
          onPressed: () {},
        ),
        Container(
          padding: const EdgeInsets.only(left: 17.0, right: 17.0),
          child: const TextField(
            style: TextStyle(
              fontFamily: 'WorkSans',
              fontSize: 20.0,
              fontWeight: FontWeight.w400,
            ),
            decoration: InputDecoration(
              hintText: 'Type here to search',
              hintStyle: TextStyle(
                fontFamily: 'WorkSans',
                fontSize: 21.0,
                fontWeight: FontWeight.w400,
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 2),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
