import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:maget_app/controllers/cart_controller.dart';
import 'package:maget_app/models/cartitem_model.dart';

import 'package:maget_app/services/cart_services.dart';
import 'package:provider/provider.dart';

import '../widgets/drawerappbar.dart';
import 'processpayment_page.dart';

class OrderPage extends StatefulWidget {
  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  CartController controller = CartController(CartServices());
  final user = FirebaseAuth.instance.currentUser!;
  // List<CartItem> cartitems = List.empty();

  String get cartId => context.read<CartItemModel>().cartId;

  @override
  void initState() {
    super.initState();

    final user = FirebaseAuth.instance.currentUser!;
    String UserEmail = user.email.toString();
    print('user $UserEmail');
    _getCartByEmail(UserEmail);
  }

  void _getCartByEmail(String userEmail) async {
    // List<CartItem> items = List.empty();
    List<CartItem> waitconfirm = List.empty();
    List<CartItem> cartitems = List.empty();

    var Newcartitems = await controller.fetchCartItemsByEmail(userEmail);
    print('waitconfirm cartitem ${Newcartitems.length}');
    setState(() => cartitems = Newcartitems);

    // status รอยืนยัน
    waitconfirm = cartitems
        .where((x) =>
            x.status == 'รอยืนยันสลิป' ||
            x.status == 'จำนวนเงินไม่ถูกต้อง' ||
            x.status == 'สลิปไม่ถูกต้อง' ||
            x.status == 'ไม่พบรายการโอนเงิน' ||
            x.status == 'อื่นๆ')
        .toList();

    setState(() => waitconfirm = waitconfirm);

    context.read<CartItemWaitConfirm>().getListCartItemWaitConfirm =
        waitconfirm;

    // context.read<CartItemWaitConfirm>().getListCartItemWaitConfirm =
    //     waitconfirm;
    //รอถาม จะทำดึง status payment เพื่อใช้ใน if ที่จะแสดง card list ต่างกัน
    // var confirmPayment = await controller.fetchStatusPaymentByCartId(cartId);
    // int CconfirmPayment = confirmPayment.length;
    // print('chk pay ${CconfirmPayment}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerBar(),
      appBar: AppBar(
        title: const Text('สถานะการชำระเงิน'),
        backgroundColor: Colors.amber,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<CartItemWaitConfirm>(
            builder: (context, CartItemWaitConfirm data, child) {
          print(data.status + ' Order page');
          return data.getListCartItemWaitConfirm.length != 0
              ? ListView.builder(
                  itemCount: data.getListCartItemWaitConfirm.length,
                  itemBuilder: (context, index) {
                    print(data.getListCartItemWaitConfirm.length);

                    // if (data.status == 'ยืนยันสลิปแล้ว') {
                    //   print('order page.status ${data.status}');
                    //   return CardListSuccess(
                    //       data.getListCartItem[index], index);
                    // } else {
                    //   return CardListNotSuccess(
                    //       data.getListCartItem[index], index);
                    // }

                    return CardList(
                        data.getListCartItemWaitConfirm[index], index);
                  })
              : GestureDetector(
                  child: Center(
                    child: Column(
                      children: [
                        Text(
                          "ไม่มีรายการสั่งซื้อรอยืนยัน",
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        ElevatedButton(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text('ดูสถานะการจัดส่ง'),
                              ],
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => OrderPage()));
                          },
                        ),
                      ],
                    ),
                  ),
                );
        }),
      ),
    );
  }
}

class CardList extends StatelessWidget {
  final CartItem carts;
  int index;
  CardList(this.carts, this.index);

  @override
  Widget build(BuildContext context) {
    if (carts.status != 'จำนวนเงินไม่ถูกต้อง' &&
        carts.status != 'สลิปไม่ถูกต้อง' &&
        carts.status != 'ไม่พบรายการโอนเงิน' &&
        carts.status != 'อื่นๆ') {
      return Padding(
        padding: const EdgeInsets.all(2.0),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                topLeft: Radius.circular(10),
              )),
          child: ListTile(
            shape: RoundedRectangleBorder(
              //<-- SEE HERE
              side: BorderSide(width: 1, color: Colors.white),
              borderRadius: BorderRadius.circular(10),
            ),
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    carts.nameProduct,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'ราคา ${carts.price.toString()} บาท',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'จำนวนที่สั่ง ${carts.quantity.toString()}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'จำนวนเงินที่จ่าย ${carts.totalCost.toString()} บาท',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'วันที่คาดว่าจะได้รับ ${carts.availableDate.toString()}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'เวลา ${carts.availableTime.toString()} น.',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'สถานะ >> ${carts.status.toString()} ',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.green,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),

            leading: CircleAvatar(
              backgroundImage: NetworkImage(carts.image),
            ),
            // trailing: const Icon(Icons.arrow_forward_ios),
          ),
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(2.0),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                topLeft: Radius.circular(10),
              )),
          child: ListTile(
            shape: RoundedRectangleBorder(
              //<-- SEE HERE
              side: BorderSide(width: 1, color: Colors.white),
              borderRadius: BorderRadius.circular(10),
            ),
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    carts.nameProduct,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'ราคา ${carts.price.toString()} บาท',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'จำนวนที่สั่ง ${carts.quantity.toString()}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'จำนวนเงินที่จ่าย ${carts.totalCost.toString()} บาท',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'วันที่คาดว่าจะได้รับ ${carts.availableDate.toString()}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'เวลา ${carts.availableTime.toString()} น.',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'สถานะ >> ${carts.status.toString()} ',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),

            leading: CircleAvatar(
              backgroundImage: NetworkImage(carts.image),
            ),
            // trailing: const Icon(Icons.arrow_forward_ios),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProcessPaymentPage(Carts: carts)));
            },
          ),
        ),
      );
    }
  }
}

// class CardListSuccess extends StatelessWidget {
//   final CartItem carts;
//   int index;
//   CardListSuccess(this.carts, this.index);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(2.0),
//       child: Container(
//         decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.only(
//               bottomLeft: Radius.circular(10),
//               topLeft: Radius.circular(10),
//             )),
//         child: ListTile(
//           shape: RoundedRectangleBorder(
//             //<-- SEE HERE
//             side: BorderSide(width: 1, color: Colors.white),
//             borderRadius: BorderRadius.circular(10),
//           ),
//           title: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   carts.nameProduct,
//                   maxLines: 2,
//                   overflow: TextOverflow.ellipsis,
//                   style: TextStyle(
//                       color: Colors.black,
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold),
//                 ),
//                 Text(
//                   'ราคา ${carts.price.toString()} บาท',
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                   style: TextStyle(
//                       color: Colors.black,
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold),
//                 ),
//               ],
//             ),
//           ),
//           subtitle: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'จำนวนที่สั่ง ${carts.quantity.toString()}',
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                   style: TextStyle(
//                       color: Colors.black,
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold),
//                 ),
//                 Text(
//                   'จำนวนเงินที่จ่าย ${carts.totalCost.toString()} บาท',
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                   style: TextStyle(
//                       color: Colors.black,
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold),
//                 ),
//                 Text(
//                   'วันที่คาดว่าจะได้รับ ${carts.availableDate.toString()}',
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                   style: TextStyle(
//                       color: Colors.black,
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold),
//                 ),
//                 Text(
//                   'เวลา ${carts.availableTime.toString()} น.',
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                   style: TextStyle(
//                       color: Colors.black,
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold),
//                 ),
//                 Text(
//                   'สถานะ >> ${carts.status.toString()} ',
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                   style: TextStyle(
//                       color: Colors.blue,
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold),
//                 )
//               ],
//             ),
//           ),

//           leading: CircleAvatar(
//             backgroundImage: NetworkImage(carts.image),
//           ),
//           // trailing: const Icon(Icons.arrow_forward_ios),
//           // trailing: const Icon(Icons.arrow_forward_ios),
//           // onTap: () {
//           //   Navigator.push(
//           //       context,
//           //       MaterialPageRoute(
//           //           builder: (context) => ProcessPaymentPage(Carts: carts)));
//           // },
//         ),
//       ),
//     );
//   }
// }
