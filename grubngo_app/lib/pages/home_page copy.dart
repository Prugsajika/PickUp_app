// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:grubngo_app/models/products_model.dart';
// import 'package:grubngo_app/pages/confirmpayment.dart';
// import 'package:provider/provider.dart';

// import '../controllers/cart_controller.dart';
// import '../controllers/rider_controller.dart';
// import '../models/cartitem_model.dart';
// import '../models/riderinfo_model.dart';
// import '../services/cart_services.dart';
// import '../services/rider_service.dart';
// import 'color.dart';
// import '../models/riderinfo_model.dart';
// import '../widgets/drawerappbar.dart';
// import 'products_page.dart';
// import 'purchaseorder.dart';

// class HomePage extends StatefulWidget {
//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   List<Rider> rider = List.empty();
//   List<CartItem> cartitems = List.empty();
//   final user = FirebaseAuth.instance.currentUser!;
//   RiderController controllerR = RiderController(RiderServices());
//   CartController controller = CartController(CartServices());

//   void initState() {
//     super.initState();
//     _getEmail(context);

//     final user = FirebaseAuth.instance.currentUser!;
//     String UserEmail = user.email.toString();
//     print('user $UserEmail');
//     _getuserRider(UserEmail);
//     _getCartByEmail(UserEmail);
//   }

//   void _getuserRider(String userEmail) async {
//     print('_getuserRider : $userEmail');
//     List<Rider> rider = List.empty();
//     var userRider = await controllerR.fetchRidersByEmail(userEmail);
//     print("userRider  $userRider");
//     setState(() => rider = userRider);
//     print('_getuserRider UrlQr : ${rider.first.UrlQr}');
//     //UrlQr = rider.first.UrlQr;

//     if (!rider.isEmpty) {
//       context.read<RiderModel>()
//         ..UrlCf = rider.first.UrlCf
//         ..FirstName = rider.first.FirstName
//         ..LastName = rider.first.LastName
//         ..Gender = rider.first.Gender
//         ..TelNo = rider.first.TelNo
//         ..status = rider.first.status
//         ..idCard = rider.first.idCard
//         ..email = rider.first.email
//         ..UrlQr = rider.first.UrlQr;
//     }
//   }

//   void _getEmail(BuildContext context) async {
//     // get data  MedicalDashboard
//     context.read<emailProvider>().email = user.email!;
//   }

//   void _getCartByEmail(String emailRider) async {
//     List<CartItem> items = List.empty();
//     var usercart = await controller.fetchCartItemsByEmail(emailRider);
//     setState(() => items = usercart);
//     print('************************************');
//     print(items.length);
//     print(items.first.cartId);
//     print('emailRider $emailRider');

//     // context.read<CartItemModel>().getListCartItem = usercart;
//     context.read<CartItemModel>().getListCartItem = items;
//     print('cart chk ${context.read<CartItemModel>().Productid}');

//     // if (!cartitems.isEmpty) {
//     //   context.read<CartItemModel>()
//     //     ..cartId = cartitems.first.cartId
//     //     ..image = cartitems.first.image
//     //     ..name = cartitems.first.name
//     //     ..quantity = cartitems.first.quantity
//     //     ..cost = cartitems.first.cost
//     //     ..Productid = cartitems.first.Productid
//     //     ..customerId = cartitems.first.customerId
//     //     ..deliveryFee = cartitems.first.deliveryFee
//     //     ..totalCost = cartitems.first.totalCost
//     //     ..UrlQr = cartitems.first.UrlQr
//     //     ..confirmPayimg = cartitems.first.confirmPayimg
//     //     ..paydate = cartitems.first.paydate
//     //     ..paytime = cartitems.first.paytime
//     //     ..email = cartitems.first.email
//     //     ..buildName = cartitems.first.buildName
//     //     ..roomNo = cartitems.first.roomNo
//     //     ..status = cartitems.first.status
//     //     ..availableDate = cartitems.first.availableDate
//     //     ..availableTime = cartitems.first.availableTime
//     //     ..emailRider = cartitems.first.emailRider;
//     // }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       drawer: DrawerBar(),
//       appBar: AppBar(
//         title: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             // Padding(
//             //   padding: const EdgeInsets.all(8.0),
//             //   child: Consumer<RiderModel>(builder: (context, value, child) {
//             //     return Text('สวัสดี!!' ' : ${value.FirstName}');
//             //   }),
//             // ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Text('สวัสดี!! ' +
//                   context.read<RiderModel>().FirstName +
//                   ' ' +
//                   context.read<RiderModel>().LastName),
//             ),

//             // Text('สวัสดี!! XXXXXXXXX'),
//             IconButton(
//               onPressed: () {
//                 FirebaseAuth.instance.signOut();
//                 Navigator.pushNamed(context, '/Login');
//               },
//               icon: Icon(Icons.logout),
//             ),
//           ],
//         ),
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(15.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 Expanded(
//                   child: Card(
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           Icon(Icons.attach_money),
//                           Text(
//                             'ยอดขายทั้งหมด',
//                             style: TextStyle(
//                                 color: Colors.black,
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                           // Text(context
//                           //     .read<CartItemModel>()
//                           //     .totalCost
//                           //     .toString()),

//                           Consumer<CartItemModel>(
//                             builder: (context, CartItemModel cart, child) {
//                               return Text('${cart.totalCost}');
//                             },
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//                 //       Expanded(
//                 //         child: Card(
//                 //           child: Padding(
//                 //             padding: const EdgeInsets.all(8.0),
//                 //             child: Column(
//                 //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 //               children: [
//                 //                 Text('ยอดขายเดือนนี้'),
//                 //                 Text('0.00฿'),
//                 //               ],
//                 //             ),
//                 //           ),
//                 //         ),
//                 //       ),
//                 //     ],
//                 //   ),
//                 // ),
//                 // Padding(
//                 //   padding: const EdgeInsets.all(15.0),
//                 //   child: Row(
//                 //     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 //     children: [
//                 //       Expanded(
//                 //         child: Card(
//                 //           child: Padding(
//                 //             padding: const EdgeInsets.all(8.0),
//                 //             child: Column(
//                 //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 //               children: [
//                 //                 Text('โอนเงินแล้ว'),
//                 //                 Text('- ราย'),
//                 //               ],
//                 //             ),
//                 //           ),
//                 //         ),
//                 //       ),
//                 // Expanded(
//                 //   child: Card(
//                 //     child: Padding(
//                 //       padding: const EdgeInsets.all(8.0),
//                 //       child: Column(
//                 //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 //         children: [
//                 //           Text('รอโอนเงิน'),
//                 //           Text('- ราย'),
//                 //         ],
//                 //       ),
//                 //     ),
//                 //   ),
//                 // ),
//               ],
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Text(
//               'รายการสินค้าที่ต้องจัดส่ง',
//             ),
//           ),
//           Expanded(
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Consumer<CartItemModel>(
//                   builder: (context, CartItemModel data, child) {
//                 return data.getListCartItem.length != 0
//                     ? ListView.builder(
//                         itemCount: data.getListCartItem.length,
//                         itemBuilder: (context, index) {
//                           print(data.getListCartItem.length);

//                           return
//                               // InkWell(
//                               //   onTap: () {
//                               //     setState(() {
//                               //       context.read<CartItemModel>()
//                               //         ..cartId = cartitems[index].cartId
//                               //         ..image = cartitems[index].image
//                               //         ..name = cartitems[index].name
//                               //         ..quantity = cartitems[index].quantity
//                               //         ..cost = cartitems[index].cost
//                               //         ..Productid = cartitems[index].Productid
//                               //         ..customerId = cartitems[index].customerId
//                               //         ..deliveryFee = cartitems[index].deliveryFee
//                               //         ..totalCost = cartitems[index].totalCost
//                               //         ..UrlQr = cartitems[index].UrlQr
//                               //         ..confirmPayimg =
//                               //             cartitems[index].confirmPayimg
//                               //         ..paydate = cartitems[index].paydate
//                               //         ..paytime = cartitems[index].paytime
//                               //         ..email = cartitems[index].email
//                               //         ..buildName = cartitems[index].buildName
//                               //         ..roomNo = cartitems[index].roomNo
//                               //         ..status = cartitems[index].status
//                               //         ..availableDate =
//                               //             cartitems[index].availableDate
//                               //         ..availableTime =
//                               //             cartitems[index].availableTime
//                               //         ..emailRider = cartitems[index].emailRider;
//                               //     });
//                               //   },
//                               // );

//                               CardList(data.getListCartItem[index], index);
//                         },
//                       )
//                     : GestureDetector(
//                         child: Center(
//                           child: Text(
//                             "ไม่มีรายการสั่งซื้อ",
//                             style: TextStyle(
//                               color: Colors.black,
//                             ),
//                           ),
//                         ),
//                       );
//               }),
//             ),
//           ),
//           // Padding(
//           //   padding: const EdgeInsets.all(8.0),
//           //   child: Container(
//           //     height: 450,
//           //     child: GridView.builder(
//           //       itemCount: 10,
//           //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//           //         crossAxisCount: 1,
//           //         childAspectRatio: (6 / 2),
//           //       ),
//           //     //   itemBuilder: (context, index) => Widget(),
//           //     // ),
//           //   ),
//           // ),
//         ],
//       ),
//     );
//   }
// }

// class CardList extends StatelessWidget {
//   final CartItem carts;
//   int index;
//   CardList(this.carts, this.index);

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
//                   carts.email,
//                   maxLines: 2,
//                   overflow: TextOverflow.ellipsis,
//                   style: TextStyle(
//                       color: Colors.black54,
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold),
//                 ),
//                 Text(
//                   carts.name,
//                   maxLines: 2,
//                   overflow: TextOverflow.ellipsis,
//                   style: TextStyle(
//                       color: Colors.black54,
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold),
//                 ),
//                 Text(
//                   'ราคา ${carts.price.toString()} บาท',
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                   style: TextStyle(
//                       color: Colors.black54,
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
//                       color: Colors.black54,
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold),
//                 ),
//                 Text(
//                   'จำนวนเงินที่จ่าย ${carts.totalCost.toString()} บาท',
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                   style: TextStyle(
//                       color: Colors.black54,
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold),
//                 ),
//                 Text(
//                   'วันที่ต้องจัดส่ง ${carts.availableDate.toString()}',
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                   style: TextStyle(
//                       color: Colors.black54,
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold),
//                 ),
//                 Text(
//                   'เวลา ${carts.availableTime.toString()} น.',
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                   style: TextStyle(
//                       color: Colors.black54,
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
//           onTap: () {
//             Navigator.push(context,
//                 MaterialPageRoute(builder: (context) => ConfirmPaymentPage()));
//           },
//         ),
//       ),
//     );
//   }
// }





// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:grubngo_app/models/products_model.dart';
// import 'package:grubngo_app/pages/confirmpayment.dart';
// import 'package:provider/provider.dart';

// import '../controllers/cart_controller.dart';
// import '../controllers/rider_controller.dart';
// import '../models/cartitem_model.dart';
// import '../models/riderinfo_model.dart';
// import '../services/cart_services.dart';
// import '../services/rider_service.dart';
// import 'color.dart';
// import '../models/riderinfo_model.dart';
// import '../widgets/drawerappbar.dart';
// import 'products_page.dart';
// import 'purchaseorder.dart';

// class HomePage extends StatefulWidget {
//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   List<Rider> rider = List.empty();
//   List<CartItem> cartitems = List.empty();
//   final user = FirebaseAuth.instance.currentUser!;
//   RiderController controllerR = RiderController(RiderServices());
//   CartController controller = CartController(CartServices());

//   final _pageController = PageController();

//   bool isLoading = false;

//   void initState() {
//     super.initState();
//     _getEmail(context);

//     final user = FirebaseAuth.instance.currentUser!;
//     String UserEmail = user.email.toString();
//     print('user $UserEmail');
//     _getuserRider(UserEmail);
//     _getCartByEmail(UserEmail);
//   }

//   void _getuserRider(String userEmail) async {
//     print('_getuserRider : $userEmail');
//     List<Rider> rider = List.empty();
//     var userRider = await controllerR.fetchRidersByEmail(userEmail);
//     print("userRider  $userRider");
//     setState(() => rider = userRider);
//     print('_getuserRider UrlQr : ${rider.first.UrlQr}');
//     //UrlQr = rider.first.UrlQr;

//     if (!rider.isEmpty) {
//       context.read<RiderModel>()
//         ..UrlCf = rider.first.UrlCf
//         ..FirstName = rider.first.FirstName
//         ..LastName = rider.first.LastName
//         ..Gender = rider.first.Gender
//         ..TelNo = rider.first.TelNo
//         ..status = rider.first.status
//         ..idCard = rider.first.idCard
//         ..email = rider.first.email
//         ..UrlQr = rider.first.UrlQr;
//     }
//   }

//   void _getEmail(BuildContext context) async {
//     // get data  MedicalDashboard
//     context.read<emailProvider>().email = user.email!;
//   }

//   void _getCartByEmail(String emailRider) async {
//     List<CartItem> items = List.empty();
//     var usercart = await controller.fetchCartItemsByEmail(emailRider);
//     setState(() => items = usercart);
//     print('************************************');
//     print(items.length);
//     print(items.first.cartId);
//     print('emailRider $emailRider');

//     // context.read<CartItemModel>().getListCartItem = usercart;
//     context.read<CartItemModel>().getListCartItem = items;
//     print('cart chk ${context.read<CartItemModel>().Productid}');
//   }

//   Widget get CardList => isLoading
//       ? Center(child: CircularProgressIndicator())
//       : ListView.builder(
//           itemCount: cartitems.isNotEmpty ? cartitems.length : 1,
//           itemBuilder: (context, index) {
//             if (cartitems.isNotEmpty) {
//               return Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: InkWell(
//                   onTap: () {
//                     setState(() {
//                       context.read<CartItemModel>()
//                         ..cartId = cartitems[index].cartId
//                         ..image = cartitems[index].image
//                         ..name = cartitems[index].name
//                         ..quantity = cartitems[index].quantity
//                         ..cost = cartitems[index].cost
//                         ..Productid = cartitems[index].Productid
//                         ..customerId = cartitems[index].customerId
//                         ..deliveryFee = cartitems[index].deliveryFee
//                         ..totalCost = cartitems[index].totalCost
//                         ..UrlQr = cartitems[index].UrlQr
//                         ..confirmPayimg = cartitems[index].confirmPayimg
//                         ..paydate = cartitems[index].paydate
//                         ..paytime = cartitems[index].paytime
//                         ..email = cartitems[index].email
//                         ..buildName = cartitems[index].buildName
//                         ..roomNo = cartitems[index].roomNo
//                         ..status = cartitems[index].status
//                         ..availableDate = cartitems[index].availableDate
//                         ..availableTime = cartitems[index].availableTime
//                         ..emailRider = cartitems[index].emailRider;
//                     });
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => ConfirmPaymentPage()));
//                   },
//                   child: Container(
//                     decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.only(
//                           bottomLeft: Radius.circular(10),
//                           topLeft: Radius.circular(10),
//                         )),
//                     child: ListTile(
//                       shape: RoundedRectangleBorder(
//                         //<-- SEE HERE
//                         side: BorderSide(width: 1, color: Colors.white),
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       title: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               cartitems[index].email,
//                               maxLines: 2,
//                               overflow: TextOverflow.ellipsis,
//                               style: TextStyle(
//                                   color: Colors.black54,
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.bold),
//                             ),
//                             Text(
//                               cartitems[index].name,
//                               maxLines: 2,
//                               overflow: TextOverflow.ellipsis,
//                               style: TextStyle(
//                                   color: Colors.black54,
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.bold),
//                             ),
//                             Text(
//                               'ราคา ${cartitems[index].price.toString()} บาท',
//                               maxLines: 1,
//                               overflow: TextOverflow.ellipsis,
//                               style: TextStyle(
//                                   color: Colors.black54,
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.bold),
//                             ),
//                           ],
//                         ),
//                       ),
//                       subtitle: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               'จำนวนที่สั่ง ${cartitems[index].quantity.toString()}',
//                               maxLines: 1,
//                               overflow: TextOverflow.ellipsis,
//                               style: TextStyle(
//                                   color: Colors.black54,
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.bold),
//                             ),
//                             Text(
//                               'จำนวนเงินที่จ่าย ${cartitems[index].totalCost.toString()} บาท',
//                               maxLines: 1,
//                               overflow: TextOverflow.ellipsis,
//                               style: TextStyle(
//                                   color: Colors.black54,
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.bold),
//                             ),
//                             Text(
//                               'วันที่ต้องจัดส่ง ${cartitems[index].availableDate.toString()}',
//                               maxLines: 1,
//                               overflow: TextOverflow.ellipsis,
//                               style: TextStyle(
//                                   color: Colors.black54,
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.bold),
//                             ),
//                             Text(
//                               'เวลา ${cartitems[index].availableTime.toString()} น.',
//                               maxLines: 1,
//                               overflow: TextOverflow.ellipsis,
//                               style: TextStyle(
//                                   color: Colors.black54,
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.bold),
//                             ),
//                             Text(
//                               'สถานะ >> ${cartitems[index].status.toString()} ',
//                               maxLines: 1,
//                               overflow: TextOverflow.ellipsis,
//                               style: TextStyle(
//                                   color: Colors.blue,
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.bold),
//                             )
//                           ],
//                         ),
//                       ),

//                       leading: CircleAvatar(
//                         backgroundImage: NetworkImage(cartitems[index].image),
//                       ),
//                       // trailing: const Icon(Icons.arrow_forward_ios),
//                       onTap: () {
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => ConfirmPaymentPage()));
//                       },
//                     ),
//                   ),
//                 ),
//               );
//             } else {
//               return Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   SizedBox(
//                     height: 180,
//                   ),
//                   Text(' ไม่พบรายการบัญชีเงินกู้'),
//                 ],
//               );
//             }
//           });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       drawer: DrawerBar(),
//       appBar: AppBar(
//         title: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Text('สวัสดี!! ' +
//                   context.read<RiderModel>().FirstName +
//                   ' ' +
//                   context.read<RiderModel>().LastName),
//             ),
//             IconButton(
//               onPressed: () {
//                 FirebaseAuth.instance.signOut();
//                 Navigator.pushNamed(context, '/Login');
//               },
//               icon: Icon(Icons.logout),
//             ),
//           ],
//         ),
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(15.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 Expanded(
//                   child: Card(
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           Icon(Icons.attach_money),
//                           Text(
//                             'ยอดขายทั้งหมด',
//                             style: TextStyle(
//                                 color: Colors.black,
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                           // Text(context
//                           //     .read<CartItemModel>()
//                           //     .totalCost
//                           //     .toString()),

//                           Consumer<CartItemModel>(
//                             builder: (context, CartItemModel cart, child) {
//                               return Text('${cart.totalCost}');
//                             },
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Text(
//               'รายการสินค้าที่ต้องจัดส่ง',
//             ),
//           ),
//           Container(
//             child: PageView(
//               controller: _pageController,
//               scrollDirection: Axis.horizontal,
//               children: [CardList],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
