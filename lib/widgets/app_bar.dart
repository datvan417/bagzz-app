import 'package:flutter/material.dart';

AppBar appBar(BuildContext context, Widget widget) => AppBar(
      leading: widget,
      automaticallyImplyLeading: false,
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
            'https://www.pikpng.com/pngl/m/9-94474_png-library-download-deku-chibi-by-sciencepanda-on.png',
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 12.0),
      ],
    );
