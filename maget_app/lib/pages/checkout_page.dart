import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:intl/intl.dart';
import 'package:maget_app/models/cartitem_model.dart';
import 'package:maget_app/models/customer_model.dart';
import 'package:maget_app/pages/payment_page.dart';
import 'package:provider/provider.dart';

import '../controllers/cart_controller.dart';
import '../models/mycart.dart';
import '../services/cart_services.dart';

class CheckOutPage extends StatefulWidget {
  _CheckOutPageState createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage>
    with SingleTickerProviderStateMixin {
  var now = DateTime.now();
  get weekDay => DateFormat('EEEE').format(now);
  get day => DateFormat('dd').format(now);
  get month => DateFormat('MMMM').format(now);
  double oldTotal = 0;
  double total = 0;

  ScrollController scrollController = ScrollController();
  late AnimationController animationController;
  CartController cartcontroller = CartController(CartServices());

  // onCheckOutClick(MyCart cart) async {
  //   try {
  //     List<Map> data = List.generate(cart.cartItems.length, (index) {
  //       return {
  //         "id": cart.cartItems[index].notes.Productid,
  //         "quantity": cart.cartItems[index].quantity,
  //       };
  //     }).toList();
  //   } catch (ex) {
  //     print(ex.toString());
  //   }
  // }

  String customerId = '';

  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200))
          ..forward();
    super.initState();
    customerId = context.read<ProfileDetailModel>().customerId;
  }

  // void _addtoCart(String image, name, Productid, customerId, int quantity, cost,
  //     price, deliveryFee, totalCost) async {
  //   cartcontroller.addCart(image, name, Productid, customerId, quantity, cost,
  //       price, deliveryFee, totalCost);
  // }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var cart = Provider.of<CartItemModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('ตะกร้าของฉัน'),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ...buildHeader(),
              Card(
                margin: EdgeInsets.only(bottom: 16),
                child: Container(
                  height: 100,
                  padding: EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                        child: Consumer<CartItemModel>(
                            builder: (context, value, child) {
                          return Image.network(
                            '${value.image}',
                            fit: BoxFit.cover,
                            width: 100,
                            height: 100,
                          );
                        }),
                      ),
                      Flexible(
                        flex: 3,
                        child: Column(
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              height: 45,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Consumer<CartItemModel>(
                                    builder: (context, value, child) {
                                  return Row(
                                    children: [
                                      Text(
                                        '${value.name}',
                                        textAlign: TextAlign.end,
                                      )
                                    ],
                                  );
                                }),
                              ),
                            ),
                            Row(
                              // mainAxisSize: MainAxisSize.max,
                              // crossAxisAlignment: CrossAxisAlignment.end,
                              // mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Consumer<CartItemModel>(
                                      builder: (context, value, child) {
                                    return Row(
                                      children: [
                                        Text(
                                          'จำนวนทั้งหมด ',
                                          textAlign: TextAlign.end,
                                        ),
                                        Text(
                                          ' ${value.quantity}',
                                          textAlign: TextAlign.end,
                                        ),
                                      ],
                                    );
                                  }),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              height: 45,
                              width: 70,
                              child: Consumer<CartItemModel>(
                                  builder: (context, value, child) {
                                return Row(
                                  children: [
                                    Text(
                                      '${value.price} บาท',
                                      textAlign: TextAlign.end,
                                    )
                                  ],
                                );
                              }),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),
              Divider(),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'รวมค่าสินค้า:',
                      ),
                      Consumer<CartItemModel>(builder: (context, value, child) {
                        return Row(
                          children: [Text('${value.cost}')],
                        );
                      }),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'รวมค่าหิ้ว:',
                      ),
                      Consumer<CartItemModel>(builder: (context, value, child) {
                        return Row(
                          children: [Text('${value.deliveryFee}')],
                        );
                      }),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'รวมทั้งหมด:',
                      ),
                      Consumer<CartItemModel>(builder: (context, value, child) {
                        return Row(
                          children: [Text('${value.totalCost}')],
                        );
                      }),
                    ],
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 24, bottom: 64),
                width: double.infinity,
                child: ElevatedButton(
                  child: Text(
                    'ยืนยันการสั่งซื้อ',
                  ),
                  onPressed: () {
                    // _addtoCart(
                    //     context.read<CartItemModel>().image,
                    //     context.read<CartItemModel>().name,
                    //     context.read<CartItemModel>().Productid,
                    //     context.read<CartItemModel>().customerId,
                    //     context.read<CartItemModel>().quantity,
                    //     context.read<CartItemModel>().cost,
                    //     context.read<CartItemModel>().price,
                    //     context.read<CartItemModel>().deliveryFee,
                    //     context.read<CartItemModel>().totalCost);
                    print(
                        'test custId : ${context.read<CartItemModel>().customerId}');
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => PaymentPage()));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> buildHeader() {
    return [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 0),
        child: Text(
          '$weekDay, ${day}th of $month ',
        ),
      ),
      // FlatButton(
      //   child: Text('+ Add to order'),
      //   onPressed: () => Navigator.of(context).pop(),
      // ),
    ];
  }

  // Widget buildPriceInfo(BuildContext context) {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //     children: <Widget>[
  //       Text(
  //         'จำนวนเงินทั้งหมด:',
  //       ),
  //       Consumer<CartItemModel>(builder: (context, value, child) {
  //         return Row(
  //           children: [Text('${value.cost}')],
  //         );
  //       }),
  //     ],
  //   );
  // }

  // Widget checkoutButton(MyCart cart, context) {
  //   return Container(
  //     margin: EdgeInsets.only(top: 24, bottom: 64),
  //     width: double.infinity,
  //     child: ElevatedButton(
  //       child: Text(
  //         'ชำระเงิน',
  //       ),
  //       onPressed: () {
  //         onCheckOutClick(cart);
  //       },
  //     ),
  //   );
  // }

//   Widget buildCartItemList(CartItemModel cart, CartItem cartModel) {
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
//                 '${cartModel.image}',
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
//                       cartModel.name,
//                       textAlign: TextAlign.center,
//                     ),
//                   ),
//                   Row(
//                     mainAxisSize: MainAxisSize.max,
//                     crossAxisAlignment: CrossAxisAlignment.end,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: <Widget>[
//                       // InkWell(
//                       //   onTap: () {
//                       //     cart.decreaseItem(cartModel);
//                       //     animationController.reset();
//                       //     animationController.forward();
//                       //   },
//                       //   child: Icon(Icons.remove_circle),
//                       // ),
//                       Padding(
//                         padding:
//                             EdgeInsets.symmetric(horizontal: 16.0, vertical: 2),
//                         child: Text(
//                           '${cartModel.quantity}',
//                         ),
//                       ),
//                       // InkWell(
//                       //   onTap: () {
//                       //     cart.increaseItem(cartModel);
//                       //     animationController.reset();
//                       //     animationController.forward();
//                       //   },
//                       //   child: Icon(Icons.add_circle),
//                       // ),
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
//                       '${cartModel.price} บาท',
//                       textAlign: TextAlign.end,
//                     ),
//                   ),
//                   // InkWell(
//                   //   onTap: () {
//                   //     cart.removeAllInCart(cartModel.notes);
//                   //     animationController.reset();
//                   //     animationController.forward();
//                   //   },
//                   //   child: Icon(Icons.delete_sweep, color: Colors.red),
//                   // )
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
}
