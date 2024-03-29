import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/cart_controller.dart';
import '../models/cartitem_model.dart';
import '../services/cart_services.dart';
import '../widgets/drawerappbar.dart';
import 'color.dart';
import 'order_page.dart';

class DeliveryReportPage extends StatefulWidget {
  const DeliveryReportPage({Key? key}) : super(key: key);
  @override
  State<DeliveryReportPage> createState() => _DeliveryReportPageState();
}

class _DeliveryReportPageState extends State<DeliveryReportPage> {
  CartController controller = CartController(CartServices());

  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser!;
    String UserEmail = user.email.toString();
    _getCartByEmail(UserEmail);
    setState(() {});
  }

  void _getCartByEmail(String emailRider) async {
    List<CartItem> waitorder = List.empty();
    List<CartItem> successorder = List.empty();
    List<CartItem> refundorder = List.empty();
    List<CartItem> cartitems = List.empty();
    List<CartItem> waitconfirm = List.empty();

    var Newcartitems = await controller.fetchCartItemsByEmail(emailRider);
    print('cartitemsstatusdeli ${Newcartitems.length}');
    Newcartitems.sort(
      (a, b) => a.sentDate.compareTo(b.sentDate),
    );
    cartitems = Newcartitems.reversed.toList();
    //status รอยืนยัน
    waitconfirm = cartitems.where((x) => x.status == 'รอยืนยันสลิป').toList();

    setState(() => waitconfirm = waitconfirm);

    context.read<OrderWaitConfirmStatus>().getListOrderWaitConfirmStatus =
        waitconfirm;

    //status รอจัดส่ง
    waitorder = cartitems.where((x) => x.status == 'รอจัดส่ง').toList();

    setState(() => waitorder = waitorder);

    context.read<OrderWaitSentStatus>().getListOrderWaitSentStatus = waitorder;

    //status จัดส่งสำเร็จ
    successorder = cartitems.where((x) => x.status == 'จัดส่งสำเร็จ').toList();
    setState(() => successorder = successorder);

    context.read<OrderSuccessSentStatus>().getListOrderSuccessSentStatus =
        successorder;

    //status คืนเงิน
    refundorder =
        cartitems.where((x) => x.refundStatus == 'คืนเงินสำเร็จ').toList();
    setState(() => refundorder = refundorder);

    context.read<OrderRefundStatus>().getListOrderRefundStatus = refundorder;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        drawer: DrawerBar(),
        appBar: AppBar(
          title: const Text("สถานะการจัดส่ง"),
          backgroundColor: Colors.amber,
          bottom: const TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.check_circle_outline),
                text: "รอยืนยัน",
              ),
              Tab(
                icon: Icon(Icons.watch_later_outlined),
                text: "รอจัดส่ง",
              ),
              Tab(
                icon: Icon(Icons.delivery_dining),
                text: "จัดส่งสำเร็จ",
              ),
              Tab(
                icon: Icon(Icons.money),
                text: "คืนเงิน",
              )
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Center(
              child: buildCardListWaitConfirm(context),
            ),
            Center(
              child: buildCardListWait(context),
            ),
            Center(
              child: buildCardListSuccess(context),
            ),
            Center(
              child: buildCardListRefund(context),
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildCardListWaitConfirm(BuildContext context) {
  return Scaffold(
    body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Consumer<OrderWaitConfirmStatus>(
          builder: (context, OrderWaitConfirmStatus data, child) {
        return data.getListOrderWaitConfirmStatus.length != 0
            ? ListView.builder(
                itemCount: data.getListOrderWaitConfirmStatus.length,
                itemBuilder: (context, index) {
                  print('getListOrderWaitConfirmStatus');
                  print(data.getListOrderWaitConfirmStatus.length);

                  return CardList(
                      data.getListOrderWaitConfirmStatus[index], index);
                })
            : GestureDetector(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "ไม่มีรายการที่ต้องได้รับ",
                        style: TextStyle(
                          color: iBlueColor,
                        ),
                      ),
                      ElevatedButton(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text('ดูรายการคำสั่งซื้อ'),
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

Widget buildCardListWait(BuildContext context) {
  return Scaffold(
    body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Consumer<OrderWaitSentStatus>(
          builder: (context, OrderWaitSentStatus data, child) {
        return data.getListOrderWaitSentStatus.length != 0
            ? ListView.builder(
                itemCount: data.getListOrderWaitSentStatus.length,
                itemBuilder: (context, index) {
                  print('getListOrderWaitSentStatus');
                  print(data.getListOrderWaitSentStatus.length);

                  return CardList(
                      data.getListOrderWaitSentStatus[index], index);
                })
            : GestureDetector(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "ไม่มีรายการที่ต้องจัดส่ง",
                        style: TextStyle(
                          color: iBlueColor,
                        ),
                      ),
                      ElevatedButton(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text('ดูรายการคำสั่งซื้อ'),
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

Widget buildCardListSuccess(BuildContext context) {
  return Scaffold(
    body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Consumer<OrderSuccessSentStatus>(
          builder: (context, OrderSuccessSentStatus data, child) {
        return data.getListOrderSuccessSentStatus.length != 0
            ? ListView.builder(
                itemCount: data.getListOrderSuccessSentStatus.length,
                itemBuilder: (context, index) {
                  print('getListOrderWaitSentStatus');
                  print(data.getListOrderSuccessSentStatus.length);

                  return CardList(
                      data.getListOrderSuccessSentStatus[index], index);
                })
            : GestureDetector(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "ไม่มีรายการจัดส่งสำเร็จ",
                        style: TextStyle(
                          color: iBlueColor,
                        ),
                      ),
                      ElevatedButton(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text('ดูรายการคำสั่งซื้อ'),
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

Widget buildCardListRefund(BuildContext context) {
  return Scaffold(
    body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Consumer<OrderRefundStatus>(
          builder: (context, OrderRefundStatus data, child) {
        return data.getListOrderRefundStatus.length != 0
            ? ListView.builder(
                itemCount: data.getListOrderRefundStatus.length,
                itemBuilder: (context, index) {
                  print('getListOrderWaitSentStatus');
                  print(data.getListOrderRefundStatus.length);

                  return CardListRefund(
                      data.getListOrderRefundStatus[index], index);
                })
            : GestureDetector(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "ไม่มีรายการคืนเงิน",
                        style: TextStyle(
                          color: iBlueColor,
                        ),
                      ),
                      ElevatedButton(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text('ดูรายการคำสั่งซื้อ'),
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

class CardList extends StatelessWidget {
  final CartItem carts;
  int index;
  CardList(this.carts, this.index);

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
                  carts.email,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      'จำนวน  ${carts.quantity.toString()}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
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
                      carts.deliveryLocation,
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
                      carts.buildName,
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
                      carts.roomNo,
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
          subtitle: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'วันที่ต้องจัดส่ง ${carts.availableDate.toString()}',
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
                ),
              ],
            ),
          ),
          leading: CircleAvatar(
            backgroundImage: NetworkImage(carts.image),
          ),
          onTap: () {
            print('carts ID ${carts.cartId}');
          },
        ),
      ),
    );
  }
}

class CardListRefund extends StatelessWidget {
  final CartItem carts;
  int index;
  CardListRefund(this.carts, this.index);

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
                  carts.email,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      'จำนวน  ${carts.quantity.toString()}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
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
                      carts.deliveryLocation,
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
                      carts.buildName,
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
                      carts.roomNo,
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
          subtitle: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'วันที่ต้องจัดส่ง ${carts.availableDate.toString()}',
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
                      color: Colors.red,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  'สถานะการคืนเงิน >> ${carts.refundStatus.toString()} ',
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
          onTap: () {
            print('carts ID ${carts.cartId}');
          },
        ),
      ),
    );
  }
}
