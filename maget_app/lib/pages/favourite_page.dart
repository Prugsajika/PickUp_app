import 'package:flutter/material.dart';
import 'package:maget_app/pages/home_page.dart';

import '../widgets/drawerappbar.dart';

class FavouritesPage extends StatelessWidget {
  const FavouritesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerBar(),
      appBar: AppBar(
        title: const Text('รายการโปรด'),
        backgroundColor: Colors.amber[100],
      ),
      body: GridView.count(
        crossAxisCount: 1,
        children: List.generate(10, (index) {
          return InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/6');
            },
            child: Container(
              margin: EdgeInsets.all(8.0),
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.75),
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/Hamburger.jpg'),
                    Text('Favourite ${index + 1}'),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
