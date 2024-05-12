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

bool _cartEmpty = true; // set as true initially since you start with no items in shopping cart

  @override
  void didChangeDependencies() {      // Check if the cart is not empty, then set _cartEmpty to false
    super.didChangeDependencies();
    _cartEmpty = context.watch<ShoppingCart>().cart.isEmpty;
  }

Widget computeCost() {                // computes the cost of the total items in cart
return Consumer<ShoppingCart>(builder: (context, cart, child) {
return Text("Total Cost to pay: ${cart.cartTotal}");
});
}

  @override
  Widget build(BuildContext context) {    // builds the main scaffold of checkout screen
    return Scaffold(
      appBar: AppBar(title: const Text("Checkout")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Item Details"),
          checkoutItems(context),   // runs checkoutItems widget
          const Divider(height: 4, color: Colors.black),
          Flexible(
                  child: Center(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Visibility( // will show computeCost method if cart is not empty
                        visible: !_cartEmpty,
                        child: computeCost()),
                            Visibility( // will allow the user to pay now if cart is not empty, otherwise it will be hidden
                        visible: !_cartEmpty,
                        child: ElevatedButton(
                        onPressed: () {
                          context.read<ShoppingCart>().removeAll(); // removes all items in shopping list once all items are purchased
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Payment Successful!"),   // prompt message at snackbar for a specified duration
                            duration: Duration(seconds: 1, milliseconds: 100),
                          ));
                          
                        },
                        child: const Text("Pay Now"))),
                ]))),
          TextButton(
            child: const Text("Go back to Product Catalog"),   // button which routes you back to the MyCatalog screen
            onPressed: () {
              Navigator.pop(context, "/products");
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  Widget checkoutItems(BuildContext context) {    // checkoutItems widget
    List<Item> products = context.watch<ShoppingCart>().cart;
    return products.isEmpty
        ? const Text('No items to checkout!')   // this message will prompt if the shopping cart is empty
        : Expanded(
            child: Column(
            children: [
              Flexible(
                  child: ListView.builder(    // will list down the items in shopping cart along with its specific price on the right
                itemCount: products.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: const Icon(Icons.food_bank),
                    title: Text(products[index].name),
                    trailing: Text(
                      products[index].price.toString(),   // converts the price to text
                    ),
                  );
    
                },
              )),
              ],
          ));
  }
 
}