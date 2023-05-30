// import 'dart:ui';

// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';

// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';

// import '../models/mycart.dart';

// class CheckOutPage extends StatefulWidget {
//   _CheckOutPageState createState() => _CheckOutPageState();
// }

// class _CheckOutPageState extends State<CheckOutPage>
//     with SingleTickerProviderStateMixin {
//   var now = DateTime.now();
//   get weekDay => DateFormat('EEEE').format(now);
//   get day => DateFormat('dd').format(now);
//   get month => DateFormat('MMMM').format(now);
//   double oldTotal = 0;
//   double total = 0;

//   ScrollController scrollController = ScrollController();
//   late AnimationController animationController;

//   onCheckOutClick(MyCart cart) async {
//     try {
//       List<Map> data = List.generate(cart.cartItems.length, (index) {
//         return {
//           "id": cart.cartItems[index].notes.Productid,
//           "quantity": cart.cartItems[index].quantity,
//         };
//       }).toList();
//     } catch (ex) {
//       print(ex.toString());
//     }
//   }

//   @override
//   void initState() {
//     animationController =
//         AnimationController(vsync: this, duration: Duration(milliseconds: 200))
//           ..forward();
//     super.initState();
//   }

//   @override
//   void dispose() {
//     animationController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     var cart = Provider.of<MyCart>(context);
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('ตะกร้าของฉัน'),
//         centerTitle: true,
//         iconTheme: IconThemeData(color: Colors.black),
//       ),
//       body: SingleChildScrollView(
//         child: Container(
//           margin: EdgeInsets.symmetric(horizontal: 16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               ...buildHeader(),
//               //cart items list
//               ListView.builder(
//                 itemCount: cart.cartItems.length,
//                 shrinkWrap: true,
//                 controller: scrollController,
//                 itemBuilder: (BuildContext context, int index) {
//                   return buildCartItemList(cart, cart.cartItems[index]);
//                 },
//               ),
//               SizedBox(height: 16),
//               Divider(),
//               buildPriceInfo(cart),
//               checkoutButton(cart, context),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   List<Widget> buildHeader() {
//     return [
//       Padding(
//         padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 0),
//         child: Text(
//           '$weekDay, ${day}th of $month ',
//         ),
//       ),
//       // FlatButton(
//       //   child: Text('+ Add to order'),
//       //   onPressed: () => Navigator.of(context).pop(),
//       // ),
//     ];
//   }

//   Widget buildPriceInfo(MyCart cart) {
//     oldTotal = total;
//     total = 0;
//     for (CartItem cart in cart.cartItems) {
//       total += cart.notes.price * cart.quantity;
//     }
//     //oldTotal = total;
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: <Widget>[
//         Text(
//           'จำนวนเงินทั้งหมด:',
//         ),
//         AnimatedBuilder(
//           animation: animationController,
//           builder: (context, child) {
//             return Text(
//               '${lerpDouble(oldTotal, total, animationController.value)?.toStringAsFixed(2)} บาท',
//             );
//           },
//         ),
//       ],
//     );
//   }

//   Widget checkoutButton(MyCart cart, context) {
//     return Container(
//       margin: EdgeInsets.only(top: 24, bottom: 64),
//       width: double.infinity,
//       child: ElevatedButton(
//         child: Text(
//           'ชำระเงิน',
//         ),
//         onPressed: () {
//           onCheckOutClick(cart);
//         },
//       ),
//     );
//   }

//   Widget buildCartItemList(MyCart cart, CartItem cartModel) {
//     return Card(
//       margin: EdgeInsets.only(bottom: 16),
//       child: Container(
//         height: 100,
//         padding: EdgeInsets.all(8),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             ClipRRect(
//               borderRadius: BorderRadius.all(Radius.circular(6)),
//               child: Image.network(
//                 '${cartModel.notes.UrlPd[0]}',
//                 fit: BoxFit.cover,
//                 width: 100,
//                 height: 100,
//               ),
//             ),
//             Flexible(
//               flex: 3,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: <Widget>[
//                   Container(
//                     height: 45,
//                     child: Text(
//                       cartModel.notes.name,
//                       textAlign: TextAlign.center,
//                     ),
//                   ),
//                   Row(
//                     mainAxisSize: MainAxisSize.max,
//                     crossAxisAlignment: CrossAxisAlignment.end,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: <Widget>[
//                       InkWell(
//                         onTap: () {
//                           cart.decreaseItem(cartModel);
//                           animationController.reset();
//                           animationController.forward();
//                         },
//                         child: Icon(Icons.remove_circle),
//                       ),
//                       Padding(
//                         padding:
//                             EdgeInsets.symmetric(horizontal: 16.0, vertical: 2),
//                         child: Text(
//                           '${cartModel.quantity}',
//                         ),
//                       ),
//                       InkWell(
//                         onTap: () {
//                           cart.increaseItem(cartModel);
//                           animationController.reset();
//                           animationController.forward();
//                         },
//                         child: Icon(Icons.add_circle),
//                       ),
//                     ],
//                   )
//                 ],
//               ),
//             ),
//             Flexible(
//               flex: 1,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: <Widget>[
//                   Container(
//                     height: 45,
//                     width: 70,
//                     child: Text(
//                       '${cartModel.notes.price} บาท',
//                       textAlign: TextAlign.end,
//                     ),
//                   ),
//                   InkWell(
//                     onTap: () {
//                       cart.removeAllInCart(cartModel.notes);
//                       animationController.reset();
//                       animationController.forward();
//                     },
//                     child: Icon(Icons.delete_sweep, color: Colors.red),
//                   )
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
