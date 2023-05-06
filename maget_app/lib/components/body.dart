import 'dart:ui';

import 'package:flutter/material.dart';

import '../pages/home_page.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Explore",
                style: Theme.of(context)
                    .textTheme
                    .headline4!
                    .copyWith(fontWeight: FontWeight.w500, color: Colors.black),
              ),
              const Text(
                "best delivery for you",
                style: TextStyle(fontSize: 18),
              ),
              // SingleChildScrollView(
              //   scrollDirection: Axis.horizontal,
              //   child: Padding(
              //     padding: const EdgeInsets.all(8.0),
              //     child: Row(
              //       children: List.generate(
              //         5,
              //         (index) => CatagoryCard(
              //           icon: 'launcher/icon.png',
              //           title: 'Fast Food',
              //           press: () {},
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
        SliverGrid(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.75,
          ),
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) => ItemCard(),
            childCount: 10,
          ),
        ),
      ],
    );
  }
}

class ItemCard extends StatelessWidget {
  const ItemCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Container(
            padding: EdgeInsets.all(8.0),
            height: 180,
            width: 160,
            decoration: BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Image.asset('assets/images/Grilled.jpg'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            'หมูปิ้งเจ้มอย',
            style: TextStyle(color: Colors.black),
          ),
        ),
        Text(
          "\20 บาท",
          style: TextStyle(fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
