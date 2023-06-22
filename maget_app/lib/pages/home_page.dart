import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:maget_app/pages/findproduct.dart';
import 'package:maget_app/pages/products_page.dart';
import 'package:maget_app/pages/register_page.dart';
import 'package:provider/provider.dart';

import '../components/body.dart';
import '../controllers/customer_controller.dart';
import '../controllers/product_controller.dart';
import '../models/customer_model.dart';
import '../models/products_model.dart';
import '../services/customer_services.dart';
import '../services/product_services.dart';
import '../widgets/drawerappbar.dart';
import 'login_page.dart';
import 'favourite_page.dart';
import 'order_page.dart';
import 'productdetail_page.dart';
import 'profile_page.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;
  ProductController controller = ProductController(ProductServices());
  get delegate => Navigator.defaultRouteName;

  CustomerController custcontroller = CustomerController(CustomerServices());

  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  final searchController = TextEditingController();
  List<Product> filteredData = [];
  List<Product> data = List.empty();

  List<Product> products = List.empty();
  List<Customer> customers = List.empty();
  bool isLoading = false;

  String? _Productid;
  String _name = '';
  String _description = '';
  String _deliveryLocation = '';
  String _typeOfFood = '';
  int _price = 0;
  String _UrlPd = '';
  int _stock = 0;
  // DateTime _endDate = DateTime.now();
  // TimeOfDay _endTime = TimeOfDay.now();
  String searchvalue = "";

  void initState() {
    _getProduct(context);
    filteredData = data;
    super.initState();
    _getEmail(context);
    // context.read<ListProducts>().addAllItem(products);
    controller.onSync.listen((bool syncState) => setState(() {
          isLoading = syncState;
        }));
    final user = FirebaseAuth.instance.currentUser!;
    String UserEmail = user.email.toString();
    print('user $UserEmail');
    _getCustomer(UserEmail);
    _getproductModelInfo(_name, _description, _deliveryLocation, _typeOfFood);
    _name = context.read<ProductModel>().name;
    _Productid = context.read<ProductModel>().Productid;
    _description = context.read<ProductModel>().description;
    _deliveryLocation = context.read<ProductModel>().deliveryLocation;
    _typeOfFood = context.read<ProductModel>().typeOfFood;
    print('_name_getproductModelInfo ${context.read<ProductModel>().name}');
  }

  void _getEmail(BuildContext context) async {
    // get data  MedicalDashboard
    context.read<emailProvider>().email = user.email!;
  }

  void _getProduct(BuildContext context) async {
    var newProduct = await controller.fetchProduct();
    print('chk-- ${newProduct}');
    print('chk--product ${products}');
    setState(() => products = newProduct);
    setState(() {
      data = newProduct;
      filteredData = newProduct;
      print('chk filter $filteredData');
    });

    context.read<ProductModel>().getListProduct = newProduct;
  }

  void _getCustomer(String userEmail) async {
    print('_getCustomer : $userEmail');
    List<Customer> customer = List.empty();
    var userCustomer = await custcontroller.fetchCustomersByEmail(userEmail);
    print("userCustomer  $userCustomer");
    setState(() => customer = userCustomer);
    print('_getCustomer ID : ${customer.first.customerId}');

    if (!customer.isEmpty) {
      context.read<ProfileDetailModel>()
        ..customerId = customer.first.customerId
        ..name = customer.first.name
        ..lastName = customer.first.lastName
        ..idCard = customer.first.idCard
        ..telNo = customer.first.telNo
        ..email = customer.first.email
        ..status = customer.first.status
        ..role = customer.first.role
        ..Gender = customer.first.Gender;
    }
  }

  void _getproductModelInfo(
      String _name, _description, _deliveryLocation, _typeOfFood) async {
    var newfilteredData = await controller.fetchproductModelInfo(
        _name, _description, _deliveryLocation, _typeOfFood);
    setState(() {
      filteredData = newfilteredData;
    });
    print('_getproductModelInfo =  $newfilteredData');
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void _onSearchTextChanged(String text) {
    setState(() {
      filteredData = text.isEmpty
          ? data
          : data
              .where((item) =>
                      item.name.toLowerCase().contains(text.toLowerCase()) ||
                      item.deliveryLocation
                          .toLowerCase()
                          .contains(text.toLowerCase()) ||
                      item.sentDate
                          .toLowerCase()
                          .contains(text.toLowerCase()) ||
                      item.availableDate
                          .toLowerCase()
                          .contains(text.toLowerCase())
                  // item.namechild.toLowerCase().contains(text.toLowerCase()) ||
                  // item.namepartner.toLowerCase().contains(text.toLowerCase()) ||
                  // item.maritalstatus.toLowerCase().contains(text.toLowerCase()) ||
                  // item.submaritalstatus.toLowerCase().contains(text.toLowerCase()) ||
                  // item.status.toLowerCase().contains(text.toLowerCase())
                  )
              .toList();

      print(data);
    });
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeStyle = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'สวัสดี!! ' +
                  context.read<ProfileDetailModel>().name.toString() +
                  ' ' +
                  context.read<ProfileDetailModel>().lastName.toString(),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
        centerTitle: true,
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.shopping_cart_sharp),
            onPressed: () {
              Navigator.pushNamed(context, '/7');
              // showSearch(context: context, delegate: delegate);
            },
          ),
          // IconButton(
          //   onPressed: () {
          //     FirebaseAuth.instance.signOut();
          //     Navigator.pushNamed(context, '/Login');
          //   },
          //   icon: Icon(Icons.logout),
          // ),
        ],
      ),
      drawer: DrawerBar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 60,
              child: TextField(
                focusNode: _searchFocusNode,
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'ค้นหา...',
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.search),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FindProductPage()));
                },
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Consumer<ProductModel>(
                  builder: (context, ProductModel data, child) {
                return data.getListProduct.length != 0
                    ? ListView.builder(
                        itemCount: data.getListProduct.length,
                        itemBuilder: (context, index) {
                          return CardList(data.getListProduct[index], index);
                        })
                    : GestureDetector(
                        child: Center(
                          child: Text(
                            "ไม่มีรายการสินค้า",
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

class CardList extends StatelessWidget {
  final Product products;
  int index;
  CardList(this.products, this.index);

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
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  products.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.black54,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  'ราคา ${products.price.toString()} บาท',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.black54,
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
                  products.description,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.black54,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  products.deliveryLocation,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.black54,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  'สั่งได้ถึงวันที่ ${products.availableDate.toString()}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.black54,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  'เวลา ${products.availableTime.toString()} น.',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.black54,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),

          leading: CircleAvatar(
            backgroundImage: NetworkImage(products.UrlPd),
          ),
          // trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () {
            print(
                'check customerId ${context.read<ProfileDetailModel>().customerId}');
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        ProductDetailPage(Products: products)));
          },
        ),
      ),
    );
  }
}
