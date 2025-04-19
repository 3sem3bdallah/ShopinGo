import 'package:flutter/material.dart';
import 'package:shoppingo/screens/product.dart';
import '../utils/user_data.dart';
import '../widgets/product_card.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  void _purchaseItems(BuildContext context) {
    if (UserData.cart.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Your cart is empty!")),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Purchase successful!")),
    );

    UserData.cart.clear();
    Navigator.pop(context);
  }

  void _removeFromCart(BuildContext context, Product product) {
    UserData.cart.removeWhere((item) => item.name == product.name);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("${product.name} removed from cart")),
    );
  }

  @override
  Widget build(BuildContext context) {
    final username = UserData.username;

    // Filter to remove duplicates
    final uniqueCart = UserData.cart.fold(<Product>[], (list, product) {
      if (!list.any((item) => item.name == product.name)) {
        list.add(product);
      }
      return list;
    });

    return Scaffold(
      appBar: AppBar(title: const Text("Cart Overview")),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Username: $username",
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            const Text("Cart Items:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            const SizedBox(height: 10),
            Expanded(
              child: uniqueCart.isEmpty
                  ? const Center(child: Text("Your cart is empty."))
                  : GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                        childAspectRatio: 0.75,
                      ),
                      itemCount: uniqueCart.length,
                      itemBuilder: (context, index) {
                        final product = uniqueCart[index];
                        return Stack(
                          children: [
                            ProductCard(product: product),
                            Positioned(
                              top: 8,
                              right: 8,
                              child: IconButton(
                                icon: const Icon(Icons.remove_circle,
                                    color: Colors.red),
                                onPressed: () =>
                                    _removeFromCart(context, product),
                              ),
                            ),
                            Positioned(
                              bottom: 8,
                              right: 8,
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: Colors.black54,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  "Quantity: ${UserData.cart.where((item) => item.name == product.name).length}",
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
            ),
            if (uniqueCart.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () => _purchaseItems(context),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    backgroundColor: Colors.green,
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.shopping_cart_checkout),
                      SizedBox(width: 8),
                      Text("Buy Now", style: TextStyle(fontSize: 18)),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
