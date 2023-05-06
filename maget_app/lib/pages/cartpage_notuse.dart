import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<String> _items = [];
  double _totalPrice = 0.0;

  void _addItem(String item, double price) {
    setState(() {
      _items.add(item);
      _totalPrice += price;
    });
  }

  void _removeItem(String item, double price) {
    setState(() {
      _items.remove(item);
      _totalPrice -= price;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _items.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_items[index]),
                  trailing: IconButton(
                    icon: Icon(Icons.remove_circle),
                    onPressed: () => _removeItem(_items[index], 0.0),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(16.0),
            child: Text('Total: \$$_totalPrice'),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_shopping_cart),
        onPressed: () => _addItem('Item', 0.0),
      ),
    );
  }
}
