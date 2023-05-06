// import 'package:flutter/material.dart';

// class PlaceOrderPage extends StatefulWidget {
//   @override
//   _PlaceOrderPageState createState() => _PlaceOrderPageState();
// }

// class _PlaceOrderPageState extends State<PlaceOrderPage> {
//   final _formKey = GlobalKey<FormState>();
//   String _name;
//   String _address;
//   String _items;
//   String _instructions;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Place Order'),
//       ),
//       body: Form(
//         key: _formKey,
//         child: Column(
//           children: [
//             TextFormField(
//               decoration: InputDecoration(labelText: 'Name'),
//               validator: (value) {
//                 if (value.isEmpty) {
//                   return 'Please enter your name';
//                 }
//                 return null;
//               },
//               onSaved: (value) => _name = value,
//             ),
//             TextFormField(
//               decoration: InputDecoration(labelText: 'Address'),
//               validator: (value) {
//                 if (value.isEmpty) {
//                   return 'Please enter your address';
//                 }
//                 return null;
//               },
//               onSaved: (value) => _address = value,
//             ),
//             TextFormField(
//               decoration: InputDecoration(labelText: 'Items'),
//               validator: (value) {
//                 if (value.isEmpty) {
//                   return 'Please enter the items you want to order';
//                 }
//                 return null;
//               },
//               onSaved: (value) => _items = value,
//             ),
//             TextFormField(
//               decoration: InputDecoration(labelText: 'Instructions'),
//               onSaved: (value) => _instructions = value,
//             ),
//             RaisedButton(
//               child: Text('Place Order'),
//               onPressed: () {
//                 if (_formKey.currentState.validate()) {
//                   _formKey.currentState.save();
//                   // Perform order placement here
//                 }
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
