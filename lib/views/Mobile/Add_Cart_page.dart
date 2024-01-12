import 'package:api_project/model/Cart_model.dart';
import 'package:api_project/provider/Cart_provider.dart';
import 'package:api_project/utils/Constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Add_Cart_page extends StatefulWidget {
  const Add_Cart_page({
    super.key,
  });

  @override
  State<Add_Cart_page> createState() => _Add_Cart_pageState();
}

class _Add_Cart_pageState extends State<Add_Cart_page> {
  @override
  Widget build(BuildContext context) {
    // Retrieve the cart items from the CartProvider
    List<CartItem> cartItems = context.watch<CartProvider>().cartItems;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: Container(
        constraints: const BoxConstraints.expand(),
        child: ListView.builder(
          itemCount: cartItems.length,
          itemBuilder: (context, index) {
            // Create a widget to display each cart item
            return Container(
              padding: const EdgeInsets.all(8.0),
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 50,
                    child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: imagespath + (cartItems[index].image)),
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(cartItems[index].productName),
                        Text(cartItems[index].productPrice),
                        Text(cartItems[index].quantity.toString()),
                        // Add more details or customize the display as needed
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
