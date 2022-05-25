import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_project/provider/cart.dart';
import 'package:shop_project/provider/product.dart';
import 'package:shop_project/provider/product_provider.dart';
import 'package:shop_project/view/cart_screen.dart';
import 'package:shop_project/widget/app_drawer.dart';
import 'package:shop_project/widget/badge.dart';
import 'package:shop_project/widget/gridview.dart';
import 'package:shop_project/widget/product_item.dart';

enum FilterOptions {
  Favourite,
  All,
}

class ProductOverviewScreen extends StatefulWidget {
  ProductOverviewScreen({Key? key}) : super(key: key);

  @override
  State<ProductOverviewScreen> createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  var _showOnlyFavourites = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text('shop'),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (FilterOptions selectedValue) {
              setState(
                () {
                  if (selectedValue == FilterOptions.Favourite) {
                    _showOnlyFavourites = true;
                  } else {
                    _showOnlyFavourites = false;
                  }
                },
              );
            },
            icon: Icon(
              Icons.more_vert,
            ),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('only favorites'),
                value: FilterOptions.Favourite,
              ),
              PopupMenuItem(
                child: Text('show all'),
                value: FilterOptions.All,
              ),
            ],
          ),
          Consumer<Cart>(builder: (context, cartData, child) {
            return Badge(
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(CartScreen.routeNamed);
                  },
                  icon: Icon(Icons.shopping_cart),
                ),
                value: cartData.itemCount.toString());
          })
        ],
      ),
      drawer: AppDrawer(),
      body: GridViews(_showOnlyFavourites),
    );
  }
}
