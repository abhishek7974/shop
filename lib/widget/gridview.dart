import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_project/provider/product_provider.dart';
import 'package:shop_project/widget/product_item.dart';

import '../provider/product.dart';

class GridViews extends StatelessWidget {
  final bool showFav;
  GridViews(this.showFav);

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<ProductProvider>(context);
    final product = showFav ? productData.showFav : productData.items;
    return GridView.builder(
      itemCount: product.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 3 / 2,
      ),
      itemBuilder: (context, index) => ChangeNotifierProvider.value(
        value: product[index],
        child: ProductItem(
            // prod[index].id,
            // prod[index].imageUrl,
            // prod[index].title,
            ),
      ),
    );
  }
}
