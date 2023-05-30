import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:grubngo_app/models/cartitem_model.dart';
import 'package:grubngo_app/models/products_model.dart';
import 'package:grubngo_app/models/riderinfo_model.dart';
import 'package:grubngo_app/pages/addproduct_success_page.dart';
import 'package:grubngo_app/pages/login_page.dart';
import 'package:grubngo_app/pages/register_success_page.dart';
import 'package:grubngo_app/widgets/uploadimage.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'pages/addproduct_page.dart';
import 'pages/createaccount.dart';
import 'pages/productdetail_page.dart';
import 'pages/home_page.dart';

import 'pages/profilescreen.dart';
import 'pages/register_page.dart';
import 'widgets/image_upload.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseAuth.instance.authStateChanges().listen((User? user) {
    if (user == null) {
      print('User is currently signed out!');
      //Do something when user logged out.
    } else {
      print('User is signed in!');
      //TODD to load user_profile with email from firebase_auth
    }
  });
  // runApp(const MyApp());
  runApp(MultiProvider(
    providers: [
      // ChangeNotifierProvider(
      //   create: (context) => ListProduct(),
      // ),
      ChangeNotifierProvider(
        create: (context) => RiderModel(),
      ),
      ChangeNotifierProvider(
        create: (context) => ProductModel(),
      ),
      ChangeNotifierProvider(
        create: (context) => emailProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => UrlPdProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => CartItemModel(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        scaffoldBackgroundColor: Colors.red.shade50,
      ),
      initialRoute: '/Login',
      routes: {
        '/Login': (context) => LoginPage(),
        '/home': (context) => HomePage(),
        '/2': (context) => RegisterPage(),
        '/3': (context) => RegisterSuccessPage(),
        '/4': (context) => UploadWidget(),
        '/5': (context) => AddProduct(),
        '/6': (context) => AddProductSuccessPage(),
        // '/11': (context) => ImageUploads()
        // '/6': (context) => ProductDetailPage()
      },
    );
  }
}
