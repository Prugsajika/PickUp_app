import 'package:flutter/material.dart';
import 'package:grubngo_app/controllers/cart_controller.dart';
import 'package:grubngo_app/services/cart_services.dart';
import 'package:provider/provider.dart';

import '../controllers/product_controller.dart';
import '../models/cartitem_model.dart';
import '../models/products_model.dart';
import '../models/riderinfo_model.dart';
import '../services/product_services.dart';
import 'color.dart';
import 'product_edit_page.dart';
import 'purchaseorder_page.dart';
import 'purchaseordernotcomplete_page.dart';
import 'statusdelivery_page.dart';

class PurchaseOrderListPage extends StatefulWidget {
  const PurchaseOrderListPage(
      {super.key, required this.Products, required this.Indexs});
  final OrderByProduct Products;
  final int Indexs;

  @override
  State<PurchaseOrderListPage> createState() => _PurchaseOrderListPageState();
}

class _PurchaseOrderListPageState extends State<PurchaseOrderListPage> {
  ProductController controller = ProductController(ProductServices());
  CartController controllerCart = CartController(CartServices());

  @override
  void initState() {
    super.initState();
    _getOrderByProductid(widget.Products.Productid);
    setState(() {});
  }

  void _getOrderByProductid(String Productid) async {
    var newcarts = await controllerCart.fetchOrderByProductid(Productid);

    print('chk ${newcarts.length}');

    context.read<CartItemPerProductModel>().getListCartItemPerProduct =
        newcarts;
    print('provider ${context.read<CartItemPerProductModel>().Productid}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.Products.nameProduct),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<CartItemPerProductModel>(
            builder: (context, CartItemPerProductModel data, child) {
          return data.getListCartItemPerProduct.length != 0
              ? ListView.builder(
                  itemCount: data.getListCartItemPerProduct.length,
                  itemBuilder: (context, index) {
                    print('data');
                    print(data.getListCartItemPerProduct.length);

                    return CardList(
                        data.getListCartItemPerProduct[index], index);
                  })
              : GestureDetector(
                  child: Center(
                      child: Text(
                  "ไม่มีรายการสินค้า",
                  style: TextStyle(
                    color: iBlueColor,
                  ),
                )));
        }),
      ),
    );
  }
}

class CardList extends StatefulWidget {
  final CartItemPerProduct carts;
  int index;
  CardList(this.carts, this.index);

  @override
  State<CardList> createState() => _CardListState();
}

class _CardListState extends State<CardList> {
  CartController cartcontroller = CartController(CartServices());

  String? _chosenValue;

  void _updateOrderStatus(String cartId, status) async {
    cartcontroller.updatePaystatus(cartId, status);
    setState(() {});
    print('chk confirm pty####' + cartId);
  }

  void _RejectPayStatus() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: Text("ยกเลิกรายการสั่งซื้อ"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text('กรุณาเลือกเหตุผล'),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DropdownButton<String>(
                      hint: Text(
                        'เลือกเหตุผล',
                      ),
                      value: _chosenValue,
                      underline: Container(),
                      items: <String>[
                        'ร้านปิด',
                        'ของหมด',
                        'อื่นๆ',
                      ].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: new Text(
                            value,
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newVal) {
                        setState(() {
                          _chosenValue = newVal!;
                        });
                      },
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                    onPressed: () {
                      _updateOrderStatus(
                          widget.carts.cartId, 'ยกเลิกเพราะ $_chosenValue');
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  PurchaseOrderNotCompletePage(
                                    Carts: widget.carts,
                                  )));

                      // print(
                      //     'สลิปไม่ถูกต้อง ${context.read<CartItemModel>().cartId}');
                      // _updatePayStatus(widget.Carts.cartId, 'สลิปไม่ถูกต้อง');
                    },
                    child: const Text(
                      "ตกลง",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              topLeft: Radius.circular(10),
            )),
        child: Column(
          children: [
            ListTile(
              // value: statusBL,
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
                    Row(
                      children: [
                        Text(
                          'ผู้สั่งซื้อ : ',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          widget.carts.email,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'จำนวนที่สั่ง : ',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          widget.carts.quantity.toString(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'สถานที่จัดส่ง : ',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          widget.carts.deliveryLocation,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'จุดรับของตึก/หมู่บ้าน: ',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          widget.carts.buildName,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'เลขที่บ้าน/เลขห้อง : ',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          widget.carts.roomNo,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              onTap: () {},
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.green),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Icon(Icons.check),
                          Text('ยืนยันรายการ'),
                        ],
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => StatusDeliveryPage()));

                      print(
                          'ยืนยันสลิปแล้ว ${context.read<CartItemModel>().cartId}');
                      _updateOrderStatus(widget.carts.cartId, "รอจัดส่ง");
                    },
                  ),
                  ElevatedButton(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Icon(Icons.close),
                          Text('ยกเลิกรายการ'),
                        ],
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        _RejectPayStatus();
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
    // return Padding(
    //   padding: const EdgeInsets.all(2.0),
    //   child: Container(
    //     decoration: BoxDecoration(
    //         color: Colors.white,
    //         borderRadius: BorderRadius.only(
    //           bottomLeft: Radius.circular(10),
    //           topLeft: Radius.circular(10),
    //         )),
    //     child: ListTile(
    //       shape: RoundedRectangleBorder(
    //         //<-- SEE HERE
    //         side: BorderSide(width: 1, color: Colors.white),
    //         borderRadius: BorderRadius.circular(10),
    //       ),
    //       title: Padding(
    //         padding: const EdgeInsets.all(8.0),
    //         child: Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             Text(
    //               carts.email,
    //               maxLines: 2,
    //               overflow: TextOverflow.ellipsis,
    //               style: TextStyle(
    //                   color: Colors.black,
    //                   fontSize: 16,
    //                   fontWeight: FontWeight.bold),
    //             ),
    //             Text(
    //               carts.nameProduct,
    //               maxLines: 2,
    //               overflow: TextOverflow.ellipsis,
    //               style: TextStyle(
    //                   color: Colors.black,
    //                   fontSize: 16,
    //                   fontWeight: FontWeight.bold),
    //             ),
    //             Text(
    //               'ราคา ${carts.price.toString()} บาท',
    //               maxLines: 1,
    //               overflow: TextOverflow.ellipsis,
    //               style: TextStyle(
    //                   color: Colors.black,
    //                   fontSize: 16,
    //                   fontWeight: FontWeight.bold),
    //             ),
    //           ],
    //         ),
    //       ),
    //       // subtitle: Padding(
    //       //   padding: const EdgeInsets.all(8.0),
    //       //   child: Column(
    //       //     mainAxisAlignment: MainAxisAlignment.start,
    //       //     crossAxisAlignment: CrossAxisAlignment.start,
    //       //     children: [
    //       //       Text(
    //       //         'จำนวนที่สั่ง ${carts.quantity.toString()}',
    //       //         maxLines: 1,
    //       //         overflow: TextOverflow.ellipsis,
    //       //         style: TextStyle(
    //       //             color: Colors.black,
    //       //             fontSize: 16,
    //       //             fontWeight: FontWeight.bold),
    //       //       ),
    //       //       Text(
    //       //         'จำนวนเงินที่จ่าย ${carts.totalCost.toString()} บาท',
    //       //         maxLines: 1,
    //       //         overflow: TextOverflow.ellipsis,
    //       //         style: TextStyle(
    //       //             color: Colors.black,
    //       //             fontSize: 16,
    //       //             fontWeight: FontWeight.bold),
    //       //       ),
    //       //       Text(
    //       //         'วันที่ต้องจัดส่ง ${carts.availableDate.toString()}',
    //       //         maxLines: 1,
    //       //         overflow: TextOverflow.ellipsis,
    //       //         style: TextStyle(
    //       //             color: Colors.black,
    //       //             fontSize: 16,
    //       //             fontWeight: FontWeight.bold),
    //       //       ),
    //       //       Text(
    //       //         'เวลา ${carts.availableTime.toString()} น.',
    //       //         maxLines: 1,
    //       //         overflow: TextOverflow.ellipsis,
    //       //         style: TextStyle(
    //       //             color: Colors.black,
    //       //             fontSize: 16,
    //       //             fontWeight: FontWeight.bold),
    //       //       ),
    //       //       Text(
    //       //         'สถานะ >> ${carts.status.toString()} ',
    //       //         maxLines: 1,
    //       //         overflow: TextOverflow.ellipsis,
    //       //         style: TextStyle(
    //       //             color: Colors.blue,
    //       //             fontSize: 16,
    //       //             fontWeight: FontWeight.bold),
    //       //       )
    //       //     ],
    //       //   ),
    //       // ),

    //       // leading: CircleAvatar(
    //       //   backgroundImage: NetworkImage(carts.image),
    //       // ),
    //       // // trailing: const Icon(Icons.arrow_forward_ios),
    //       // onTap: () {
    //       //   // print('#######################carts ID ${carts.cartId}');
    //       //   // Navigator.push(
    //       //   //     context,
    //       //   //     MaterialPageRoute(
    //       //   //         builder: (context) => ConfirmPaymentPage(Carts: carts)));
    //       // },
    //     ),
    //   ),
    // );
  }
}
