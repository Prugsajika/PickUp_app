// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:maget_app/pages/products_page.dart';
// import 'package:maget_app/pages/register_page.dart';
// import 'package:provider/provider.dart';

// import '../components/body.dart';
// import '../controllers/product_controller.dart';
// import '../models/customer_model.dart';
// import '../models/products_model.dart';
// import '../services/product_services.dart';
// import '../widgets/drawerappbar.dart';
// import 'login_page.dart';
// import 'favourite_page.dart';
// import 'orderhistory_page.dart';
// import 'productdetail_page.dart';
// import 'profile_page.dart';

// class HomePage extends StatefulWidget {
//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   final user = FirebaseAuth.instance.currentUser!;
//   ProductController controller = ProductController(ProductServices());
//   get delegate => Navigator.defaultRouteName;

//   List<Product> products = List.empty();
//   bool isLoading = false;

//   String? _Productid;
//   String _name = '';
//   String _description = '';
//   int _price = 0;
//   String _UrlPd = '';
//   int _stock = 0;
//   DateTime _endDate = DateTime.now();
//   TimeOfDay _endTime = TimeOfDay.now();

//   void initState() {
//     _getEmail(context);
//     _getProduct(context);
//     super.initState();
//     context.read<ListProducts>().addAllItem(products);
//     controller.onSync.listen((bool syncState) => setState(() {
//           isLoading = syncState;
//         }));
//   }

//   void _getEmail(BuildContext context) async {
//     // get data  MedicalDashboard
//     context.read<emailProvider>().email = user.email!;
//   }

//   void _getProduct(BuildContext context) async {
//     var newProduct = await controller.fetchProduct();
//     print('chk ${newProduct}');
//     setState(() => products = newProduct);

//     // context.read<ProductModel>().getListProduct = newProduct;
//   }

//   @override
//   Widget build(BuildContext context) {
//     final ThemeData themeStyle = Theme.of(context);

//     return Scaffold(
//       appBar: AppBar(
//         title: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               'สวัสดี!! ' + context.read<emailProvider>().email.toString(),
//               style: Theme.of(context).textTheme.bodyText1,
//             ),
//           ],
//         ),
//         centerTitle: true,
//         elevation: 0,
//         actions: <Widget>[
//           IconButton(
//             icon: const Icon(Icons.shopping_cart_sharp),
//             onPressed: () {
//               showSearch(context: context, delegate: delegate);
//             },
//           ),
//           // IconButton(
//           //   onPressed: () {
//           //     FirebaseAuth.instance.signOut();
//           //     Navigator.pushNamed(context, '/Login');
//           //   },
//           //   icon: Icon(Icons.logout),
//           // ),
//         ],
//       ),
//       drawer: DrawerBar(),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             "Explore",
//             style: Theme.of(context)
//                 .textTheme
//                 .headline4!
//                 .copyWith(fontWeight: FontWeight.w500, color: Colors.black),
//           ),
//           const Text(
//             "best delivery for you",
//             style: TextStyle(fontSize: 18),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Consumer<ListProducts>(
//                 builder: (context, ListProducts data, child) {
//               return data.products.length != 0
//                   ? ListView.builder(
//                       itemCount: data.products.length,
//                       itemBuilder: (context, index) {
//                         print(data.products.length);

//                         return CardList(data.products[index], index);
//                       })
//                   : GestureDetector(
//                       child: Center(
//                           child: Text(
//                       "ไม่มีรายการสินค้า",
//                       style: TextStyle(
//                         color: Colors.amber,
//                       ),
//                     )));
//             }),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class CardList extends StatelessWidget {
//   final Product notes;
//   int index;
//   CardList(this.notes, this.index);

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
//           title: Text(
//             notes.name,
//             maxLines: 1,
//             overflow: TextOverflow.ellipsis,
//             style: TextStyle(
//                 color: Colors.black54,
//                 fontSize: 16,
//                 fontWeight: FontWeight.bold),
//           ),
//           subtitle: Text(
//             notes.description,
//             maxLines: 1,
//             overflow: TextOverflow.ellipsis,
//             style: TextStyle(
//                 color: Colors.black54,
//                 fontSize: 16,
//                 fontWeight: FontWeight.bold),
//           ),
//           leading: CircleAvatar(
//             backgroundImage: NetworkImage(notes.UrlPd),
//           ),
//           // trailing: const Icon(Icons.arrow_forward_ios),
//           onTap: () {
//             Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) => ProductDetailPage(Notes: notes)));
//           },
//         ),
//       ),
//     );
//   }
// }



// // class CatagoryCard extends StatelessWidget {
// //   const CatagoryCard({
// //     Key? key,
// //     required this.icon,
// //     required this.title,
// //     required this.press,
// //   }) : super(key: key);

// //   final String icon, title;
// //   final VoidCallback press;

// //   @override
// //   Widget build(BuildContext context) {
// //     return OutlinedButton(
// //       onPressed: press,
// //       style: OutlinedButton.styleFrom(
// //         shape: RoundedRectangleBorder(
// //           borderRadius: BorderRadius.all(
// //             Radius.circular(20.0),
// //           ),
// //         ),
// //       ),
// //       child: Padding(
// //         padding:
// //             const EdgeInsets.symmetric(horizontal: 8.0 / 4, vertical: 8.0 / 2),
// //         child: Column(
// //           children: [
// //             Image.asset('assets/images/FastFood.jpg'),
// //             const SizedBox(
// //               height: 50 / 2,
// //             ),
// //             Text(
// //               title,
// //               style: Theme.of(context).textTheme.subtitle2,
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }