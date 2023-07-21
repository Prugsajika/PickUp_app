import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grubngo_app/models/products_model.dart';
import 'package:grubngo_app/pages/confirmpayment.dart';
import 'package:provider/provider.dart';

import '../controllers/cart_controller.dart';
import '../controllers/rider_controller.dart';
import '../models/cartitem_model.dart';
import '../models/riderinfo_model.dart';
import '../services/cart_services.dart';
import '../services/rider_service.dart';
import 'color.dart';
import '../models/riderinfo_model.dart';
import '../widgets/drawerappbar.dart';
import 'products_page.dart';
import 'purchaseorder_page.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Rider> rider = List.empty();
  List<CartItem> cartitems = List.empty();

  final user = FirebaseAuth.instance.currentUser!;
  RiderController controllerR = RiderController(RiderServices());
  CartController controller = CartController(CartServices());

  int countstatusComplete = 0;
  int countstatusWait = 0;

  void initState() {
    super.initState();

    final user = FirebaseAuth.instance.currentUser!;
    String UserEmail = user.email.toString();
    print('user $UserEmail');
    _getuserRider(UserEmail);
    _getCartByEmail(UserEmail);
    _getCartItemsCount(UserEmail);
  }

  void _getuserRider(String userEmail) async {
    print('_getuserRider : $userEmail');
    List<Rider> rider = List.empty();
    var userRider = await controllerR.fetchRidersByEmail(userEmail);
    print("userRider  $userRider");
    setState(() => rider = userRider);
    print('_getuserRider UrlQr : ${rider.first.UrlQr}');

    if (!rider.isEmpty) {
      context.read<RiderModel>()
        ..UrlCf = rider.first.UrlCf
        ..FirstName = rider.first.FirstName
        ..LastName = rider.first.LastName
        ..Gender = rider.first.Gender
        ..TelNo = rider.first.TelNo
        ..statusBL = rider.first.statusBL
        ..idCard = rider.first.idCard
        ..email = rider.first.email
        ..UrlQr = rider.first.UrlQr;
    }
  }

  void _getCartItemsCount(String UserEmail) async {
    var Successcartitems =
        await controller.fetchCartItemsSuccessByEmail(UserEmail);

    var statusComplete = Successcartitems;
    int countstatusCompletes = 0;

    Successcartitems.forEach((b) {
      countstatusCompletes += int.parse(b.totalCost.toString());

      // if (a.name == b.department) {
      // if (b.status == "อนุมัติ") {
      //   a.amountApprove += int.parse(b.payamount);
      // } else if (b.status == "ร้องขอ") {
      //   a.amountRequest += int.parse(b.receiptamount);
      // } else {
      //   a.amountReject += int.parse(b.receiptamount);
      // }
      // }
    });
    print('countstatusComplete ${countstatusComplete}');
    setState(() {
      countstatusComplete = countstatusCompletes;
    });

    var Waitcartitems = await controller.fetchCartItemsWaitByEmail(UserEmail);
    var statusWait = Waitcartitems;
    int countstatusWaits = 0;

    Waitcartitems.forEach((b) {
      countstatusWaits += int.parse(b.totalCost.toString());

      // if (a.name == b.department) {
      // if (b.status == "อนุมัติ") {
      //   a.amountApprove += int.parse(b.payamount);
      // } else if (b.status == "ร้องขอ") {
      //   a.amountRequest += int.parse(b.receiptamount);
      // } else {
      //   a.amountReject += int.parse(b.receiptamount);
      // }
      // }
    });
    print('countstatusWait ${countstatusWait}');
    setState(() {
      countstatusWait = countstatusWaits;
    });
  }

  void _getCartByEmail(String emailRider) async {
    List<CartItem> waitcart = List.empty();

    var cartitems = await controller.fetchCartItemsByEmail(emailRider);
    waitcart = cartitems.where((x) => x.status == 'รอยืนยันสลิป').toList();
    setState(() => waitcart = waitcart);
    print('emailRider $emailRider');

    context.read<CartItemWaitStatusModel>().getListCartItemWaitStatus =
        waitcart;
    print('cart chk ${context.read<CartItemWaitStatusModel>().cartId}');

    // if (!cartitems.isEmpty) {
    //   context.read<CartItemModel>()
    //     ..cartId = cartitems.first.cartId
    //     ..image = cartitems.first.image
    //     ..name = cartitems.first.name
    //     ..quantity = cartitems.first.quantity
    //     ..cost = cartitems.first.cost
    //     ..Productid = cartitems.first.Productid
    //     ..customerId = cartitems.first.customerId
    //     ..deliveryFee = cartitems.first.deliveryFee
    //     ..totalCost = cartitems.first.totalCost
    //     ..UrlQr = cartitems.first.UrlQr
    //     ..confirmPayimg = cartitems.first.confirmPayimg
    //     ..paydate = cartitems.first.paydate
    //     ..paytime = cartitems.first.paytime
    //     ..email = cartitems.first.email
    //     ..buildName = cartitems.first.buildName
    //     ..roomNo = cartitems.first.roomNo
    //     ..status = cartitems.first.status
    //     ..availableDate = cartitems.first.availableDate
    //     ..availableTime = cartitems.first.availableTime
    //     ..emailRider = cartitems.first.emailRider;
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerBar(),
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('สวัสดี!! ' +
                  context.read<RiderModel>().FirstName +
                  ' ' +
                  context.read<RiderModel>().LastName),
            ),
            IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Navigator.pushNamed(context, '/Login');
              },
              icon: Icon(Icons.logout),
            ),
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'ยอดขายทั้งหมด',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      child: Container(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                'จัดส่งสำเร็จ',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    countstatusComplete.toString(),
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    ' บาท',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      child: Container(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                'รอจัดส่ง',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    countstatusWait.toString(),
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    ' บาท',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'รายการคำสั่งซื้อรอยืนยัน',
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Consumer<CartItemWaitStatusModel>(
                  builder: (context, CartItemWaitStatusModel data, child) {
                return data.getListCartItemWaitStatus.length != 0
                    ? ListView.builder(
                        itemCount: data.getListCartItemWaitStatus.length,
                        itemBuilder: (context, index) {
                          print(data.getListCartItemWaitStatus.length);

                          return CardList(
                              data.getListCartItemWaitStatus[index], index);
                        },
                      )
                    : GestureDetector(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "ไม่มีรายการคำสั่งซื้อรอยืนยัน",
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
                                  setState(() {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                PurchaseOrderPage()));
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                        // child: Center(
                        //   child: Text(
                        //     "ไม่มีรายการคำสั่งซื้อรอยืนยัน",
                        //     style: TextStyle(
                        //       color: Colors.black,
                        //     ),
                        //   ),
                        // ),
                      );
              }),
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Container(
          //     height: 450,
          //     child: GridView.builder(
          //       itemCount: 10,
          //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //         crossAxisCount: 1,
          //         childAspectRatio: (6 / 2),
          //       ),
          //     //   itemBuilder: (context, index) => Widget(),
          //     // ),
          //   ),
          // ),
        ],
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
                )
              ],
            ),
          ),

          leading: CircleAvatar(
            backgroundImage: NetworkImage(carts.image),
          ),
          // trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () {
            print('#######################carts ID ${carts.cartId}');
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ConfirmPaymentPage(Carts: carts)));
          },
        ),
      ),
    );
  }
}
