import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shop_project/controller.dart/auth_controller.dart';
import 'package:shop_project/provider/cart.dart';
import 'package:shop_project/provider/orders.dart';
import 'package:shop_project/provider/product_provider.dart';
import 'package:shop_project/view/cart_screen.dart';
import 'package:shop_project/view/edit_product.dart';
import 'package:shop_project/view/order_screen.dart';
import 'package:shop_project/view/product_detail.dart';

import 'package:provider/provider.dart';
import 'package:shop_project/view/product_overview_screen.dart';
import 'package:shop_project/view/screen/login.dart';
import 'package:shop_project/view/screen/sign_up.dart';
import 'package:shop_project/view/user_product.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) {
    Get.put(AuthController());
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => ProductProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Orders(),
        ),
      ],
      child: GetMaterialApp(
        theme: ThemeData(
          fontFamily: 'Lato',
          primarySwatch: Colors.purple,
          colorScheme: ColorScheme.fromSwatch().copyWith(
            secondary: Colors.deepOrange,
          ),
        ),
        home: LoginScreen(),
        routes: {
          ProductDetailScreen.routeName: (context) => ProductDetailScreen(),
          CartScreen.routeNamed: (context) => CartScreen(),
          OrdersScreen.routeName: (context) => OrdersScreen(),
          UserProductsScreen.routeName: (context) => UserProductsScreen(),
          EditProductScreen.routeName: (context) => EditProductScreen(),
        },
      ),
    );
  }
}
