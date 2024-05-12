import 'package:flutter/material.dart';
import '../model/Item.dart';
import "package:provider/provider.dart";
import "../provider/shoppingcart_provider.dart";

class Checkout extends StatelessWidget {
  const Checkout({super.key});


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
          checkoutItems(context),
          computeCost(),
          const Divider(height: 4, color: Colors.black),
          Flexible(
                  child: Center(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                    ElevatedButton(
                        onPressed: () {
                          context.read<ShoppingCart>().removeAll();
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Payment Successful!"),
                            duration: Duration(seconds: 1, milliseconds: 100),
                          ));
                          
                        },
                        child: const Text("Pay Now")),
                ]))),
          TextButton(
            child: const Text("Go back to Product Catalog"),
            onPressed: () {
              Navigator.pushNamed(context, "/products");
            },
          ),
        ],
      ),
    );
  }

  Widget checkoutItems(BuildContext context) {
    List<Item> products = context.watch<ShoppingCart>().cart;
    String productname = "";
    return products.isEmpty
        ? const Text('Item Details!')
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
