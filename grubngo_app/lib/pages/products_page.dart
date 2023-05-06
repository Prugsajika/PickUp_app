import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grubngo_app/pages/productdetail_page.dart';

import 'package:provider/provider.dart';

import '../controllers/product_controller.dart';
import '../models/products_model.dart';
import '../services/product_services.dart';
import '../widgets/drawerappbar.dart';
import 'color.dart';

class ProductsPage extends StatefulWidget {
  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  final user = FirebaseAuth.instance.currentUser!;
  List<Product> products = List.empty();
  String searchvalue = "";

  ProductController controller = ProductController(ProductServices());

  @override
  void initState() {
    super.initState();
    _getProduct(context);
  }

  void _getProduct(BuildContext context) async {
    var newProduct = await controller.fetchbyuser();
    print('chk ${newProduct}');

    context.read<ProductModel>().getListProduct = newProduct;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerBar(),
      appBar: AppBar(
        title: Text('สินค้า'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<ProductModel>(
            builder: (context, ProductModel data, child) {
          return data.getListProduct.length != 0
              ? ListView.builder(
                  itemCount: data.getListProduct.length,
                  itemBuilder: (context, index) {
                    print(data.getListProduct.length);

                    return CardList(data.getListProduct[index], index);
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/5');
        },
        backgroundColor: Colors.red[500],
        child: const Icon(Icons.add),
      ),
    );
  }
}

class CardList extends StatelessWidget {
  final Product notes;
  int index;
  CardList(this.notes, this.index);

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
          title: Text(
            notes.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                color: Colors.black54,
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            notes.description,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                color: Colors.black54,
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
          leading: CircleAvatar(
            backgroundImage: NetworkImage(notes.UrlPd),
          ),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProductDetailPage(Notes: notes)));
          },
        ),
      ),
    );
  }
}
