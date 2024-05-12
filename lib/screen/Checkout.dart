import 'package:flutter/material.dart';
import '../model/Item.dart';
import "package:provider/provider.dart";
import "../provider/shoppingcart_provider.dart";

class Checkout extends StatefulWidget {
  const Checkout({super.key});

 @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {

bool _cartEmpty = true;

  @override
  void didChangeDependencies() {      // Check if the cart is not empty, then set _cartEmpty to false
    super.didChangeDependencies();
    _cartEmpty = context.watch<ShoppingCart>().cart.isEmpty;
  }

Widget computeCost() {
return Consumer<ShoppingCart>(builder: (context, cart, child) {
return Text("Total Cost to pay: ${cart.cartTotal}");
});
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Checkout")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Item Details"),
          checkoutItems(context),
          const Divider(height: 4, color: Colors.black),
          Flexible(
                  child: Center(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Visibility(
                        visible: !_cartEmpty,
                        child: computeCost()),
                            Visibility(
                        visible: !_cartEmpty,
                        child: ElevatedButton(
                        onPressed: () {
                          context.read<ShoppingCart>().removeAll();
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Payment Successful!"),
                            duration: Duration(seconds: 1, milliseconds: 100),
                          ));
                          
                        },
                        child: const Text("Pay Now"))),
                ]))),
          TextButton(
            child: const Text("Go back to Product Catalog"),
            onPressed: () {
              Navigator.pop(context, "/products");
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  Widget checkoutItems(BuildContext context) {
    List<Item> products = context.watch<ShoppingCart>().cart;
    return products.isEmpty
        ? const Text('No items to checkout!')
        : Expanded(
            child: Column(
            children: [
              Flexible(
                  child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: const Icon(Icons.food_bank),
                    title: Text(products[index].name),
                    trailing: Text(
                      products[index].price.toString(), 
                    ),
                  );
    
                },
              )),
              ],
          ));
  }
 
}